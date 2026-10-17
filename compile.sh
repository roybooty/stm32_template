arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -ffreestanding -ffunction-sections -fdata-sections -Wall -Wextra -O2 -c sys_timer.c  main.c -o main.o



arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -c startup.s -o startup.o 

arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -T./link.ld -nostartfiles -nostdlib -nodefaultlibs startup.o main.o -Wl,-Map=firmware.map -lgcc -o firmware.elf

arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
