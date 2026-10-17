#include "header/registers.h"
#include "header/sys_timer.h"

int main(void) {
  RCC->APB2ENR |= SHIFT_REG(1, 4);

  PORTC->CRH &= SHIFT_REG(0xF, 20);
  PORTC->CRH |= SHIFT_REG(0x3, 20);

  systick_init(1600000/1000);

  while (1) {
    PORTC->BSRR = SHIFT_REG(1, 13);

    delay(50000);
    PORTC->BRR = SHIFT_REG(1, 13);
    delay(50000);
  }
}
