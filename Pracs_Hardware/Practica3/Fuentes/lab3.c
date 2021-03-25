#include <stdio.h>
#include "xgpio_l.h"
#include "xparameters.h"
 



#define LCD_BASEADDR XPAR_LCD_IP_0_BASEADDR
#define INIT_DELAY 1000 //usec delay timer during initialization, important to change if clock speed changes
#define INST_DELAY 500 //usec delay timer between instructions
#define DATA_DELAY 250 //usec delay timer between data
 

 

//==============================================================================
//
//								INTERNAL FUNCTIONS
//
//==============================================================================


void usleep(unsigned int delay)
{
unsigned int j, i; 

for(i=0; i<delay; i++)
   for(j=0; j<26; j++);
}

void XromInitInst(void)
{
		XGpio_WriteReg(LCD_BASEADDR, 1, 0x00000003);
		usleep(1);
		XGpio_WriteReg(LCD_BASEADDR, 1, 0x00000043); //set enable and data
		usleep(1);
		XGpio_WriteReg(LCD_BASEADDR, 1, 0x00000003);
		usleep(INIT_DELAY);
}

void XromWriteInst(unsigned long inst1, unsigned long inst2)
{
	
	unsigned long printinst;

	printinst = 0x00000040 | inst1;
	
	XGpio_WriteReg(LCD_BASEADDR, 1, inst1); //write data
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, printinst); //set enable
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, inst1); //turn off enable
	usleep(1);
	
	printinst = 0x00000040 | inst2;

	XGpio_WriteReg(LCD_BASEADDR, 1, printinst); //set enable and data
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, inst2); //turn off enable

	usleep(INST_DELAY);	

}

void XromWriteData(unsigned long data1, unsigned long data2)
{
	
	unsigned long rs_data, enable_rs_data;
	//bool busy=true;	

	rs_data = (0x00000020 | data1); //sets rs, data1
	enable_rs_data = (0x00000060 | data1);

	XGpio_WriteReg(LCD_BASEADDR, 1, rs_data); //write data, rs
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, enable_rs_data); //set enable, keep data, rs
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, rs_data); //turn off enable
	usleep(1);
	
	rs_data = (0x00000020 | data2); //sets rs, data2
	enable_rs_data = (0x00000060 | data2); //sets rs, data2

	XGpio_WriteReg(LCD_BASEADDR, 1, enable_rs_data); //set enable, rs, data
	usleep(1);
	XGpio_WriteReg(LCD_BASEADDR, 1, rs_data); //turn off enable
	
	usleep(DATA_DELAY);
}





//==================================================================================
//
//								EXTERNAL FUNCTIONS
//
//==================================================================================

void XromMoveCursorHome(){
	XromWriteInst(0x00000000, 0x00000002);
}

void XromMoveCursorLeft(){
	XromWriteInst(0x00000001, 0x00000000);
}

void XromMoveCursorRight(){
	XromWriteInst(0x00000001, 0x00000004);
}

void XromLCDOn(){
	//xil_printf("DISPLAY ON\r\n");
		XromWriteInst(0x00000000, 0x0000000E);
}

void XromLCDOff(){
	//xil_printf("DISPLAY OFF\r\n");
		XromWriteInst(0x00000000, 0x00000008);
}

void XromLCDClear(){
	//xil_printf("DISPLAY CLEAR\r\n");
		XromWriteInst(0x00000000, 0x00000001);
		XromWriteInst(0x00000000, 0x00000010);
		XromMoveCursorHome();
}

void XromLCDInit(){
	XGpio_WriteReg(LCD_BASEADDR, 1, 0x00000000); //Zeroes CHAR LCD Reg

	//LCD INIT
	usleep(15000);	//After VCC>4.5V Wait 15ms to Init Char LCD
		XromInitInst();
	usleep(4100); //Wait 4.1ms
		XromInitInst();
	usleep(100); //Wait 100us
		XromInitInst();
		XromInitInst();

	//Function Set
		XromWriteInst(0x00000002, 0x00000008);
		
	//Entry Mode Set
		XromWriteInst(0x00000000, 0x00000006);	
	
	//Display Off
		XromWriteInst(0x00000000, 0x00000008);

	//Display On
		XromWriteInst(0x00000000, 0x0000000F);
		
	//Display Clear
		XromWriteInst(0x00000000, 0x00000001);
}


void XromLCDSetLine(int line){ //line1 = 1, line2 = 2
	
	int i;

	if((line - 1)) {
		XromMoveCursorHome();
		for(i=0; i<40; i++)
			XromMoveCursorRight();
	}
	else
		XromMoveCursorHome();
		
}

void XromLCDPrintChar(char c){
	XromWriteData(((c >> 4) & 0x0000000F), (c & 0x0000000F));
}

void XromLCDPrintString(char * line){

	int i=0;
		while(line[i]){
			XromLCDPrintChar(line[i]);
			i++;
		}

	return;
}

void XromLCDPrint2Strings(char * line1, char * line2){

	int i=0;

		XromLCDSetLine(1);

		for(i=0; i<16; i++){
			if(line1[i])
				XromLCDPrintChar(line1[i]);
			else break;
		}	

		XromLCDSetLine(2);
	
		for(i=0; i<16; i++){
			if(line2[i])
				XromLCDPrintChar(line2[i]);
			else break;
		}	
	return;
}


////////////////////////////////////////////////////////////////
// LogNum:  Converts number to character                    //
////////////////////////////////////////////////////////////////
void XromLCDPrintNum(unsigned int x, unsigned int base)
{
  static char hex[]="0123456789ABCDEF";
  char digit[10];
  int i;

  i = 0;
  do
  {
    digit[i] = hex[x % base];
    x = x / base;
    i++;
  } while (x != 0);

  while (i > 0)
  {
  	i--;
    XromLCDPrintChar(digit[i]);
  }
}

///////////////////////////////////////////////////////////////
// tft_WriteInt:  handles the negative case, calls LogNum   //
//                w/ unsigned value                         //
//////////////////////////////////////////////////////////////
void XromLCDPrintInt(unsigned int x)
{
  unsigned int val;

  if (x < 0)
  {
    XromLCDPrintChar('-');
    val = ((unsigned int) ~x ) + 1;
  }
  else
    val = (unsigned int) x;

  XromLCDPrintNum(val, 10);
}




// //////////////////// MAIN ////////////////////////////////////////


main()
{
 

 
/////////////////////////// LCD //////////////////////////////////////

	xil_printf("\r\nLCD Test\r\n");
	xil_printf("========\r\n");


	XromLCDInit();
	XromLCDOn();



    XromLCDClear();
    XromLCDPrintString("You've completed");
	XromLCDSetLine(2);
	XromLCDPrintString("the AHC_Lab");
	XromLCDPrintChar('#');
	XromLCDPrintInt(3);

	xil_printf("\r\nLCD Test Over\r\n");
	exit(0);	

}  
