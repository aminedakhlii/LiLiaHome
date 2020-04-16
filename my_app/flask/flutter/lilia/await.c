#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
void response (char * cmd);

void get_command(FILE * f , char * previous){
    char command[50] ;
    fgets(command,50,f) ;
    //printf("actual command : %s\n",command);

        if (strcmp(previous,command) == 0){
             //break ;
    }
        else{
             strcpy(previous,"");
             strcpy(previous,command);
             response(command);
             //break ;
    }
}

void response (char * cmd){
    char * response = malloc(2);
    FILE * fp = popen(cmd , "r");
    FILE * ret = fopen( "response.txt" , "w" ) ;
    char c ;
    int i = 0  ;
    while ( (c = getc(fp)) != EOF  ){
        response[i] = c ;
        i++ ;
        if( i > 0 ) response = realloc(response, strlen(response) + 1 ) ;
    }
    response[i] = '\0';
    printf("actual response : %s" , response);
    pclose(fp);
    fputs(response , ret);
    free(response) ;
    fclose(ret);
}

int main(){
   FILE * cmdtmp = fopen("commands.txt" , "r");
   char command[50] ;
   fgets(command,50,cmdtmp);
   fclose(cmdtmp);

     while (1){
     FILE * cmd = fopen("commands.txt" , "r");

         get_command(cmd , command) ;



      fclose(cmd);
      sleep(1);
     }


   return  0;
}