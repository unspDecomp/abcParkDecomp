#include "isr.h"
#include "unspRegs.h"


void BREAK(void) {
}


void FIQ(void) {
}

void fn_00b3e5(void) {}
void fn_07dd8a(void) {}

void RESET(void) {
  int* arguments;
  int argc;
  char** argv;
  int i;

  asm("INT OFF");

  WATCHDOG = 0x55aa;
  MEMORY_CTRL |= 4;
  SYSTEM_CTRL &= 0x7fff;
  SYSTEM_CTRL = 0x4006;
  ADC_CTRL = 2;

  GPIO_CONFIG = 8;
  PORTB_MASK |= 7;
  PORTB_DIR = (PORTB_DIR & 7) | 0x17;
  PORTB_ATTR = (PORTB_ATTR & 7) | 0x17;
  PORTB_BUFFER = (PORTB_BUFFER & 0xf) | 0xff;

  PORTC_DIR = 0x88c0;
  PORTC_ATTR = 0x88c0;
  PORTC_DATA = 0xf77f;

  PORTA_ATTR = 0x3000;
  PORTA_DIR = 0x3000;
  PORTA_DATA = 0xcfff;

  asm("SP = 0x21ef");

  fn_00b3e5();
  fn_07dd8a();

  // arguments = (int*)0xb220;
  // argv = arguments[]
  // argc = *arguments;
  // for (i = 0; i < argc; i++) {
  //   *(argv++) = 0;
  // }

}


void IRQ0(void) {
}


void IRQ1(void) {
}


void IRQ2(void) {
}


void IRQ3(void) {
}


void IRQ4(void) {
}


void IRQ5(void) {
}


void IRQ6(void) {
}


void IRQ7(void) {
}
