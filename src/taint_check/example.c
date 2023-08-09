#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int func1(int integ, char* arg, char* str){
	if (integ != 1){
		return 1;
	}
	char buf[10];
	//strcpy(buf, arg);
	system(str);
	return 0;
}


int main(int argc, char* argv[]){
	if(argc != 2){
		printf("Usage: %s <string>\n", argv[0]);
		exit(1);
	}

	return func1(1, argv[1], "hello");
}
