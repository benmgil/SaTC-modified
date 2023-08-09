#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char buf[10];
int func1(int integ, char* arg, char* str){
	if (integ != 1){
		return 1;
	}
	char buf[10];
	//strcpy(buf, str);
	system(str);
	return 0;
}

void setupBuf(){	
	memset(buf, '\0', 10);
	strncpy(buf, "hello", 5);
}

int main(int argc, char* argv[]){
	if(argc != 2){
		printf("Usage: %s <string>\n", argv[0]);
		exit(1);
	}
	//char* stri = "hello";
	setupBuf();
	char anotherBuf[10];
	memset(anotherBuf, '\0', 10);
	strncpy(anotherBuf, buf, 5);
	return func1(1, argv[1], anotherBuf);
}
