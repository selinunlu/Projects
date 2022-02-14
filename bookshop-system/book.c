#include "book.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int myStrcmp(char *s1,char *s2){

	int result;
	int i;
	for(i=0 ; s1[i]!='/0' && s2[i]!='/0' ; i++){
		if(s1[i]==s2[i]){
			result=0;
			break;
		}			
		else if(s1[i]<s2[i]){
			result=-1;
			break;
		}		
		else{
			result=1;
			break;
		}			
	}
	return result;	
}
