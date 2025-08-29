# Reverse Engineering For Beginners

## Code patterns

### 1.1 The method

The author of the book while learning C/C++ used to compile small snipets of his code and analyze the assembly. By doing this repetition he was able to envision what his programs would look like before he even compiled them.

The exercises he mentions in the book is to compile those small snipets of code and look at the assembly output and rewrite is gradually trying to make it as small as possible. You want to do this with zero compiler optimizer flags enabled. Thise flags will try and optimize both the performance and also the size of the code. The author also mentions this is not practical for writing efficient assembly compilers do this at a much fast and accurate rate than you can but it helps grasp the concepts of assembly and learn a lot. 

### 1.2 Some basics

This is a short i troductions to things like cpus and machine language type and jow numbers are representes on a computer. 

#### 1.2.1 A short introduction to the CPU

The CPU is what reads and executes the machine code given by a program. The suthor includes a small glossary of what words to know like instruction which is a primitive CPU command. Something like moving data from one place to another. Machine code which is the direct bits the CPU reads. Assembly language is next which just refers to mnemonic code to make the programmers life easier. There are a lot of sifferent type of assembky languages but they all have the goal of the level before machine code. Lastly CPU registers and the number of registers on different systems like an x86 or x86-64 system. Revisters are constantly X amount of untyped variables of length 32bits or 64bits. The author did a great job if explaining it as imagine you were peogramming in Java a high-level programming language and you had 16 variables and that was it. You can atill make any program even though you have only 16 variables. 

The author talks about different ISAs for assembly languges. Ppinting out the fact that instruction sets all have different lengths for their instructions. Some have variable insteuction lengths and other keep the max insteuction length to 4bytes some even as small as 2bytes. ISAa like ARM are kept at 4-bytes an instruction and the ISA Thumb is kept at 2-bytes. The creatirs of Thumb wanted to extend Thumbs capabilities so it could compete sith ISAs like ARM so they invented Thumb-2. Thumb-2 Is not a combination between ARM and Thumb rather it was meant to fully support all processor features. 

#### 1.2.2 Numeral Systems

Numeral system talks about the differences between base 10 and binary. Pointing out computers use binary and the number 10 has no use scientifically. The author also mentions radix's which are how many digits are in a number system. For example base 10 has radix 10 there are 10 different digits 0-9 to represent every number. Base 2 only has 0-1 two digits to represent every number. 

#### 1.2.3 Converting from one radix to another

Starting the author explains about positional notation and non-positional notation. Most numeric systems are ppaitional meaning the further to the left a number is the more significant it is. For instance the digit 1 has more weight in the number '100' than in the number '10'. The same goes for binary, the digit 1 in '0b1000' has more significance than '0b10'. This is how we are able to break down binary and base 10 numbers into sections for each digit. You can see this in the number 1234 is the same as 10^3 * 1 + 10^2 * 2 + 10^1 * 3 + 10^0 * 4. Each digit is multiplied by its radix to the power of its position minus one. 

Now representing these binary numbers are very verbose when you get into larger numbers or even just insteuctions. So we compress then into another numeric system base 16 or hexadecimal. We take our generic 0-9 and include 6 latin characters to represent numbers in hexadecimal. In most cases we will prefix our hexadecimal junbera with a 0x. There is another similar numeric system for computers and thats octal with is a base 8 numeric system with radix 8. 

The interesting thing about all numeric systems is that when you see a decimal number like 120 we know its divisible by 10. This same concept works for other sustems for example binary 0b11101000 is divisible by 0b1000. The same is true for both hex and octal 0x3cde210000 is divisible by 0x10000. 

For multi-precision integers the radix scales with the number of bits used to represent it. Basically if you have 8-bits per chunk your radix is 256 and if you have 32 bits your radix is 2^32 bits. 

### 1.3 An empty function

Arguable the simplest function ia one that does notiong or just returns. 

#### 1.3.1 x86

The assembly generated on an x86 platform is just a 'ret' instruction inside a 'f:' label. F being the function name. 

#### 1.3.2 ARM

On an ARM system the assembly is one line longer. This is because on ARM the return address is not stored on the atack but rather the link register. This requires you to use 'bx lr' causes execution to jump to that address effectively returning to the previous function before the adress was called. 

#### 1.3.3 MIPS

In MIPS assembly it ises a single j (jump) instruction followed by the register used in jumps. In GCC assembly you will often see the numeric value of the register and in an interactive disassembler like IDA or Ghidra you while see is pseudo name. 

#### 1.3.4 Empty functions in practice

It may seem like an empty function is meaningless but they are wuite popular eapecially in debugging. You will have debug function with #ifndef _DEBUG clauses for a prototype build. When you actually want to release the code for production you willnot include thise defines and will be left with an empty function. Similarly a build for customers and a build for demos. The other functions defined will be left empty. 

### 1.4 Returning values

Another simple function is one that returns a constant integer. 

#### 1.4.1 x86

In an x86 assembly system there are only two instructions. The first moves the value into the eax register which by convention hold return values. This first instruction is followed by the ret instruction. 

#### 1.4.2 ARM

Similar to x86 ARM by convention uses the r0 register for storing return values. It uses the mov instruction to do so. This might sound misleading because the value is not loved from one place but copied from one place to the next. This instruction is followed by the return instructions 'bx lr'. 

#### 1.4.3 MIPS

MIPS follows the same conventions as the others with a jump and a load with an 'li' instruction for load immediate. The odd factor in MIPS is that the jump is before the li instruction. What makes it interesting is the load instruction following the jump is executed before the jump. This is because of a quirk in the RISC called "branch delay slot". As a consequence to the jump preceding the load but executing after is that the branch instruction always swaps with the instruction immediately preceding it. 

### Hello world

The most famous C profram is most definitely the hello world program. 

#### 1.5.1 x86

The author compiled the program with MSVC 2010 and used the /Fa compiler flag to generate the assembly program. MSVC uses the Intel-syntax for assembly. In out case the assembly for the hello world file we have two segments one for the const (for constant data) and one for the text(code). Because while inline the steing "hello world" into the function it is jot givin a name. What we see in the const section of the program is that string, followed by a null character, with an auto generated name. Looking back at the code we only have one function which is out main() function. This function starts with prologue code and ends with epilogue code. This is stabdard for almost any function. After our prologue code we can see the call to the printf function, but before the function call we push the const char string onto the stack with push. Following the printf call is an add esp, 4. This is necessary because the pointer to the string is still on the stack so we need to add 4 bytes on a 32-bit system to do the equivalent of a pop on the stack. Some compulers might emit pop as an instruction but they are basically the same as adding the offset. The only difference is POP is 1 byte instruction and ADD is 3 bytes. After the printf the original C/C++ code contains return 0. This is a standard in C/C++ code where returning 0 ondicates no errors and anything else is a form of an error. In our assembky we accomplish this with xor eax, eax instruction again because eax is the standard return value and then ret. The reason it is xor not mov eax, 0 or sub eax, eax is because of the slightly smaller opcode. the opcase for xor is 1 whereas mov is 5 bytes. The ret in the case returns in function to the caller which in this case is the OS. 

The author compules the same C/C++ code with the GCC compuler so we can see how different compilers have different results. In the GCC compiler it strts similar woth the same epilogue code. This epilogue code has one different and that is it ANDs esp the stack register with 0FFFFFFF0h to alaign the stack pointer with the 16-byte boundary. This going back to that numeric division with different radixes. The reason we align the stack is for performance reasons on the CPU. The second difference is that the esp stack loint is subtracted by 10h 16 bytes which allocates 16 bytes if storage on the stack. Although 4 bytes are needed we still alocate 16-bytes because that is what we aligned out stack pointer with. After allocating soace on out stack instead of pushing values to the stack we store them directly onto the stack with a mov opcode. In this instance var_10 is a variable and an argument for printf(). Like we mentioned in MSVC the most optimal way to set a register to 0 is xor eax, eax. We do nit do this with the GCC compiler it opts for the mov eax, 0 instruction. This can be changed if we add optimization levels to our compile command. The last opcode leave is used to reset our stack pointer esp and ebp register. This is necessary because we mosified them at the start if our function. 

Previously we were working with Intel Syntax but now we are switching things up to work with AT&T assembly syntax. In the AT&T syntax we see a lot of macros being used in the program that we can ignore for now instead we want to just look at the opcodes being used. We can instantly see some differences like every register has a % prefix and every integer has a $ prefix. We can also see that unlike in Intel syntax where it is opcode, <destination operand>, <source operand> AT&T is switch with opcode <source operand>, <destination operand>. The third difference would be the size of an operand. There is a suffix added to the instruction; b for byte whoch is 8 bits, w for word which is 16 bits, l for long which is 32 bits, and lastly q for quad which is 4 words a quad word at 64 bits. The only difference from the AT&T syntax is the use of -16 as the and value which is synonymous to the and value used in intel syntx. 

We are able to instepct the bytes of a system in most hex editors. In most hex editors you can display the hex vakues alongside the ascii values. They most of the time give you the ability to change the values so we can potentially change the string being displayed in our hello world program. We could change the text into spanish if we really wanted like the author did and still emd the text with a 0A00 hex values for a new line character and a null character. Be carefull not to edit anything past what the original length is just because theyre are ann null bytes doesnt mean they are free to edit. 

We can do a similar thing in Linux using radare. We can strt by searching the program for the string. If we get a hit for the string we are looking for we can seek to move to that current address. With a combination of commands like px to print the binary and oo+ to open in read/write mode we can write with w followed by the string we want displayed instead. 

This ability to write over strings in executables has its place. One some images that have watermarks if you look through and found the string that the watermarks drew on the image you could replace it with spaces and the watermark would disappear. Another example the author mentions is translating program from english to russian. You coukd replace the English equivalents with russian acronyms as russian is slightly longer than english in word length. 

#### 1.5.2 x86-64

In x86-64 all registers were exte ded to 64-bits with all their names having an r prefix. In order to pass values to functions faster rather than use the stack meaning acces external memory/cashe less we can use the registers rcx, rdx, r8, and r9. These registers are known as fastcalls where part of the argumwnts the the function are passing in registers and the other in the stack. In our function we can see we use these registers specifically the rcx register to pass the pointer to the string into the printf function. x86-64 maintains backwards compatibility so you are still able to access the 32-bit part of a register. You can access all the following rax/eax/ax/al. This is important because in the main function we return the int 0 so we only need to xor the eax part of rax. Something the author will mw tion later is the 40 bytes alocated to the stack. 

The first program in x86-64 was compiled with MVSC and this one is compiled with GCC in 64-bit Linux. Any Linux, *BSD, and Mac OS X also use registers as arguments to functions. The first 6 registers rdi, rsi, rcx, rdx, r8, and r9 are all used and after those 6 we use the stack. In our profram we used the rdi register but only used the edi section of the register ti load the string pointer. We are able to do this because anytime we load or mov a value into the lower 32-bits it clears the upper 32-bits to all 0s automatically. The reason we assume GCC uses the 32-bit register edi instead of the 64-bit register rdi is because the instruction is 5 bytes long with edi and 7 bytes with rdi. We also see that the eax register is cleared right before the printf call. This is due to the ABI standards that the eax register is to hold the number of used vector registers on *NIX systems on x86-64. 

#### 1.5.3 ARM

When we first me tions differents ISAs ARM uses a fixed instruxtion size of 4-bytes. We can see this actually in the dissassembly of the hellow world program. The very first instruction STMFD SP!, {R4,LR} is the same as an x86 push by writing the two register values onto the stack. The instruction on the inside decrements the SP (stack pointer) so it points to the right place on the stack. The it loads the values in R4 and LR into the adress stored in the modified SP. The unique factor about STMFD is that it can save multiple addresses at once and is lot limited to the stack pointer. You can use the function to store registers at a specific memory address. The ADR R0, aHelloWorld instruction adds or subtracts the PC register to the offset where the hello workd string is located. This is called "position-independant-code" where the program can be ran at a non-fixed address. The code takes into account where the PC address currently is and where the string is located in the program. subtracts to get the difference. This difference is always the same so this offset is what we always add to the PC in order to get the absolute memory address of the string. The BL _2printf is what called the printf function. We store the address following the BL instruction into the LR register and the set the PC to the address of printf(). In ARM each function needs information about where it needs to return to thats why we pass the following addres to the function call into the LR register. This is the difference between RISC processirs with ARM and CISC processors with x86 where ARM stores the return address in lr and x86 stores it on the stack. A side note is that absolute return addresses cannot be encoded in the BL instruction because the instruction is 1 byte so we are left with 3 bytes or 24 bits for the address. We can increase this number to 26 bits when we take into account that ARM instructions are all 4-bytes long. He ce, they can only be on a 4-byte boundary implying the last two bits are always 0s. This gives us that 26 bits for addressing which is approximately 32M addresses. Next our function moves 0 into register R0 because our C function returns 0. The last opcode LDMFD DP!, R4,PC works just like a pop on the stack. Remember back to the start of the program when we saved LR onto the stack with STMFP. Well this basically loads the LR return value into the PC so we can pass control to where the function was called. All of this code was compile in ARM mode the next section covers Thumb mode. 

Thumb mode is effectivly a compressed version of the ARM mode. Each instruction is 2 bytes long except the BL opcode is separated into two instructions. This is because there is not enough space in the 16-bit opcode so it splits the first 10-bits into the first instruction and the lower 11 in the second. Thumb instruction have a size of 2 bytes so it is impossibke to have an odd address. With this in mind we have 21 bits plus the 22nd bit which is garunteed to be 0 equaling approximately 2M of adressing space. Thumb ARM also includes the PUSH and POP opcodes and do not explicitly mention the SP register. 
 
