ASM=nasm
ASMFLAGS=-f elf64 -l $(@:.o=.lst)
CXX=g++
CXXFLAGS=-Wall -Wextra
LD=ld
LDFLAGS=-dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc
#LD=$(CXX)		-alternative
#LDFLAGS=$(CXXFLAGS)	-alternative
CXXFILES=main.cpp
ASMFILES=VOut.s VString.s VPrintf.s
OBJFILES=$(ASMFILES:.s=.s.o) $(CXXFILES:.cpp=.cpp.o)
EXEC=test.x


$(EXEC): $(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^ 

%.s.o: %.s
	$(ASM) $(ASMFLAGS) -o $@ $<

%.cpp.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

clean:
	rm -rf $(EXEC) *.o *.lst