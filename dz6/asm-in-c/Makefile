ASM=nasm
ASMFLAGS=-f elf64 -l $(@:.o=.lst)
CC=gcc
CFLAGS=-Wall -Wextra
LD=$(CC)
LDFLAGS=$(CFLAGS)
CFILES=main.c
ASMFILES=VOut.s VString.s VPrintf.s
OBJFILES=$(ASMFILES:.s=.s.o) $(CFILES:.c=.c.o)
EXEC=test.x


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^ 

%.s.o: %.s
	$(ASM) $(ASMFLAGS) -o $@ $<

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -rf $(EXEC) *.o *.lst