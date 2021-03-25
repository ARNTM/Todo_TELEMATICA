/* $Id: */

/******************************************************************************
*
* (c) Copyright 2007-2009 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xlldma_hw.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Local-Link Scatter-gather Direct
* Memory Access Gather (LLDMA) device.
*
* For more information about the operation of this device, see the hardware
* specification and documentation in the higher level driver xlldma.h source
* code file.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a xd   12/21/06 First release
* 1.01a sdm  03/09/09 Added constants to define HDMA and SDMA
* 2.00a jz   12/04/09  Hal phase 1 support, changed _m to _ from macro API 
* </pre>
*
******************************************************************************/

#ifndef XLLDMA_HW_H		/* prevent circular inclusions */
#define XLLDMA_HW_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xparameters.h"

#define XLLDMA_HDMA		1 /* Hard DMA Block */
#define XLLDMA_SDMA		2 /* Soft DMA PIM */

/** @name Device Bus Type definition
 * The constant XPAR_XLLDMA_USE_DCR is used to inform this driver the type of
 * the BUS the DMA device is on. If the DMA core is on DCR BUS (Hard DMA Block),
 * XPAR_XLLDMA_USE_DCR must be defined in xparameters.h or as a compiler option
 * used in the Makefile BEFORE this driver is compiled; Otherwise, the constant
 * must not be defined.
 *  @{
 */
#ifdef XPAR_XLLDMA_USE_DCR
 #include "xio_dcr.h"
 #define XLLDMA_DEVICE		XLLDMA_HDMA /* XPAR_XLLDMA_USE_DCR indicates the
					     * driver is used with HDMA */
#else /* !XPAR_XLLDMA_USE_DCR */
 #include "xil_io.h"
 #define XLLDMA_DEVICE		XLLDMA_SDMA /* !XPAR_XLLDMA_USE_DCR indicates
					     * the driver is used with SDMA */
#endif
/*@}*/

#include "xil_types.h"
/************************** Constant Definitions *****************************/

/** @name Buffer Descriptor Alignment
 *  @{
 */
#define XLLDMA_BD_MINIMUM_ALIGNMENT 0x40  /**< Minimum byte alignment
                                               requirement for descriptors to
                                               satisfy both hardware/software
                                               needs */
/*@}*/


/* Register offset definitions. Unless otherwise noted, register access is
 * 32 bit.
 */

#ifdef XPAR_XLLDMA_USE_DCR

/* DMA core is on DCR BUS */

/** @name Device registers for DCR based systems.
 *  Offsets defined in DCR address space. TX and RX channels consist of
 *  identical registers
 *  @{
 */
#define XLLDMA_TX_OFFSET    0x00000000	/**< TX channel registers base
                                             offset [0..7] */
#define XLLDMA_RX_OFFSET    0x00000008	/**< RX channel registers base
                                             offset [8..F] */
#define XLLDMA_DMACR_OFFSET 0x00000010	/**< DMA control register */

/* This set of registers are applicable for both channels. Add
 * XLLDMA_TX_OFFSET to get to TX channel, and XLLDMA_RX_OFFSET to get to RX
 * channel
 */
#define XLLDMA_NDESC_OFFSET 0x00000000	/**< Next descriptor pointer */
#define XLLDMA_BUFA_OFFSET  0x00000001	/**< Current buffer address */
#define XLLDMA_BUFL_OFFSET  0x00000002	/**< Current buffer length */
#define XLLDMA_CDESC_OFFSET 0x00000003	/**< Current descriptor pointer */
#define XLLDMA_TDESC_OFFSET 0x00000004	/**< Tail descriptor pointer */
#define XLLDMA_CR_OFFSET    0x00000005	/**< Channel control */
#define XLLDMA_IRQ_OFFSET   0x00000006	/**< Interrupt register */
#define XLLDMA_SR_OFFSET    0x00000007	/**< Status */
/*@}*/

#else /* Non-DCR interface is used */

/** @name Device registers for Non-DCR based systems.
 *  Offsets defined in Non-DCR address space. TX and RX channels consist of
 *  identical registers
 *  @{
 */
#define XLLDMA_TX_OFFSET    0x00000000	/**< TX channel registers base
                                             offset */
#define XLLDMA_RX_OFFSET    0x00000020	/**< RX channel registers base
                                             offset */
#define XLLDMA_DMACR_OFFSET 0x00000040	/**< DMA control register */

/* This set of registers are applicable for both channels. Add
 * XLLDMA_TX_OFFSET to get to TX channel, and XLLDMA_RX_OFFSET to get to RX
 * channel
 */
#define XLLDMA_NDESC_OFFSET 0x00000000	/**< Next descriptor pointer */
#define XLLDMA_BUFA_OFFSET  0x00000004	/**< Current buffer address */
#define XLLDMA_BUFL_OFFSET  0x00000008	/**< Current buffer length */
#define XLLDMA_CDESC_OFFSET 0x0000000C	/**< Current descriptor pointer */
#define XLLDMA_TDESC_OFFSET 0x00000010	/**< Tail descriptor pointer */
#define XLLDMA_CR_OFFSET    0x00000014	/**< Channel control */
#define XLLDMA_IRQ_OFFSET   0x00000018	/**< Interrupt register */
#define XLLDMA_SR_OFFSET    0x0000001C	/**< Status */

/*@}*/

#endif /* #ifdef XPAR_XLLDMA_USE_DCR */

/** @name Buffer Descriptor register offsets
 *  USR fields are defined by higher level IP. For example, checksum offload
 *  setup for EMAC type devices. The 1st 8 words are utilized by hardware. Any
 *  words after the 8th are for software use only.
 *  @{
 */
#define XLLDMA_BD_NDESC_OFFSET        0x00  /**< Next descriptor pointer */
#define XLLDMA_BD_BUFA_OFFSET         0x04  /**< Buffer address */
#define XLLDMA_BD_BUFL_OFFSET         0x08  /**< Buffer length */
#define XLLDMA_BD_STSCTRL_USR0_OFFSET 0x0C  /**< Status and Control and
                                                 hardware implementation
                                                 specific */
#define XLLDMA_BD_USR1_OFFSET         0x10  /**< Hardware implementation
                                                 specific */
#define XLLDMA_BD_USR2_OFFSET         0x14  /**< Hardware implementation
                                                 specific */
#define XLLDMA_BD_USR3_OFFSET         0x18  /**< Hardware implementation
                                                 specific */
#define XLLDMA_BD_USR4_OFFSET         0x1C  /**< Hardware implementation
                                                 specific */
#define XLLDMA_BD_ID_OFFSET           0x20  /**< Software application use */

#define XLLDMA_BD_NUM_WORDS              9  /**< Number of 32-bit words that
                                                 make up a full BD */
#define XLLDMA_BD_HW_NUM_WORDS           8  /**< Number of 32-bit words that
                                                 make up the hardware
                                                 accessible portion of a BD */
#define XLLDMA_BD_HW_NUM_BYTES          32  /**< Number of bytes that make up
                                                 the hardware accessible
                                                 portion of a BD */
/*@}*/


/* Register masks. The following constants define bit locations of various
 * control bits in the registers. Constants are not defined for those registers
 * that have a single bit field representing all 32 bits. For further
 * information on the meaning of the various bit masks, refer to the hardware
 * spec.
 */


/** @name Bitmasks of XLLDMA_TX_CR_OFFSET and XLLDMA_RX_CR_OFFSET registers
 * @{
 */
#define XLLDMA_CR_IRQ_TIMEOUT_MASK      0xFF000000 /**< Interrupt coalesce
                                                        waitbound timeout */
#define XLLDMA_CR_IRQ_COUNT_MASK        0x00FF0000 /**< Interrupt coalesce
                                                        count threshold */
#define XLLDMA_CR_MSB_ADDR_MASK         0x0000F000 /**< MSB address of DMA
                                                        buffers and descriptors
                                                        for 36 bit
                                                        addressing */
#define XLLDMA_CR_APP_EN_MASK           0x00000800 /**< Application data mask
                                                        enable */
#define XLLDMA_CR_USE_1_BIT_CNT_MASK    0x00000400 /**< Turn 4 and 2 bit
                                                        interrupt counters into
                                                        1 bit counters */
#define XLLDMA_CR_USE_INT_ON_END_MASK   0x00000200 /**< Use interrupt-on-end */
#define XLLDMA_CR_LD_IRQ_CNT_MASK       0x00000100 /**< Load IRQ_COUNT */
#define XLLDMA_CR_IRQ_EN_MASK           0x00000080 /**< Master interrupt
                                                        enable */
#define XLLDMA_CR_IRQ_ERROR_EN_MASK     0x00000004 /**< Enable error
                                                        interrupt */
#define XLLDMA_CR_IRQ_DELAY_EN_MASK     0x00000002 /**< Enable coalesce delay
                                                        interrupt */
#define XLLDMA_CR_IRQ_COALESCE_EN_MASK  0x00000001 /**< Enable coalesce count
                                                        interrupt */
#define XLLDMA_CR_IRQ_ALL_EN_MASK       0x00000087 /**< All interrupt enable
                                                        bits */

/* Shift constants for selected masks */
#define XLLDMA_CR_IRQ_TIMEOUT_SHIFT     24
#define XLLDMA_CR_IRQ_COUNT_SHIFT       16
#define XLLDMA_CR_MSB_ADDR_SHIFT        12

/*@}*/


/** @name Bitmasks of XLLDMA_TX_IRQ_OFFSET & XLLDMA_RX_IRQ_OFFSET registers
 * @{
 */
#define XLLDMA_IRQ_WRQ_EMPTY_MASK        0x00004000 /**< Write Command Queue
                                                         Empty -- RX channel
                                                         Only */
#define XLLDMA_IRQ_COALESCE_COUNTER_MASK 0x00003C00 /**< Coalesce IRQ 4 bit
                                                         counter */
#define XLLDMA_IRQ_DELAY_COUNTER_MASK    0x00000300 /**< Coalesce delay IRQ 2
                                                         bit counter */
#define XLLDMA_IRQ_PLB_RD_ERROR_MASK     0x00000010 /**< PLB Read Error IRQ */
#define XLLDMA_IRQ_PLB_WR_ERROR_MASK     0x00000008 /**< PLB Write Error IRQ */
#define XLLDMA_IRQ_ERROR_MASK            0x00000004 /**< Error IRQ */
#define XLLDMA_IRQ_DELAY_MASK            0x00000002 /**< Coalesce delay IRQ */
#define XLLDMA_IRQ_COALESCE_MASK         0x00000001 /**< Coalesce threshold
                                                         IRQ */
#define XLLDMA_IRQ_ALL_ERR_MASK          0x0000001C /**< All error interrupt */
#define XLLDMA_IRQ_ALL_MASK              0x0000001F /**< All interrupt bits */

/* Shift constants for selected masks */
#define XLLDMA_IRQ_COALESCE_COUNTER_SHIFT 10
#define XLLDMA_IRQ_DELAY_COUNTER_SHIFT     8

/*@}*/


/** @name Bitmasks of XLLDMA_TX_SR_OFFSET and XLLDMA_RX_SR_OFFSET registers
 * @{
 */
#define XLLDMA_SR_IRQ_ON_END_MASK   0x00000040 /**< IRQ on end has occurred */
#define XLLDMA_SR_STOP_ON_END_MASK  0x00000020 /**< Stop on end has occurred */
#define XLLDMA_SR_COMPLETED_MASK    0x00000010 /**< BD completed */
#define XLLDMA_SR_SOP_MASK          0x00000008 /**< Current BD has SOP set */
#define XLLDMA_SR_EOP_MASK          0x00000004 /**< Current BD has EOP set */
#define XLLDMA_SR_ENGINE_BUSY_MASK  0x00000002 /**< Channel is busy */
/*@}*/


/** @name Bitmasks associated with XLLDMA_DMACR_OFFSET register
 * @{
 */
#define XLLDMA_DMACR_TX_PAUSE_MASK             0x20000000 /**< Pause TX channel
                                                                  */
#define XLLDMA_DMACR_RX_PAUSE_MASK             0x10000000 /**< Pause RX channel
                                                                  */
#define XLLDMA_DMACR_PLB_ERR_DIS_MASK          0x00000020 /**< Disable PLB
                                                               error detection
                                                                  */
#define XLLDMA_DMACR_RX_OVERFLOW_ERR_DIS_MASK  0x00000010 /**< Disable error
                                                               when 2 or 4 bit
                                                               coalesce counter
                                                               overflows */
#define XLLDMA_DMACR_TX_OVERFLOW_ERR_DIS_MASK  0x00000008 /**< Disable error
                                                               when 2 or 4 bit
                                                               coalesce counter
                                                               overflows */
#define XLLDMA_DMACR_TAIL_PTR_EN_MASK          0x00000004 /**< Enable use of
                                                               tail pointer
                                                               register */
#define XLLDMA_DMACR_EN_ARB_HOLD_MASK          0x00000002 /**< Enable
                                                               arbitration
                                                               hold */
#define XLLDMA_DMACR_SW_RESET_MASK             0x00000001 /**< Assert Software
                                                               reset for both
                                                               channels */
/*@}*/


/** @name Bitmasks of XLLDMA_BD_STSCTRL_USR0_OFFSET descriptor word
 *  @{
 */
#define XLLDMA_BD_STSCTRL_ERROR_MASK      0x80000000  /**< DMA error */
#define XLLDMA_BD_STSCTRL_IOE_MASK        0x40000000  /**< Interrupt on end */
#define XLLDMA_BD_STSCTRL_SOE_MASK        0x20000000  /**< Stop on end */
#define XLLDMA_BD_STSCTRL_COMPLETED_MASK  0x10000000  /**< DMA completed */
#define XLLDMA_BD_STSCTRL_SOP_MASK        0x08000000  /**< Start of packet */
#define XLLDMA_BD_STSCTRL_EOP_MASK        0x04000000  /**< End of packet */
#define XLLDMA_BD_STSCTRL_BUSY_MASK       0x02000000  /**< DMA channel busy */

#define XLLDMA_BD_STSCTRL_MASK            0xFF000000  /**< Status/Control field
                                                               */
#define XLLDMA_BD_STSCTRL_USR0_MASK       0x00FFFFFF  /**< User field #0 */
/*@}*/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

#ifdef XPAR_XLLDMA_USE_DCR

/* DCR interface is used */

#define XLlDma_In32  XIo_DcrIn
#define XLlDma_Out32 XIo_DcrOut

#else

/* Non-DCR interface is used */

#define XLlDma_In32  Xil_In32 
#define XLlDma_Out32 Xil_Out32

#endif

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param    BaseAddress is the base address of the device
* @param    RegOffset is the register offset to be read
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 XLlDma_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define XLlDma_ReadReg(BaseAddress, RegOffset)             \
    XLlDma_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param    BaseAddress is the base address of the device
* @param    RegOffset is the register offset to be written
* @param    Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void XLlDma_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define XLlDma_WriteReg(BaseAddress, RegOffset, Data)          \
    XLlDma_Out32((BaseAddress) + (RegOffset), (Data))

/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
