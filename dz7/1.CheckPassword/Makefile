ASM=nasm
ASMFLAGS=-f elf64
LD=ld
LDFLAGS=-s
ASMFILES=main.s
OBJFILES=$(ASMFILES:.s=.o)
EXEC=test.x


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.s
	$(ASM) $(ASMFLAGS) -l $(@:.o=.lst) $<

clean:
	rm -rf $(EXEC) *.o *.lst