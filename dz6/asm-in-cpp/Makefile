ASM=nasm
ASMFLAGS=-f elf64 -l $(@:.o=.lst)
CXX=g++
CXXFLAGS=-Wall -Wextra
LD=$(CXX)
LDFLAGS=$(CXXFLAGS)
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