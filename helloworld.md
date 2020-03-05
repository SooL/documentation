Getting "Hello World !" with basic SooL 
===============================================

Summary
----------------------------------------------

 1. Requirements
 2. Creating a project and enabling C++ support
 3. Getting "Hello World !"

Requirements
-----------------------------------------------

 - Having a proper C++ (11+) toolchain such as STM32CubeIDE.
 - Having downloaded the SooL library

Hello world !
------------------------------------------

This is the example using a STM32F303k8 Nucleo board. It enable the USART, setup the baudrate at 9600 (8N1) and send 
the mighty `Hello World` or whatever message you want.

To use the `send` function you have to use a **null terminated string** (or C-Style string).

```cpp
#include "system/include/system_stm32.h"
#include "sool_setup.h"
#include "include/GPIO.h"
#include "include/USART.h"

int main()
{
	using namespace sool::core;
	GPIOB->enable_clock();
	GPIOA->enable_clock();
	PB3 = GPIO::Mode::Output;
	PA2 = PA15= GPIO::Mode::AlternateFunction | GPIO::AF::AF7;

	USART2->enable_clock();
	USART2->BRR = 833;
	USART2->CR1.TE = 1;
	USART2->CR1.UE = 1;

	char msg[] = "Hello World !\r\n\0";
	
	while(1)
	{
		USART2->send(msg);

		for(int i = 0; i < 50000; i++)
		    asm("nop");
	}

	return 0;
}
```