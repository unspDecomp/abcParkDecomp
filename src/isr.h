#ifndef ISR_H
#define ISR_H

void BREAK(void) __attribute__ ((ISR));
void FIQ(void) __attribute__ ((ISR));
void RESET(void) __attribute__ ((ISR));
void IRQ0(void) __attribute__ ((ISR));
void IRQ1(void) __attribute__ ((ISR));
void IRQ2(void) __attribute__ ((ISR));
void IRQ3(void) __attribute__ ((ISR));
void IRQ4(void) __attribute__ ((ISR));
void IRQ5(void) __attribute__ ((ISR));
void IRQ6(void) __attribute__ ((ISR));
void IRQ7(void) __attribute__ ((ISR));

#endif // ISR_H
