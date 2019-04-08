#include <stdio.h>
#include <stdlib.h>


const long HACK_BYTE_NUMBER = 0x104;
const int JNE_VALUE = 0x75;
const int JE_VALUE = 0x74;


int main(int argc, char **argv)
{
	if(argc != 2)
	{
		printf("input error\n");
		return EXIT_FAILURE;
	}

	FILE *prFile = fopen(argv[1], "r+b");
	if(!prFile)
	{
		printf("Error\n");
		return EXIT_FAILURE;
	}

	int checkErr = fseek(prFile, HACK_BYTE_NUMBER, SEEK_SET);
	if(checkErr == -1)
	{
		printf("wrong file\n");
	}
	else
	{
		int c = fgetc(prFile);

		if(c == JNE_VALUE)
		{
			fseek(prFile, -1, SEEK_CUR);
			fputc(JE_VALUE, prFile);
			printf("file changed\n");
		}
		else
			printf("wrong file\n");
        }

	fclose(prFile);

	return EXIT_SUCCESS;
}