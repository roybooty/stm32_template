ENTRY(reset_handler)

_estack = ORIGIN(sram) + LENGTH(sram);

MEMORY {
  flash (rx)     : ORIGIN = 0x08000000, LENGTH = 64K
  sram (rwx)      : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS {

  .isr_vector : {
    . = ALIGN(4);
      KEEP(*(.isr_vector))
    . = ALIGN(4);
  } > flash

  .text : {
    . = ALIGN(4);
      *(.text)
      *(.text*)
    . = ALIGN(4);
  } > flash

  .rodata : {
    . = ALIGN(4);
      *(.rodata)
      *(.rodata*)
    . = ALIGN(4);
  } > flash

  _sidata = .;
  .data : AT(_sidata) {
    . = ALIGN(4);
      _sdata = .;
      *(.data)
      *(.data*)
      _edata = .;
    . = ALIGN(4);
  } > sram

  .bss : {
    . = ALIGN(4);
      _sbss = .;
      *(.bss)
      *(.bss*)
      *(COMMON)
      _ebss = .;
    . = ALIGN(4);
  } > sram
}
