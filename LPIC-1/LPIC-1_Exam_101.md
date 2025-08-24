# LPIC-1 Exam 101 (Linux Professional Institute)

LPIC-1 Exam 101 Version 5.0 is the Learning Materials for the first half of the Linux Professional Institute Certificate 
level 1 (LPIC-1). It covers four main sections about System Architecture, Linux Installation and Package Management, GNU 
and Unix Commands, and Devices, Linux Filesystems, Filesystem Hierarchy Standards.

## System Architecture

### 101.1 Hardware settings

This sections informed the reader about different ways to debug problems with hardware. Three main commands are introduced 
as follows lspci, lsusb, and lsmod. Lspci shows a list of all the PCI devices connected to your system which includes 
graphics cards, network adapters, SATA connections, ect. This lists device IDs, and the descriptions of the devices connected. 
For a longer description of specific devices you will specifying the devicewith -s {`deviceID`} and -v for verbose output. 
We can check which kernel drivers these devices use using the same -s flag with a new -k flag. This tells us information 
about the current kernel driver in use and kernel modules in use. The next section is very similar with lsusb. It lists 
all connected usb devices on your system and you can do a similar type of search with the device ID. Moving on to lsmod 
which lists all of the currently running modules on your system. The output also includes the modules that depend on the 
listed module. Those commands are the interfaces between the real hardware files stored in /proc, /sys, and /dev. The 
directories /proc and /sys are very similar is their roles by storing kernel related data. /dev is used to hold storage 
devices partions such as /dev/sda, /dev/sdb, ..., /dev/sdn. 

### 101.2 Boot the system

Throughout this section you mainly talk about the different ways to boot a computer through BIOS and UEFI and what a bootloder
is. The main different between BIOS and UEFI is how old they are. UEFI is newer with a few extra quality of life updates
like secure boot. You learn about what the bootloader controlls and potentially what values you can change about the boot
sequence. When the systems is officially loading into the RAM we create these daemons that help keep control flow smooth
during the boot operation. They also can have various tasks after the operating system is loaded.

### 101.3 Runlevels, boot targets, and shutdown/reboot system

You get a high level understanding of how the boot process in Linux works. For older machines you have things like SysV which
is configured to boot your operating system. In most modern Linux architectures they use the systemd file to manage system
resources and services called units. There are several different types of units that systemd create. These units you can control
with commands like systemctl to start, stop, restart, and check statuses. We can also reboot the entire system with the 
shutdown command which takes a mandatory time parameter and and optional opention and message parameters.

## Linux Installation and Package Management

### 102.1 Design hard disk layout

You start with disks, partitions, filesystems, and volumes. Each disk is its own physical memory but a partition is a section
of memory that is for a specific type like storing information on the OS. LVM helps manage your partitions so if you need
more storage in one area you can add more to your partition without moving the data to a larger device.

Before reading the contents of some file systems you need to mount it. You can techincally mount a file system in any directory
that exists. Removable devices are automatically mounted onto a system in the new '/Media/USER/LABEL'. USER the the user
who plugged in the removable device and LABEL is the name of the device.

Separate your storage into multiple disk partitions. You can keep boto related things on their own partition because they
are executed and read in first. You can also separate the root file system from the home directories so your root system
will always stay intact.

Swap is a partition that can not be mounted like the rest of the files. It is used to copy data stored in the RAM inside
of the disk storage.

LVM is a ver complicated in it's implimentation but is very versatile. It is a dynamic form of memory storage opposed to the
static approach to typical partitions and file systems.

### 102.2 Install a boot manager

You install a bootloader on your system because the bootloader is what loads the kernel and then passes control to it. GRUB
is the most standard bootloader on Linux. One most systems your boot partition is located on the first partition. GRUB allows
you to select which partition you would like to load. When booting a system using GRUB 2 you will see a menu of entries. These
entries can be selected to load or edited with `Enter` and `e` respectively. If you decide to edit an entry you can load a
GRUB 2 shell by pressing `c` while in the menu screen. In the GRUB 2 shell we have a small list of command line tools we can use
to interact with the partitions on the entry. We can also boot to linux from the GRUB shell. If your GRUB 2 hash issues loading
an entry you will be put into a recovery shell whith less GRUB 2 commands but enough to fix and boot your system from the terminal.

### 102.3 Managing shared libraries

There are two main types of libraries in Linux. You have the shared libraries and static libraries. The only difference between the
two is that shared libraries are linked to a program where static libraries are copied into the program during compilation. You can
configure the shared library files in the /ect/ld.so.conf.d directory. This directory stores all of the configuration files for your shared
libraries so it can create or refresh .so links on boot. This requires ldconfig to be ran every time a conf file is added or updated. 
To determine dependencies of other programs we can use the ldd command to find which shared libraries are needed. Similarly we can use
this command on other shared libraries to see what dependencies they have. 

### 102.4 Use Debian package management

In early Linux there were not package managers to install software. The developer would be required to compile and configure 
the package themselves. As software got more complex people create package managers like .deb with dpkg and (Advanced Package Tool) apt. 
With .deb packsges you have to manually install all of the missing dependancies. You are also able to do simple commands for information
about some package. With apt it will automatically install or remove dependancies when you initiate the commands. You have a plethera of
options ranging from installing, removing, cleaning your cache, updating, etc. APT gets its library database in the form of a file called
sources.list. This file is formated by each line representing a library. To add a new library to download using apt you can add it to the
bottom of the sources.list file. You can also add file to the /ect/apt/sources.list.d directory to add more repositories if you do not want 
to modify the main sources.list file. They are formatted the same way. You can also search file specific files using apt. The difference with
apt from dpkg in this scenario is that dpkg on searches the repositories installed while apt can search uninstalled repositories as well. 

### 102.5 Use RPM and YUM package management 

This whole section was similar to the previous with rpm being synonymous with dpkg but for RedHat distributions. This is the same for yum
and apt. The final package manager is dnf for Fedora. Dnf is a fork of yum just for the Fedora distribution so many of the commands are the same. 

### 102.6 Linux as a virtualization guest

Virtual machines are machines thats hardware is emulated by software. You use hypervisors to control these VM connections. There are different
hypervisor for Linux such as Xen, KVM, and VirtualBox. There are three main type of virtualization. Full virtualization is when the operating 
system does not realize that it itself is a virtual machine instance. Paravirtualization is when the software is aware of being a virtual instance. 
This means we can create software driverse that are often faster than going through the original drivers on our system. This makes them faster than full 
virtualization. The last type is a Hybrid system. These systems use the same paravirtualized drivers on the fully vertualized machines.
Many hypervisors store the configuration of their virtual machines using .xml files. Virtual machines need to use specific types of disk images. 
These images follow rules like COW (copy-on-write) that only allocates more storage to the VM if it needs it. Where a RAW image has all of the image
pre-allocated. In addition to there images you can set up either a NAS or SAN and use programs like oVirt to write your VMs data to and keep track
of which sections belong to which VMs. When looking to purchase virtual machines through an *IaaS* you need to look at hiw much comouting power we
are going to use, how much sotrage were going to need, and how much network connection do we have. The most commin way for developers to connect
to there service is through ssh. Containers are another form of virtualization but they only run the software required than emulate everything. 

## GNU and UNIX Commands

### 103.1 Work on the command line

#### Lesson 1

There are countless comands in GNU and UNIX this can make it challenging to remeber them all. Thankfully we can use a handfull of the cli tools to 
aid in finding details about our systems like our `pwd` or using `uname -a` to get your kernel version. Notice the -a flag we used with the uname command. 
To understand what options and flags we have for each tool we can look at the man pages as a reference. In the event we forget what a command is called we 
can use the `apropos` command to search through the man pages for specific key words. Some commands can be very complex and take a lot of effort to create.
These commands are often easily forgotten which is why the `history` command is great for retrieving previously ran commands. Combining this with `grep` we can
find the exact commands we ran with little effort. 

#### Lesson 2

You have lots of tools and commands you can run but that is not everything you can do on the command line. You also have environmental variables. to get a list
of all of the variables on your system you cam start by running `env`. We can also locally create our own variables usin the syntax `VARIABLE_NAME=VALUE`. Notice how
there are no spaces. Again this is a local environmental variable. To pass the variable to child shells we can use the `export` command. You can use double quote to
include special characters in commands like a space or parenheses. You can accomplish a similar feature with single quotes but note that single quotes will preserve
the original value. 

### 103.2 Process text streams using filters

Linux follows the UNIX philosophy of writing programs that manage one task well and programs that work together. Linux is able to accomplish this with pipes and 
redirects. These use the standard io streams stdin, stdout, and stderr when applicable to input streams of data to and from files and programs. Using text streams
is a universal interface so try to implement them in your programs. Pager programs are used to view text that is interactable with commands such as searching
or stepping through. `sed` is a stream editor that can be used to search and trasform streams of text. It is a powerful tool that is also able to change occurances
in a stream. For example if I wanted to change all the words 'his' to 'hers' I. eed only run the command `sed s/his/hers/ < file.txt` where < directs the
input of the file into the program. Verifying the integrity of a file is critical on any system. Linux makes it very easy to check the validity of a file with checksums.
There are programs dedicated to this functionality such as **sha256sum**, **sha512sum**, **md5sum**, ect. Text is the universal interface but for computers they understand 
octal and hex just as well. In Linux there are numerous ways to view a file in hex or octal format such as `od` or `xxd`. 

### 103.3 Perform basic file management 

#### Lesson 1

Everthing in Linux is a file. Knowing how to manage them is an important skill. There are three main types of files in a system. You have **regular files** for storing data 
and programs. **Directories** which are files used to store other files. Lastly you have **special files** which are used to control input/output. An example of a special file 
could be stdin or stdout. Linux has resources for manipulating files such as listing dorectories woth `ls`, changeing to a new directory with `cd`, or copying a regular file 
with the `cp` command. Each command has one task and it does that one task well. All of these programs are what make Linux so versatile and there ability to work together. 
These commands can be combined with file globbing and wildcards which are used to represent multiple files in a single command. Adding an asterisk (*) represents a wildcard
so we can select and print all files that end with the phrase ’.conf' by using the command `cat *.conf`. 

#### Lesson 2

As I mentioned earlier everything in Linux is interpreted as a file. This makes find a specific file an important task. In Linux you can use the `find` commNd with the following 
parameters **STARTING PATH**, **OPTIONS**, and **EXPRESSION**. You can specify which type if file you are trying to look for to narrow down the searches. You can also specify the 
size of a file or when it was last modified. There is a similar feature to the pipe (|) with find. We can execute commands after finding certain files with the `-exec` option. 
Another important tool in you Linux kit is archiving and compression. You want to be able to compress files that you can move and tranfer to other systems easily. This requires
a tool like `tar`. Tar always requires a single command some of the most common being **--create(-c)**, **--extract(-e)**, and **--list(-l)**. Another took to create archives is the
`cpio` command. It takes a list of files from the standard input (mostly from `ls`) through a pipe into the `cpio` command. `dd` is another form of `cp`.

### 103.4 Use streams, pipes, and redirects

#### Lesson 1

Keeping with the theme, files in Linux are also represented by their respective *file descriptor*. This is a numeric value
associated with the files programs can use to reference input and output data streams. Redirects are used to pass the contents of
a specified file descriptor in or out of a program. Sometimes you will want to redirect the ouput of stderr to stdout so it can be parsed through some
program after being redirected through stdin. We cannot directly go from stderr to stdin. In the shell you are able to assign different fd's to input and outpur streams 
for programs to use. For instance we can redirect a file using `3<` to assign that file to the file descriptor 3. Here Documents/Strings 
are similar to multiline and single line strings as inputs to tools via stdin. 

#### Lesson 2

Pipes are another ,ethode of redirecting input and output though they work different from traditional redirects. Pipes are meant for commands and work in
order from left to right. The output will be piped to the other program through stdin. `tee` can be used in conjunction with `|` to output to two different file descriptors. 
When we run the command `grep 'model name' < /proc/cpu_info/ | uniq | tee cpu_model.txt` The output will be directed to stdout and store inside the `cpu_model.txt` file. 
Pipes are unable to capture stderr so a redirect `2>&1` needs to be added to add stderr to stdout. Another way to manipulate commands output is hrough command substitution. 
Command substitution involes including a command in a set of back quotes. A way to combine this technique with pipes is using the `xargs` command. Xargs parses the results 
or the pipe and interprets it line by line for your specefied command. 

### 103.5 Create, monitor, and kill processes

#### Lesson 1

System administrators must need to know how to create and manage their processes. Jobs are processes you start from the terminal, sent to the background, and have not 
finished execution. With the `jobs` command we can specify options to list more information like pid's of processes running. `jobs` also includes commands to query
currently running processes. There are two states a process can be in, the `background` and `foreground`. The `fg` command moves the specified process to the foreground
making it the current job. You can automatically send a command to the background using the `&` post-fix. You can finally terminate a process using the `kill` command. 
The issue with these commands is they are session dependant, meaning if the session is closed the processes are also closed. To get
past this issue we can prefix our commands with `nohup` command. Every process or task is just a command you run in your terminal. You want a way to
monitor those processes and we can do this with the `watch` command. **Watch** will run a specific command in intervaals so you can *watch* the process
change over time. There are wrappers to grep and kill which are `pgrep` and `pkill` used to search and kill running processes. `top` is another program that
is used the manage processes. Top loads data dynamically about the memory usage and CPU usage of all the current running processes. Top is
interactable and you can run a list of commands to sort the output of `top`. The `ps` command gives a snapshot of either all the running processes with the `a`
option of by specifying the PID with `-p PID`. 

#### Lesson 2

Another way to manage processes are through the use of multiple terminals or *screens*. The `screen` command is used to create a form of terminal emulation in forms of a screen. You are able to have many screen in a windows and through a series of keybinds we can change the names to match there process. Windows all run independent of each other and when one screen is in the foreground other screens will keep running their programs. A unique function of `screen` is the ability to split your terminal and have two regions. It is also possible to control more than one session of screens. we can list all of the screens running on our system with `screen -list`. Screen has a vim like gui is has a **screen** that you are interacting with. This means you can configure keybinds and settings inside normal configuration files. 

By using the `tmux` command we can have control of multiple terminal sessions from one interface just like you would have multiple options in a physical multiplexer. Tmux has support for naming the session and the window names with `-s` and `-n` respectively. tmux interface keybinds is `Carl+b` compared to screen which interfaces with the `Ctrl+a` keybind. Tmux is very similar to screen with the ability to copy and paste as well as customize the screen and keybindings. You can also add your own custom keybinds. 

### 103.6 Modify process execution priorities

Most processes executing on a computer are being multi processed. On computers it is possible to witch from one process to another quick enough to simulate running multiple processes at once. We keep a queue of all the processes waiting for the output of their respective system call. However, some processes might spawn that have a significantly greater importance. This is where the Linux scheduler comes into play. The scheduler is what organizes the queue. Each process is given a priority which we can read by viewing the PRI column in the `ps -el` command. For historical reasons we need to add an addition 40 to the value to get the correct PRI value. There are real-time and normal priorities. Real-time priorities are programs ran by your OS. The priorities will always take demand over a normal priority. The lower a priority is the more serious a task it is. We can wee this in ps or top by the fast that real-time priorities are covered through values 0-99 where normal priorities cover values 100-39. `Niceness` is a factor in determining if a process is willing to let other processes go ahead of it in the queue or if it is not willing to move.

### 103.7 Search text files using regular expressions

#### Lesson 1

Regular expressions are string formats that are made up of character *atoms*. These atoms are a single character and mean their literal value. There are a few characters that do not follow this scheme and have special meanings. Like the `.` which means match with ANY character, or `^` which means match this phrase with the beginning of the line. Linux offers two different type of regular expressions. "Basic" regular expressions and "extended" regular expressions. They are both very similar except basic regular expressions are for simpler cases. When you need less functionality and a simple pattern. The reason is for all the quantifiers `*`, `+`, and `?` the only one you do not need a prefix backslash is the asterisk. In extended regular expressions there is no need for the backslash unless you want the literal meaning of the characters. This is a small example on the differences but it is meant to illustrate that basic expressions are meant for small patterns and extended are meant for complex cases. Regular expressions also have bounds. You are able to decide a boundary for the number of characters you want to include in your patter. Reyes includes branching different patterns. A branch is similar to a programming OR statement. You are trying to verify the first occurrence of some pattern and you go through each branch to see if the pattern matches. Back referencing in a powerful tool in reagular expressions. It allows you to reference previous matches by the sub expression in parentheses. Regex is a universal syntax. We are able to send regex strings as command inputs. We can send an input into the find command to *find* all the files with X pattern. 

#### Lesson 2

In my experience `grep` is the most common way to use regular expressions. Grep uses regular expressions to parse inputs from pipes or files and these are different wrappers for more specific cases. Grep is a line by line pattern searcher so it pairs perfectly with reagular expressions. Grep has two wrapper commands which are `egrep` and `fgrep`. Egrep is the same as the `grep -E` command and it enables extended regular expressions. Fgrep is used to force grep to use string literals and not parse any regular expressions. 

`Sed` was mentioned previously and is a stream editor. This means that the text is parsed and edited as on entire stream. You write commands to edit the stream you do not make any physical changes yourself. Sed can execute multiple commands in the cli by separating them with a ';' and wrapping the commands in quotes. You can replace strings in sed commands with regular expressions by wrapping the expression in '/'. This method of using reqular expressions supports basic regular expressions. 

### 103.8 Basic file editing

Modern programmers use graphical editors for write code. Before graphical operating systems `vi` was the way programmers would edit files. Vi stood for **visual** an interactive text environment. There are multiple different modes in vi the most common two are *insert* and *normal*. Insert mode is used to add text to the file. Normal mode is often often referred to as command mode for navigation and text manipulation. Not only does vi have a plethora of commands to run in the fit or but you are able to create registers to copy and paste text that persists throughout your session. Run commands multiple times with a number prefix, set marks at points in text to jump back to, and create macros that allow you to surround text with quotes, parentheses, or brackets. There are also a list of commands you can run in vi that are similar to sed syntax. An example would be swapping with th syntax `s/REGEX/TEXT/g`. These commands are always prefixed with a colon `:`.

## Filesystem Hierarchy Standards

### 104.1 Create partitions and filesystems

On any operating systems disks need to eb partitioned before they can be used. The info on partitions is stored in a partition table. Each partition is treated like disk even if the all reside on the same disk. This lessons main goal is to teach about how to create, delete, restore, and resite partitions using the most common utilities. There are two main ways of storing partition information. Through the MBR (Master Boot Record) and the GPT (GUID Partition Table). MBR is a legacy way to store partition tables. There are restrictions like how many partitions of a single disk or the size of the largest disk. GPT is a modern solution and  has no max disk size and the number of partitions is operating system dependant. `Fdisk` is the first utility that you can use to manage MBR partitions. When running the command you need to run it as root and make usre to include the disk directory not one of its partitions. This would look like `/dev/sda` not `/dev/sda1`. In the menu for `fdisk` you are able to create new partitions, check for unallocated space, and print the current partition table. Keep in mind, when deleting a partition, if you delete an extended partition, the logical partitions inside will also be deleted. When creating a new partition you need to make sure you have enough **continuous** space that is unallocated to create a new partition. You cannot assume that the partition type is the same as the filetype. Lets move on to `gdisk` to manage *GUID Partitions*. Gdisk has a similar interface as fdisk, the relationship is synonymous to the relationship with tmux and screen. Deleting partitions is the main way gaps appear in your partition table. Gdisk allows you to move partitions and remove these gaps. Gdisk has options for recovering corrupt disk files, you can get a list of the recovery commands by typing `?`. Partitioning he disk is the first step towards creating a proper file system. There are a lot of different type of filesystems for each operating system but Linux focuses on the *Extended Filesystem (ext)*. Linux has a standard tool built in to create these filesystems `mkfs`, which comes in many "flavors". Throughout the years ext filesystem has gotten many updates from ext2, ext3, and ext4, which is the current default. `Mkfs` has many useful commands one that stands out to me is `-n` because it echos the changes it *would* make befre it actually makes the changes. This allows the user to test and debug their script before fully commiting to their filesystem. Linux supports other file system types like **XFS** which is a high-performance filesystem. This type of filesystem is like the TCP of file systems. It is primarily used in web servers because of its performance and reliability of transmission. XFS filesystems are separated into at least two partitions, one for **logging** and another for **data**. Something I forgot to mention earlier is to specify which filesystem you want to create with `mkfs` is to add the type of filesystem you would like to create to the command `mkfs` with dot notation like so `mkfs.xfs`. `Mkfs.xfs` has it's own set of command line options to run. FAT and VFAT are two legacy file file systems that come with a list of drawbacks. They are generally used in systems that done support newer file systems or small storage devices like flash drives or SD cards. In 2006 Windows developed a new FAT called exFAT which is supported on the three largest OSs and because or it's cross compatibility it is great for larger flash drives or SD cards. Btrfs file systems are useful for a resilient system even through crashes because of their copy-on-write functionality the file system does not discard the old file till it is 100% sure. Btrfs supports sub volumes to partitions as well. These sub volumes can be accessed just like any other directory. You also have the option to create snapshots which are populated with the contents of the snapshot location. It is also possible to create read-only snapshots. The btrfs also includes smart compression. It will be able to compress a filesystem with one of three algorithms `ZLIB`, `LZO`, or `ZSTD`. It is able to skip files that are unable to be compressed and move onto the next one. Wrapping up, GNU also gives us access the a command-line tool *GNU Parted* for managing partitions. It is able to create, delete, move, resize, and rescue partitions of either GPT or MBR disks. It can cover almost all of your disk management needs so is a useful tool to learn. It does have support for a GUI but you can never 100% rely on having a GUI system or system that supports the GUI so it is recommended to learn the cli. To manage a device you would enter `# parted DEVICE` in the terminal. Parted works similar to the other tools `fdisk` and `gdisk` by prompting the user with a menu and the ability to enter commands like `print` to print info or `mklabel` to generate a partition table. Parted is flexible with may filesystems and has many of the same utilities. Resizing ex2/3/4 filesystems is another important task in system administration. There are a few rules to follow before starting. If you want to increase the size of a filesystem you need to first make sure you have enough space after to grow in size. Once you confirm you have enough space you can increase the size of the partition. This is not the last step, you are still required to update your filesystem it resides in. To shrink a filesystem you need to do everything in reverse. There are partitions that sole purpose is to help swap files from RAM to disk as needed. To create one of these filesystems you need a special partition and to create it use the `mkswap` command. You can create the same aprtition with `fdisk` or `gdisk` with the type `82` and `8200` respectively.  

### 104.2 Maintain the integrity of file systems

All modern Linux filesystems are *journaled*. This means that there is a record of all the commands run in an internal log. This can be used during system crashes to check the last ran command and repair any damage. This is not a 100% soution there are still need for cli tools to debug complex filesystem errors. `du` is a simple command that shows you the total disk usage in the currect directory. You can get it in a gumar readable format witht the `-h` option. Including the `-a` option shows the individual size of each file in the directory. There are lots of other usefull options with the `du` command but the main focus point of du is it shows us information at the file level. The command `df` shows us information at the filesystem level. Modifying the output using `df` is a simple process. Include the `--output=` followed by a list of comma separated list of fields you wish to display. The same can be done with inode fields. Checking your ext2,3, and 4 filesystems is possible with the Linux provided command `fsck`, *filesystem check*. It is important to always run `fsck` on **unmounted** filesystems, otherwise there is a chance to lose data. `fsck` is not the command responsible for checking the system. It's main priority is to call the correct function to garuntee recovery. As a common precaution on ext filesystem every time it is mounted a counter is incremented. Once this counter reaces the maximum value, the Linux system will reset this value to zero, and automatically call the `e2fsck` command on the filesystem. There is a speific Linux tool used to tune these specific values like *mount count* nammed `tune2fs`. This is where you interface with your filesystem configuration and have the ability to *tune* specifications. Journals were a new addition to the ext3 filesystem so they were not included in the original ext2 eddition. Adding your own journal to the ext2 fs is simple with `tune2fs -j $EXT2_FS_DIR`. After adding the journal update the type of filesystem so it is abel to use the journal. An xfs equivalent to `fsck` is `xfs_repair`.

### 104.3 Control mounting and unmounting of filesystems

Mounting files is crucial in Linux system management. Mounting files is taking a device you want and mounting it at an accessible location in the filesystem. This can be accomplished with the `mount` command. Similarly to unmount a filesystem you can use the `unmount` command. Sometimes when unmounting a device a process could be in the middle of using some of it's resources. To locate which files are being used by what process use the `lsof` followed by the name of the device. This will give a list of information but if we want to easily kill this process we can use the outputed PID to kill the process. There are good practices to follow to maintain smooth and consistem system administration. When mounting files make sure to mount them in the appropriate directory. For any manual tasks the standard library is `/mnt`. Each filesystem has its own unique identifier called a UUID. This UUID can be used to specify which partitions to mount on boot in the `/etc/fstab` file. You can mount systems from systemd if you desire. Each partition you want to mount you will create a new *mount unit*. These mount units are configuration files for each partition to include what it is called, where to mount it, etc. To finish your configuration file you need to make sure the mount unit has the same name as the mount point. Once this is complete run the `systemctl` command to reload the daemon and start the mount. There is another configuration option with systemd. The ability to automatically mount a device when the filesystem is accessed. This requires another .automount file in the same `/ect/systemd/system/` directory where we added our original mount unit files.

### 104.5 Manage file permissions and ownership

Linux can support multiple users on a single system this can get tricky if one user should not be allowed to look at another users file. Linux's solution is file permissions and there are three levels. One for the user who created the file, one for any groups who would need access to the file, and finally everyone else. To get a files current permissions the easiest way is to list the directory in long form using `ls -l`. On the far left side of the output text we can see all the permissions `r` read, `w` write, and `x` execute. The first character is the type of file and every three characters after that represent a group mentioned earlier. The first group is the permissions for the user who created the file. The second group is for the group user permissions and so forth. To modify this permissions we can use the command `chmod` follow by the new permissions to add or remove and then lastly includes the files or directories to apply the changes to. There are two modes, symbolic and octal. Symbolic uses `+-` and character symbols to represent the permissions where octal uses the binary values to turn on and off the bits respectivly. One tip to notice about file permissions in octal mode is that the least significant bit determines if the octal numeber is even or odd. So if we set our `chmod` value to something even we know it **is not** executable and if we set it to an odd value we know that it **is** executable. Similarly to the permissions on who can access a file you can change the ownership of a file with `chown`. There are multiple options for changing groups and users and you do not need a ser or group you can ommit it if you do not want to set the permissions. You can query information about groups like what groups are on your system or which users are in certain groups. There are default permissions for every file you create, weather it is a .txt file or a directory they will have default permissions. You can view the default permissions in text symbolic format with the command `umask -S`. We can edit the permissions of the umask for our current session as well. This means we can change it so only users and groups have permissions to file and anyone not in those groups has no access (`---`). The umask value is the inverse of the chmod values. There are special flags that exit in Linux like the sticky bit which prevent any file from being deleted from a directory unless it is owned by the user. This has no effect on ordinary files and just directories. To add any special permission we use `chmod XXXX $FILE` with a four digit notation. There are other options like Set GID to persist the flagged directories group onto the sub-directories and files. The Set UID permission works the same as the GID but for users.

### 104.6 Create and change hard and symbolic links

Linux has another form of file called a link. There are two different types of links being **symbolic links**, also called *soft* links which point to another file. They are called *soft* links because if their reference point gets destroyed they will remain. The other type of link is a **hard** link. These links are *hard* because they are somewhat like a second name for the original file. To start with hard link we can create them with the `ln` command. These links all refer to the same data on the disk. This means that the other links still persist even after deleting one of the links. It simple deletes the inode refering to the data stored on the disk. These hard links can be moved and removed freely without the worry of "breaking" the link. Creating symbolic links is similar with the addition of the `-s` to the `ln` command. Symbolic links offer lots of the same functionality as the hard links but because hardlinks are dependant on the filesystem you are unable to use them on different filesystems without breaking the link. Symbolic links are pointers to the original file path so they are able to work across filesystems but can break if the target is moved or the link is moved.

### 104.7 Find system files and place files in the correct location

There is a standard the most Linux distributions follow for a standard file system. This is important for system administration because it makes organization easy. Included in this standard format for the filesystem comes with lots of useful commands for finding, locating, and moving files around your system. One of the more elementary commands, however still useful, is `find`. You are able to locate files in your system matching with regex patterns. There are lots of useful parameters to search complex queries with `find`. Another option to search for a specific file is `locate`. Locate works similarly to find with the slight difference of it searching in a local database you define. You can update the current selection of files with the `updatedb` command. This needs to be done frequently otherwise you might recieve inaccurate results. We can control `updatedb` with a config file in `/ect/updatedb.conf`. One useful command is `which` which shows the path to an executable like `which cat` or `which bash`. There are other options that are similar to this command like `type` or a more informative version `whereis`. `whereis` will also show the location of the man pages. 
