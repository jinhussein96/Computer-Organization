
#include<iostream>
#define MAX_SIZE 100
using namespace std;


int CheckSumPossibility(int num,int arr[],int size )  {
       int ret=0;
       int ret2 = 0;
        if (num == 0 ){
            return 1;
        }
        
         if (size == 0 && num != 0)
            return 0; 
    
        ret = CheckSumPossibility(num,arr,size-1); 
      //return ret + CheckSumPossibility( num - arr[size-1],arr, size - 1) ;
       ret2 = CheckSumPossibility( num - arr[size-1],arr, size - 1) ;
       return ret || ret2;
       
    }

  
int main(){
    int ret2;
    int arraySize;
    int arr[MAX_SIZE];
    int num;
    int returnVal;
    cin>>arraySize;
    cin>>num;
    for(int i=0;i<arraySize;++i){
        cin>>arr[i];
    }

    returnVal=CheckSumPossibility(num,arr,arraySize);
   
    if(returnVal == 1){
        cout<<"Possible!"<<endl;
    }
    else{
        cout<<"Not possible!"<<endl;
    }
    return 0;
}


