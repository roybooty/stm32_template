#include "header/sys_timer.h"
#include "header/registers.h"

static volatile uint32_t s_ticks;

void systick_init(uint32_t ticks) {
  if ((ticks -1) > 0xffffff) return;
  SYSTICK->LOAD = ticks - 1;
  SYSTICK->VAL = 0;
  SYSTICK->CTRL = BIT(0) | BIT(1) | BIT(2);
  RCC->APB2ENR |= BIT(14);
}

void SysTick_Handler(void) {
  s_ticks++;
}

void delay(unsigned ms) {
  uint32_t until = s_ticks + ms;
  while (s_ticks < until) (void) 0;
}
