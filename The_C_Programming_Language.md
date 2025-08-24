# The C Programming Language By K&R

## Chapter 7

### Section 7.7

In this section it talked briefly about how we can get inputs and outputs
from both some io pointer. The book shows examples of how fgets and fputs
are written in the standard library. This part was particuarly cool because
it is the first time I have used the register keyword in C.

### Section 7.8

This section was mainly covering what is included in the C standard library.
The book went over many miscellaneous functions that included string operations,
character operations and tests, command execution, math functions, and memory management.

## Chapter 8 - **The UNIX System Interface**

Review - From my initial review of the chapter it looks like the chapter
goes over numerous low level UNIX topics in the C language. What are file
descriptors and how do we use those in unison with low level inputs and
outputs. It highlights systemcalls totwards the end in preparation for the
three example projects. They have examples on how to program your own fopen(),
getc(), your own person version of 'ls', and a storage allocator.

### Section 8.1 - **File Descriptors**

Everything in the UNIX ecosystem is treated as a file. Everything from files
we write to, to a keyboard we connect to the computer through a USB is treated
as a file and given what is called a file descriptor. Additionally UNIX systems
assign the first three file descriptors to stdin, stdout, and stderr. They
hold the values 0, 1, and 2 respectively. This is why we are able to open
read and write to the terminal even if we have never opened a file or not.
We can also redirect the inputs and outputs from files using the '<' and '>'
operators in the terminal.

### Section 8.2 - **Low Level I/O - Read and Write**

Each linux syscall a set of defined parameters. For this section we were 
introduced to the Read and Write linux syscall. We can use these syscalls
to attach a file descriptor such as stdin or stdout to create our own versions
of the fputs and fgets.

### Section 8.3 - **Open, Creat, Close, Unlink**

These are all C standard library functions for system calls. Open is similar
to fopen but instead of returning a file pointer we return a file descriptor.
Creat works similar but it is for flushing a file or creating one new. Basically
it is for editing files. Close is the next step. Each file open from open, or creat
will need to have their file descriptor destroyed for reuse. Unlink is the final
funtion which removes a file from the file system.

### Section 8.4 - **Random Access - Lseek**

Lseek is the system call on UNIX to open a file at an arbitrary position.
We can decide to start at the beginning, end, or some offset in the file.
Lseek uses file descriptors but there is a similar function fseek which is
just a Wrapper function for the standard library. It has the same functionality.

### Section 8.5 - Example - **An Implementation of Fopen and Getc**

This chapter was really unique because it was my first experience with
implementing something low level like opening a file. It was great connecting
the links between Linux command line operators like > and 2> because the numbers
make significantly more sense. Things just fell into place because you define
all of the initial macros and arguments for the function. This includes
feof(), ferr(), fileno(), the total amount of files allowed to be opened at
one time. It extends to the actual structure of the FILE. I saw how getchar()
is a wrapper for the getc function with the inline value of stdin. Similarly
with putchar being a wrapper of the putc macro and stdout. There is a lot of
the "under the hood" mechanics that I have always wondered how worked. This
brought a lot of ideas to my head and things I want to try.

### Section 8.6 - Example - Listing Directories



### Section 8.7 - Example - A Storage Allocator
