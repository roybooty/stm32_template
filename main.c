
#include <stdint.h>
#include <sys/types.h>
struct PORT {
  volatile uint32_t CRL;
  volatile uint32_t CRH;
  volatile uint32_t IDR;
  volatile uint32_t ODR;
  volatile uint32_t BSRR;
  volatile uint32_t BRR;
  volatile uint32_t LCKR;
};

struct RCC_clock {
  volatile uint32_t CR;
  volatile uint32_t CFGR;
  volatile uint32_t CIR;
  volatile uint32_t APB2RSTR;
  volatile uint32_t APB1RSTR;
  volatile uint32_t AHBENR;
  volatile uint32_t APB2ENR;
  volatile uint32_t APB1ENR;
  volatile uint32_t BDCR;
  volatile uint32_t CSR;
  volatile uint32_t AHBRSTR;
  volatile uint32_t CFGR2;
};

#define PORTC ((struct PORT*)(0x40011000))
#define RCC ((struct RCC_clock*)0x40021000)
#define SHIFT_REG(state, bit) ((state) << (bit))

int main(void) {
  RCC->APB2ENR |= SHIFT_REG(1, 4);

  PORTC->CRH &= SHIFT_REG(0xF, 20);
  PORTC->CRH |= SHIFT_REG(0x3, 20);

  while (1) {
    PORTC->BSRR = SHIFT_REG(1, 13);

    for (volatile uint32_t i = 0;i < 500000;i++);
    PORTC->BRR = SHIFT_REG(1, 13);
    for (volatile uint32_t i = 0;i < 500000;i++);
  }
}
