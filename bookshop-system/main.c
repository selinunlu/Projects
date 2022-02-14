#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "book.h"

int main() {
	
	char *k_adi1="selinbeyza";
	char k_adi2[15];
	
	char *sifre1="BS";
	char sifre2[15];
	
	int hak=3;
	
	printf("You can try up to 3 times.\n");
	
	while(hak-- >0){		
				
		printf("User Name: ");
		scanf("%s",&k_adi2);
		printf("Password : ");
		scanf("%s",&sifre2);
				
		if(myStrcmp(k_adi1,k_adi2)==0 && myStrcmp(sifre1,sifre2)==0){
			printf("WELCOME!");
			break;
		}
		else{
			printf("Try again..\n\a");			
		}		
	}
	
	FILE *pFile;
	pFile=fopen("theFileOfBooks.txt","r");
	
	if(pFile==NULL){
		printf("Dosya acma islemi basarisiz\n");
	}
	
	else{
		char name[40];		
		char writer[40];	
		char publisher[40]; 
		char numberOfPage[40];	
		char yearOfPrinting[40]; 	
		char price[40];
		char stock[40];
		bool flag =0;
		
		printf("SEARCH");
		printf("NAME OF BOOK OR WRITER?..");
		printf("1- for name of book\n");
		printf("2- for writer\n");
		int sayi;
		char b_name[40];
		char b_writer[40];
		scanf("%d",&sayi);
		
		if(sayi==1){
			printf("Enter the name of book: ");
			scanf("%s",&b_name);			
		}
		
		else if(sayi==2){
			printf("Enter the writer: ");
			scanf("%s",&b_writer);
		}
		
		else{
			printf("1 or 2");
		}
			
		while(!feof(pFile)){			
			fscanf(pFile,"%s %s %s %s %s %s %s", name, writer, publisher, numberOfPage, yearOfPrinting, price, stock);	
			
			if(sayi==1){
				if(myStrcmp(name,b_name)==0){
					printf("%s, %s, %s, %s, %s, %s, %s", name, writer, publisher, numberOfPage, yearOfPrinting, price, stock);
					flag=1;
				}													
			}
		
			else if(sayi==2){
			
				if(myStrcmp(writer,b_writer)==0){
					printf("%s, %s, %s, %s, %s, %s, %s", name, writer, publisher, numberOfPage, yearOfPrinting, price, stock);
					flag = 1;
				}										
			}							
		}
		
		if(flag==0){
			printf("The book is not found\n");
		}
		
			
		}
	
	
	fclose(pFile);

	return 0;
}
