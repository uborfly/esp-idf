#Linker scripts used to link the final application.
#Warning: These linker scripts are only used when the normal app is compiled; the bootloader
#specifies its own scripts.
LINKER_SCRIPTS += esp32.rom.ld esp32.rom.libgcc.ld

#SPI-RAM incompatible functions can be used in when the SPI RAM
#workaround is not enabled.
ifndef CONFIG_SPIRAM_CACHE_WORKAROUND
LINKER_SCRIPTS += esp32.rom.spiram_incompatible_fns.ld
endif

ifdef CONFIG_NEWLIB_NANO_FORMAT
LINKER_SCRIPTS += esp32.rom.nanofmt.ld
endif

ifndef CONFIG_SPI_FLASH_ROM_DRIVER_PATCH
LINKER_SCRIPTS += esp32.rom.spiflash.ld
endif

COMPONENT_ADD_LDFLAGS += -L $(COMPONENT_PATH)/esp32/ld \
                         $(addprefix -T ,$(LINKER_SCRIPTS)) \

COMPONENT_ADD_LINKER_DEPS += $(addprefix esp32/ld/, $(LINKER_SCRIPTS))
