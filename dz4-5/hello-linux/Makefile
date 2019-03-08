ASM=nasm
ASMFLAGS=-f elf64
LD=ld
LDFLAGS=-s
OBJFILES=hello.o
EXEC=a.out


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.s
	$(ASM) $(ASMFLAGS) -l $(@:.o=.lst) $<

clean:
	rm -rf a.out *.o *.lst