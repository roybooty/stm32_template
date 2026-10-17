CC      = arm-none-eabi-gcc
AS      = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

CFLAGS  ?= -I./header -W -Wall -Wextra -Werror -Wundef -Wshadow -Wdouble-promotion \
           -fno-common -Wconversion \
           -g3 -Os -ffunction-sections -fdata-sections \
					 -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -msoft-float $(EXTRA_CFLAGS)

LDFLAGS ?= -Tlink.ld -nostartfiles -Wl,--gc-sections -Wl,-Map=firmware.map --specs=nosys.specs

C_SOURCES = main.c sys_timer.c
C_OBJECTS = $(C_SOURCES:.c=.o)
STARTUP   = startup.s
STARTUP_O = startup.o

ifeq ($(OS),Windows_NT)
    RM = cmd /C del /Q /F
else
    RM = rm -f
endif

all: build

build: firmware.bin

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(STARTUP_O): $(STARTUP)
	$(CC) $(CFLAGS) -c $< -o $@

firmware.elf: $(C_OBJECTS) $(STARTUP_O)
	$(CC) $(C_OBJECTS) $(STARTUP_O) $(CFLAGS) $(LDFLAGS) -o $@

firmware.bin: firmware.elf
	$(OBJCOPY) -O binary $< $@

flash: firmware.bin
	st-flash --reset write $< 0x8000000

clean:
	$(RM) firmware.elf firmware.bin firmware.map *.o
