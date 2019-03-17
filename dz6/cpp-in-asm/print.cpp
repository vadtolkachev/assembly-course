#include <stdio.h>
#include <stdarg.h>


extern "C" void cPrint(int a, int b, int c, int d, int e, int f, const char *format, ...)
{
	va_list args;
	va_start(args, format);
	vprintf(format, args);
	va_end(args);
}


void cppPrint(int a, int b, int c, int d, int e, int f, const char *format, ...)
{
	va_list args;
	va_start(args, format);
	vprintf(format, args);
	va_end(args);
}

