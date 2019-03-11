ASM=nasm
ASMFLAGS=-f elf64
LD=ld
LDFLAGS=-s
OBJFILES=test2.o VOut.o VString.o VPrintf.o VIn.o
EXEC=test.x


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.s
	$(ASM) $(ASMFLAGS) -l $(@:.o=.lst) $<

clean:
	rm -rf $(EXEC) *.o *.lst