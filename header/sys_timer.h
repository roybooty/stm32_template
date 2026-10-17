#ifndef __SYS_TIMER__
#define __SYS_TIMER__

#include <stdint.h>

struct systick {
  volatile uint32_t CTRL, LOAD, VAL, CALIB;
};

#define SYSTICK ((struct systick*)0xe000e010)
#define BIT(x) (1UL << (x))

void systick_init(uint32_t ticks);
void SysTick_Handler(void);
void delay(unsigned ms);

#endif
