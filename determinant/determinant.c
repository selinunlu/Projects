#include "determinant.h"

void SatirDegisikligi(float matris[][100],int row,int col){
	
	int i,j,k;
	float gecici;
	for(i=0 ; i<row-1 ; i++){
		if(matris[i][i]==0){
			for(j=i+1 ; j<row ; j++){
				if(matris[j][i]!=0){
					for(k=0 ; k<row-1 ; k++){
						gecici=matris[i][k];
						matris[i][k]=matris[j][k];
						matris[j][k]=gecici;
					}
					for(i=0;i<row;i++){
						for(j=0;j<col;j++){
							matris[i][j]=(-1)*matris[i][j];
						}
					}		
				}
			}	
		}
	}		
}

void Bastir(float matris[][100],int row,int col){
	
	int i,j;
	for(i=0 ; i<row ; i++){
		for(j=0 ; j<col ; j++){
			printf("%f\t",matris[i][j]);
	    }		
		printf("\n");	
    }	
}

void GaussEliminayon(float matris[][100],int row){
	
	int i,j,k;     
	int n=row;    
	float sabit;
    for(j=0 ; j<n-1 ; j++){
    	for(i=0 ; i<n ; i++){
			if(i>j){
		   		 for(k=0 ; k<n ; k++){
	    			if(k==0){
						sabit=(matris[i][j]/matris[j][j]);
	    			}
	    			matris[i][k]=matris[i][k]-(sabit*matris[j][k]);	        
	    		}		
	  		}
	    }
    }		
}

float DeterminantHesapla(float matris[][100],int n){
	
	int i,j;       
	float det=1;
	for(i=0 ; i<n ; i++){      
    	for(j=0 ; j<n ; j++){
			if(i==j){	
	  			det=det*matris[i][j];
			}
		}
    }
  	printf("\n det=%f",det);	
  	return det;
}
