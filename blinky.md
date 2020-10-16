Getting blinky with SooL and CubeIDE/TrueStudio
===============================================

Summary
----------------------------------------------

 1. Requirements
 2. Creating a project and enabling C++ support
 3. Adding SooL
 4. Blinking

Requirements
-----------------------------------------------

 - Having a proper installation of CubeIDE  and its toolchain.
 - Having downloaded the SooL library



Creating a project and enabling C++ support
----------------------------------------------

### Using STM32CubeIDE and the SooL patcher utility

Check out the [SooL Patcher for CubeIDE](https://github.com/SooL/usertools-cubeide-patcher) repository and follow instructions. Then go directly to the Blinking part.

### Project creation

> Deeply out of date

 - On Atollic, you may create a proper project by using :
`File` -> `New` -> `C Project`
 - It is almost mandatory to create a C Project to get the right toolchain and some required files such as the linker script.
 - In the opening window, chose a project, location and the `Executable` -> `Embedded C Project` with the `Atollic ARM Tools` toolchain.
 - On the next window, select your device (in my case it will be an STM32F303K8. You should not use a "Board" setup (such as _STM32F3_Discovery_)
 - Next, you might remove the use of tiny printf since SooL provide equivalent functions.
 - Finally, select your debug probe and let all configurations as it.

Now you should have a complete project, almost ready to go !

### Cleaning up

> Deeply out of date

First of all, you should clean you project up by removing any unnecessary files.
To make it simple, you may remove all files in `Drivers/`, `main.c` and `system_stm32fYxx.c`, 
leaving only the linker script (`stm32f30_flash.ld`) and the startup script `startup_stm32f303x8.s`.

### Enabling C++ support

> Deeply out of date

To enable the C++ support on an Embedded C Project you have to go in `File` -> `New` -> `Convert to a C/C++ project (Add C/C++ Nature)`.
Chose to convert your project to C++ without changing anything else.

Now, if you select your project, right-click on it to go in `Properties`, you shall be able to access to `C/C++ Build` -> `Settings` -> `Tool Settings` and see a `C++ Compiler` section after the `C Compiler` section.

You should check if all _Symbols_ and _Directories_ (include paths) are the same in C and C++ settings. You also remove if required any path which would have been removed by the cleanup step, leaving only `../src`.
Finally, in order to get the full potential of SooL, you should enable some level of optimization (At the very least O1, but you might want to go for O3).


Adding SooL
------------------------------------------

> Deeply out of date

Now, it's time to add SooL to your project.

The easiest way is to use a file explorer to get your `SooL-CoreLib` folder and drag and drop it in your project tree. The easiest method to be able to update SooL later, is to choose to add the folder as `Link to files and folders`.
However, if you want to redistribute your project later, you should copy the whole library in it with the `Copy files and folders` option.
You might place it within the `Drivers` folder if you have not deleted it earlier.
Otherwise, you may place it under the root folder, right click on it, go in `Ressource configuration` -> `Exclude from build...` then *unselect* all and save the changes.

You should add `SooL-CoreLib/ll/include` and `Sool-CoreLib/system/include` folders in the C++ include paths. You can do it by right-clicking them, select `Add/remove include path...`, select all and apply your changes.

A mandatory point in using SooL is to properly set the chip that you will use. There is two methods to do so :
 - Defining it as a project symbol (`Project properties` -> `C/C++ General` -> `Paths and Symbols` -> `Symbol` and add it *for GNU C and GNU C++* languages)
 - Defining it through a `#define STM32F303x8` within `Sool-CoreLib/sool_setup.h`
 
However, if you set up your project using TrueStudio, it should already be defined as a symbol.
If there is an issue with this definition, SooL may not provide any functionalities and will fail the compilation with an explicit error message.

Finally you will have to enable the support of C++14 or higher. This is set in `Project properties` -> `C/C++ Build` -> `Settings` -> `C++ Compiler` -> `General` and selecting either `C++ 14` or `gnu++14`. Be careful, since the _14_ in C++ means 2014 and _98_ stands for 1998, C++ 14 or 17 are actualy newer version than C++ 98.

Blinking !
------------------------------------------

Now it's time to shine ! 

#### Important notice 
_As of today, the linker script provided by Atollic isn't working. You may get a working one from a generated project from CubeMX or from a software package from ST (`STM32CubeF3` for example).
Once you have your new linker script, set your linker to use it in `Project properties` -> `C/C++ Build` -> `Settings` -> `C++ Linker` -> `General`_

In a source folder (`src/` for example) you should create your main file. Right-click on the folder, and select `New` -> `Source File` and call it `main.cpp`.

In this file, you may add the smallest code to start working with SooL : 

```cpp
#include "system_stm32.h"

int main()
{
	while(1)
	{
		//Your application here
	}
	return 0;
}
```

And, on a Nucleo 32 (with a STM32F303K8) the following should get you blinky.

```cpp
#include "system_stm32.h"
#include "GPIO.h"

int main()
{
	using namespace sool::ll;

        GPIOB->enableClock();
	PB3 = GPIO::Mode::Output | GPIO::Speed::Slow | GPIO::OutType::PushPull;

	while(1)
	{
		for(int i = 0; i < 50000; i++)
		{
			asm("nop");
		}
		PB3.toggle();
	}

	return 0;
}
```

