ASM=nasm
ASMFLAGS=-f elf64 -l $(@:.o=.lst)
CC=gcc
CFLAGS=-Wall -Wextra
LD=ld
LDFLAGS=-dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc
#LD=$(CC)		-alternative
#LDFLAGS=$(CFLAGS)	-alternative
CFILES=main.c
ASMFILES=VOut.s VString.s VPrintf.s
OBJFILES=$(ASMFILES:.s=.s.o) $(CFILES:.c=.c.o) 
EXEC=test.x


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) $^ -o $@

%.s.o: %.s
	$(ASM) $(ASMFLAGS) -o $@ $<

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -rf $(EXEC) *.o *.lst