#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct Element* Liste;
typedef struct Element
{
    char* nom;
    int type; // int = 0 float = 1
    int nature; // var = 0 cst = 1
    Liste suivant;
}Element;
Liste tete = NULL;
Liste currentInsertion = NULL;

typedef struct Aff_Operation* Affectation;
typedef struct Aff_Operation
{
    char* nom_partieG;
    int type_partieG;
    int type_partieD;
    Affectation suivant;
}Aff_Operation;
Affectation affectation_head = NULL;
Affectation constant_head = NULL;

void insert(char* nom,int type,int nature);
bool rechercher(char* nom);
void afficher();
void supprimer(Liste* tete);
int getType(char* nom);


void insert_Affectation(char *nom_partieG){
     Affectation tmp = (Affectation)malloc(sizeof(Aff_Operation));
     tmp->nom_partieG = nom_partieG;
     tmp->type_partieD = 3;
     tmp->type_partieG = getType(nom_partieG);
     tmp->suivant = NULL;
     if(affectation_head != NULL){
         Affectation last = affectation_head;
         while(last->suivant != NULL)
                last = last->suivant;
         last->suivant = tmp; 
     }
     else affectation_head = tmp;
}



void setAffectationType(int type_partieD){
      if(affectation_head == NULL){
      Affectation tmp = (Affectation)malloc(sizeof(Aff_Operation));
      tmp->type_partieD = type_partieD;
      affectation_head = tmp;
      }
      else{
          Affectation tmp_head  = affectation_head;
          if (tmp_head->type_partieD != type_partieD){
              tmp_head->type_partieD = 2;
          }
      }
}

int validerAffectation(char *nom_partieG){
    Affectation tmp = affectation_head;
    if(getType(nom_partieG) == tmp->type_partieD){
       free(tmp);
       affectation_head = NULL;
       return 0;
    }
    else{
        free(tmp);
        affectation_head = NULL;
        return 1;
        }
}

void setType(int type){
     Liste tmp_head = tete;
     while(tmp_head != NULL){
         if(tmp_head->type == 3){
             tmp_head->type = type;
         }
         tmp_head = tmp_head->suivant;
     }
}



int getNature(char* nom){
    Liste tmp_head = tete;
    while(tmp_head != NULL){
        if(strcmp(nom,tmp_head->nom) == 0){
            return tmp_head->nature;
        }
        tmp_head = tmp_head->suivant;
    }
    return -1;
}



int getType(char* nom){
    Liste tmp_head = tete;
    while(tmp_head != NULL){
        if(strcmp(nom,tmp_head->nom) == 0){
            return tmp_head->type;
        }
        tmp_head = tmp_head->suivant;
    }
    return -1;
}

void insert(char* nom,int type,int nature){
     Liste nouveau = (Liste)malloc(sizeof(Element));
     nouveau->nom = nom;
     nouveau->type = type;
     nouveau->nature= nature;
     nouveau->suivant = NULL;
     if(tete != NULL){
         Liste dernier = tete;
         while(dernier->suivant !=  NULL)
                dernier= dernier->suivant;
        dernier->suivant = nouveau;
     }
     else tete = nouveau;
     currentInsertion = nouveau;
}



bool rechercher(char* nom){
    Liste tmp = tete;
    while(tmp){
        if(strcmp(tmp->nom,nom) == 0)
           return true;
        tmp = tmp->suivant;
    }
    return false;
}



void afficher(){
    int i;
    for(i=0;i<80;i++)
    {
        printf("-");
    }
    printf("\n");
    Liste tmp = tete;
    while(tmp != NULL){
        char* type;
        char* nature;
        if(tmp->type == 0)
           type = "Pint";
        else type = "Pfloat";
        if(tmp->nature == 0)
           nature = "variable";
        else nature = "constante";
        printf("ENTITE : ");printf("%s\t",tmp->nom);
        printf("TYPE : ");printf("%s\t\t",type);
        printf("NATURE : ");printf("%s",nature);
        printf("\n");printf("\n");
        tmp = tmp->suivant;
    }
      for(i=0;i<80;i++)
    {
        printf("-");
    }
    printf("\n");
    
}



void supprimer(Liste* tete){
    while(*tete){
        Liste tmp = (*tete)->suivant;
        free(*tete);
        *tete = tmp;
    }
    *tete = NULL;
}
