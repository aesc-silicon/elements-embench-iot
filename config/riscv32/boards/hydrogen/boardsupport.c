/* Copyright (C) 2017 Embecosm Limited and University of Bristol

   Contributor Graham Markall <graham.markall@embecosm.com>

   This file is part of Embench and was formerly part of the Bristol/Embecosm
   Embedded Benchmark Suite.

   SPDX-License-Identifier: GPL-3.0-or-later */

#include <support.h>

#define TIMER_VAL	((unsigned int*)0xF0020000)
#define TIMER_CMP	((unsigned int*)0xF0020008)
static unsigned int vexriscv_time;

void initialise_board ()
{
	*TIMER_CMP = 0x0;
}

void __attribute__ ((noinline)) __attribute__ ((externally_visible))
start_trigger ()
{
	vexriscv_time = *TIMER_VAL;
}

void __attribute__ ((noinline)) __attribute__ ((externally_visible))
stop_trigger ()
{
	vexriscv_time = *TIMER_VAL - vexriscv_time;
}
