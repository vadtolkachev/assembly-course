#include <stdio.h>

extern "C" void VPrintf(int a, int b, int c, int d, int e, int f, const char *str, ...);

int main()
{
	VPrintf(0, 0, 0, 0, 0, 0, "hello world!\nI %s %x %d %% %c\n", "love", 3802, 100, 31);
	
	return 0;
}