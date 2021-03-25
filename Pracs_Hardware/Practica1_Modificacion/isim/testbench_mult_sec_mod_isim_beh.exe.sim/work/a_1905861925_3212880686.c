/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/GIT/Universidad/Pracs_Hardware/Practica1_Modificacion/mult_sec_mod.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1547198987_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_1919437128_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1905861925_3212880686_p_0(char *t0)
{
    char t16[16];
    char t17[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7536);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(50, ng0);
    t1 = xsi_get_transient_memory(33U);
    memset(t1, 0, 33U);
    t5 = t1;
    memset(t5, (unsigned char)2, 33U);
    t6 = (t0 + 7744);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 33U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 2952U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t11 = (t4 == (unsigned char)3);
    if (t11 != 0)
        goto LAB7;

LAB9:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB10;

LAB11:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB14;

LAB15:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(53, ng0);
    t2 = xsi_get_transient_memory(33U);
    memset(t2, 0, 33U);
    t6 = t2;
    memset(t6, (unsigned char)2, 33U);
    t7 = (t0 + 7744);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    memcpy(t12, t2, 33U);
    xsi_driver_first_trans_fast(t7);
    goto LAB8;

LAB10:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 2472U);
    t5 = *((char **)t1);
    t13 = (32 - 32);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t1 = (t5 + t15);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 32;
    t9 = (t8 + 4U);
    *((int *)t9) = 1;
    t9 = (t8 + 8U);
    *((int *)t9) = -1;
    t18 = (1 - 32);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t19;
    t6 = xsi_base_array_concat(t6, t16, t7, (char)99, (unsigned char)2, (char)97, t1, t17, (char)101);
    t19 = (1U + 32U);
    t11 = (33U != t19);
    if (t11 == 1)
        goto LAB12;

LAB13:    t9 = (t0 + 7744);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t20 = (t12 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t6, 33U);
    xsi_driver_first_trans_fast(t9);
    goto LAB8;

LAB12:    xsi_size_not_matching(33U, t19, 0);
    goto LAB13;

LAB14:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 2312U);
    t5 = *((char **)t1);
    t13 = (32 - 32);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t1 = (t5 + t15);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 32;
    t9 = (t8 + 4U);
    *((int *)t9) = 1;
    t9 = (t8 + 8U);
    *((int *)t9) = -1;
    t18 = (1 - 32);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t19;
    t6 = xsi_base_array_concat(t6, t16, t7, (char)99, (unsigned char)2, (char)97, t1, t17, (char)101);
    t19 = (1U + 32U);
    t11 = (33U != t19);
    if (t11 == 1)
        goto LAB16;

LAB17:    t9 = (t0 + 7744);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t20 = (t12 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t6, 33U);
    xsi_driver_first_trans_fast(t9);
    goto LAB8;

LAB16:    xsi_size_not_matching(33U, t19, 0);
    goto LAB17;

}

static void work_a_1905861925_3212880686_p_1(char *t0)
{
    char t20[16];
    char t21[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    int t22;
    unsigned int t23;
    unsigned char t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7552);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(66, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t5 = t1;
    memset(t5, (unsigned char)2, 32U);
    t6 = (t0 + 7808);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 32U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(68, ng0);
    t2 = (t0 + 3592U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t11 = (t4 == (unsigned char)3);
    if (t11 != 0)
        goto LAB7;

LAB9:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB10;

LAB11:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB14;

LAB15:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 1192U);
    t6 = *((char **)t2);
    t12 = (31 - 31);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t2 = (t6 + t14);
    t7 = (t0 + 7808);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t15 = *((char **)t10);
    memcpy(t15, t2, 32U);
    xsi_driver_first_trans_fast(t7);
    goto LAB8;

LAB10:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 2472U);
    t5 = *((char **)t1);
    t16 = (0 - 32);
    t12 = (t16 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t1 = (t5 + t14);
    t11 = *((unsigned char *)t1);
    t6 = (t0 + 2632U);
    t7 = *((char **)t6);
    t17 = (31 - 31);
    t18 = (t17 * 1U);
    t19 = (0 + t18);
    t6 = (t7 + t19);
    t9 = ((IEEE_P_2592010699) + 4024);
    t10 = (t21 + 0U);
    t15 = (t10 + 0U);
    *((int *)t15) = 31;
    t15 = (t10 + 4U);
    *((int *)t15) = 1;
    t15 = (t10 + 8U);
    *((int *)t15) = -1;
    t22 = (1 - 31);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t15 = (t10 + 12U);
    *((unsigned int *)t15) = t23;
    t8 = xsi_base_array_concat(t8, t20, t9, (char)99, t11, (char)97, t6, t21, (char)101);
    t23 = (1U + 31U);
    t24 = (32U != t23);
    if (t24 == 1)
        goto LAB12;

LAB13:    t15 = (t0 + 7808);
    t25 = (t15 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t8, 32U);
    xsi_driver_first_trans_fast(t15);
    goto LAB8;

LAB12:    xsi_size_not_matching(32U, t23, 0);
    goto LAB13;

LAB14:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 2312U);
    t5 = *((char **)t1);
    t16 = (0 - 32);
    t12 = (t16 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t1 = (t5 + t14);
    t11 = *((unsigned char *)t1);
    t6 = (t0 + 2632U);
    t7 = *((char **)t6);
    t17 = (31 - 31);
    t18 = (t17 * 1U);
    t19 = (0 + t18);
    t6 = (t7 + t19);
    t9 = ((IEEE_P_2592010699) + 4024);
    t10 = (t21 + 0U);
    t15 = (t10 + 0U);
    *((int *)t15) = 31;
    t15 = (t10 + 4U);
    *((int *)t15) = 1;
    t15 = (t10 + 8U);
    *((int *)t15) = -1;
    t22 = (1 - 31);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t15 = (t10 + 12U);
    *((unsigned int *)t15) = t23;
    t8 = xsi_base_array_concat(t8, t20, t9, (char)99, t11, (char)97, t6, t21, (char)101);
    t23 = (1U + 31U);
    t24 = (32U != t23);
    if (t24 == 1)
        goto LAB16;

LAB17:    t15 = (t0 + 7808);
    t25 = (t15 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t8, 32U);
    xsi_driver_first_trans_fast(t15);
    goto LAB8;

LAB16:    xsi_size_not_matching(32U, t23, 0);
    goto LAB17;

}

static void work_a_1905861925_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;

LAB0:    xsi_set_current_line(81, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7568);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(82, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t5 = t1;
    memset(t5, (unsigned char)2, 32U);
    t6 = (t0 + 7872);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 32U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 3752U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t11 = (t4 == (unsigned char)3);
    if (t11 != 0)
        goto LAB7;

LAB9:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(85, ng0);
    t2 = (t0 + 1032U);
    t6 = *((char **)t2);
    t12 = (31 - 31);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t2 = (t6 + t14);
    t7 = (t0 + 7872);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t15 = *((char **)t10);
    memcpy(t15, t2, 32U);
    xsi_driver_first_trans_fast(t7);
    goto LAB8;

}

static void work_a_1905861925_3212880686_p_3(char *t0)
{
    char t1[16];
    char t8[16];
    char t10[16];
    char t16[16];
    char *t2;
    char *t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    char *t7;
    char *t9;
    char *t11;
    char *t12;
    int t13;
    unsigned int t14;
    char *t15;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    xsi_set_current_line(91, ng0);

LAB3:    t2 = (t0 + 2312U);
    t3 = *((char **)t2);
    t4 = (32 - 31);
    t5 = (t4 * 1U);
    t6 = (0 + t5);
    t2 = (t3 + t6);
    t9 = ((IEEE_P_2592010699) + 4024);
    t11 = (t10 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 31;
    t12 = (t11 + 4U);
    *((int *)t12) = 0;
    t12 = (t11 + 8U);
    *((int *)t12) = -1;
    t13 = (0 - 31);
    t14 = (t13 * -1);
    t14 = (t14 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t14;
    t7 = xsi_base_array_concat(t7, t8, t9, (char)99, (unsigned char)2, (char)97, t2, t10, (char)101);
    t12 = (t0 + 2792U);
    t15 = *((char **)t12);
    t17 = ((IEEE_P_2592010699) + 4024);
    t18 = (t0 + 12648U);
    t12 = xsi_base_array_concat(t12, t16, t17, (char)99, (unsigned char)2, (char)97, t15, t18, (char)101);
    t19 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t1, t7, t8, t12, t16);
    t20 = (t0 + 7936);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t19, 33U);
    xsi_driver_first_trans_fast(t20);

LAB2:    t25 = (t0 + 7584);
    *((int *)t25) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1905861925_3212880686_p_4(char *t0)
{
    char t15[16];
    char t16[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t17;
    int t18;
    unsigned int t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    xsi_set_current_line(97, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7600);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(98, ng0);
    t1 = xsi_get_transient_memory(64U);
    memset(t1, 0, 64U);
    t5 = t1;
    memset(t5, (unsigned char)2, 64U);
    t6 = (t0 + 8000);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 64U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(100, ng0);
    t2 = (t0 + 3432U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t11 = (t4 == (unsigned char)3);
    if (t11 != 0)
        goto LAB7;

LAB9:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(101, ng0);
    t2 = (t0 + 2312U);
    t6 = *((char **)t2);
    t12 = (32 - 31);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t2 = (t6 + t14);
    t7 = (t0 + 2632U);
    t8 = *((char **)t7);
    t9 = ((IEEE_P_2592010699) + 4024);
    t10 = (t16 + 0U);
    t17 = (t10 + 0U);
    *((int *)t17) = 31;
    t17 = (t10 + 4U);
    *((int *)t17) = 0;
    t17 = (t10 + 8U);
    *((int *)t17) = -1;
    t18 = (0 - 31);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t17 = (t10 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t0 + 12648U);
    t7 = xsi_base_array_concat(t7, t15, t9, (char)97, t2, t16, (char)97, t8, t17, (char)101);
    t19 = (32U + 32U);
    t20 = (64U != t19);
    if (t20 == 1)
        goto LAB10;

LAB11:    t21 = (t0 + 8000);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t7, 64U);
    xsi_driver_first_trans_fast_port(t21);
    goto LAB8;

LAB10:    xsi_size_not_matching(64U, t19, 0);
    goto LAB11;

}

static void work_a_1905861925_3212880686_p_5(char *t0)
{
    char t13[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    char *t12;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7616);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(111, ng0);
    t1 = xsi_get_transient_memory(6U);
    memset(t1, 0, 6U);
    t5 = t1;
    memset(t5, (unsigned char)2, 6U);
    t6 = (t0 + 8064);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 6U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(113, ng0);
    t2 = (t0 + 2952U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t11 = (t4 == (unsigned char)3);
    if (t11 != 0)
        goto LAB7;

LAB9:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB10;

LAB11:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(114, ng0);
    t2 = (t0 + 12900);
    t7 = (t0 + 8064);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    memcpy(t12, t2, 6U);
    xsi_driver_first_trans_fast(t7);
    goto LAB8;

LAB10:    xsi_set_current_line(116, ng0);
    t1 = (t0 + 4072U);
    t5 = *((char **)t1);
    t1 = (t0 + 12664U);
    t6 = ieee_p_1242562249_sub_1919437128_1035706684(IEEE_P_1242562249, t13, t5, t1, 1);
    t7 = (t13 + 12U);
    t14 = *((unsigned int *)t7);
    t15 = (1U * t14);
    t11 = (6U != t15);
    if (t11 == 1)
        goto LAB12;

LAB13:    t8 = (t0 + 8064);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t16 = *((char **)t12);
    memcpy(t16, t6, 6U);
    xsi_driver_first_trans_fast(t8);
    goto LAB8;

LAB12:    xsi_size_not_matching(6U, t15, 0);
    goto LAB13;

}

static void work_a_1905861925_3212880686_p_6(char *t0)
{
    char t5[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(124, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t1 = (t0 + 12664U);
    t3 = (t0 + 12906);
    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 0;
    t7 = (t6 + 4U);
    *((int *)t7) = 5;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t8 = (5 - 0);
    t9 = (t8 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t10 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t2, t1, t3, t5);
    if (t10 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(127, ng0);
    t1 = (t0 + 8128);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t6 = *((char **)t4);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB3:    t1 = (t0 + 7632);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(125, ng0);
    t7 = (t0 + 8128);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast(t7);
    goto LAB3;

}

static void work_a_1905861925_3212880686_p_7(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(134, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1792U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7648);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(135, ng0);
    t1 = (t0 + 8192);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(137, ng0);
    t2 = (t0 + 2152U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t2 = (t0 + 8192);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t4;
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

}

static void work_a_1905861925_3212880686_p_8(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned char t16;
    static char *nl0[] = {&&LAB3, &&LAB4};

LAB0:    xsi_set_current_line(143, ng0);
    t1 = (t0 + 8256);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(143, ng0);
    t1 = (t0 + 8320);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(143, ng0);
    t1 = (t0 + 8384);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(143, ng0);
    t1 = (t0 + 8448);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(143, ng0);
    t1 = (t0 + 8512);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(144, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t1 = (t0 + 8576);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = t6;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(145, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t6);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 7664);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(147, ng0);
    t3 = (t0 + 1512U);
    t4 = *((char **)t3);
    t8 = *((unsigned char *)t4);
    t9 = (t8 == (unsigned char)3);
    if (t9 != 0)
        goto LAB6;

LAB8:    xsi_set_current_line(153, ng0);
    t1 = (t0 + 8256);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(154, ng0);
    t1 = (t0 + 8576);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB7:    goto LAB2;

LAB4:    xsi_set_current_line(157, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t8 = (t6 == (unsigned char)3);
    if (t8 != 0)
        goto LAB9;

LAB11:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t8 = (t6 == (unsigned char)2);
    if (t8 != 0)
        goto LAB12;

LAB13:
LAB10:    xsi_set_current_line(165, ng0);
    t1 = (t0 + 8384);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    xsi_set_current_line(167, ng0);
    t1 = (t0 + 8576);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    xsi_set_current_line(148, ng0);
    t3 = (t0 + 8448);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(149, ng0);
    t1 = (t0 + 8512);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(150, ng0);
    t1 = (t0 + 8256);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(151, ng0);
    t1 = (t0 + 8576);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB7;

LAB9:    xsi_set_current_line(158, ng0);
    t1 = (t0 + 8576);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB12:    xsi_set_current_line(160, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t12 = (0 - 31);
    t13 = (t12 * -1);
    t14 = (1U * t13);
    t15 = (0 + t14);
    t1 = (t3 + t15);
    t9 = *((unsigned char *)t1);
    t16 = (t9 == (unsigned char)3);
    if (t16 != 0)
        goto LAB14;

LAB16:
LAB15:    xsi_set_current_line(163, ng0);
    t1 = (t0 + 8576);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB14:    xsi_set_current_line(161, ng0);
    t4 = (t0 + 8320);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t4);
    goto LAB15;

}


extern void work_a_1905861925_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1905861925_3212880686_p_0,(void *)work_a_1905861925_3212880686_p_1,(void *)work_a_1905861925_3212880686_p_2,(void *)work_a_1905861925_3212880686_p_3,(void *)work_a_1905861925_3212880686_p_4,(void *)work_a_1905861925_3212880686_p_5,(void *)work_a_1905861925_3212880686_p_6,(void *)work_a_1905861925_3212880686_p_7,(void *)work_a_1905861925_3212880686_p_8};
	xsi_register_didat("work_a_1905861925_3212880686", "isim/testbench_mult_sec_mod_isim_beh.exe.sim/work/a_1905861925_3212880686.didat");
	xsi_register_executes(pe);
}
