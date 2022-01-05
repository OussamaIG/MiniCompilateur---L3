#include <stdio.h>
#include <stdlib.h>

typedef struct Element* Liste;
typedef struct Element
{
    int data;
    Liste suivant;
};
Liste tete = NULL;
void inserer(int valeur){
     Liste tmp = (Liste)malloc(sizeof(int));
     tmp->data = valeur;
     tmp->suivant = NULL;
     if(tete != NULL){
         Liste last = tete;
        while(last->suivant != NULL)
                last = last->suivant;
        last->suivant = tmp; 
     }
     else tete = tmp;
}
void afficher(){
    Liste tmp = tete;
    while(tmp){
        printf("%d ",tmp->data);
        tmp = tmp->suivant;
    }
}
int main()
{
  printf("%d\n",tete);
  inserer(3);
  printf("%d\n" , tete);
  inserer(17);
  inserer(18);
  afficher();
  printf("%d\n" , tete);
}
