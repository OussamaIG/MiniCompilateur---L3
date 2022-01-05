%{
#include "fonction.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
extern int ligne;
extern int col;
extern FILE* yyin;
int yyparse();
int yylex();
int yyerror(char *s);
%}

%union
{
int entier;
float pfloat;
char *str;
}
%start S
%token key_Program key_Dec key_Inst key_Begin key_End key_For key_While key_Do key_Endfor key_If key_Else key_EndIf
%token key_pint key_pfloat key_define key_plus key_soustraction key_division key_multiplication key_affectation
%token key_bigger key_smaller key_biggerorequale key_lessorequale key_equlate key_notequale key_and key_or key_diffrent key_parenthese key_parenthese_end key_deux_points key_point_virgule
%token <str>key_idf
%token <entier>pint
%token <pfloat>pfloat
%left key_plus key_soustraction
%left key_multiplication key_division
%right key_parenthese key_parenthese_end

%%
S : Entete key_Begin liste_instructions key_End {printf("accepted !\n");afficher();YYACCEPT}
;
Entete : key_Program key_idf  key_Dec liste_declaration key_Inst
;
liste_declaration : listevar key_deux_points type key_point_virgule liste_declaration 
                  | listevar key_deux_points type key_point_virgule  
                  | key_define key_pint key_idf key_affectation pint key_point_virgule liste_declaration {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else insert($3,0,1);
                    }
                  | key_define key_pint key_idf key_affectation pfloat key_point_virgule liste_declaration {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else {
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , INCOMPATIBILITE DE TYPE",ligne,col);
                        YYABORT;
                    }
                    }
                  | key_define key_pfloat key_idf key_affectation pint key_point_virgule liste_declaration {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else {
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , INCOMPATIBILITE DE TYPE",ligne,col);
                        YYABORT;
                    }
                    }
                  | key_define key_pfloat key_idf key_affectation pfloat key_point_virgule liste_declaration {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else insert($3,1,1);
                    }
                  | key_define key_pint key_idf key_affectation pint key_point_virgule {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else insert($3,0,1);
                    }
                  | key_define key_pint key_idf key_affectation pfloat key_point_virgule {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else {
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , INCOMPATIBILITE DE TYPE",ligne,col);
                        YYABORT;
                    }
                    }
                  | key_define key_pfloat key_idf key_affectation pint key_point_virgule {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else {
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , INCOMPATIBILITE DE TYPE",ligne,col);
                        YYABORT;
                    }
                    }
                  | key_define key_pfloat key_idf key_affectation pfloat key_point_virgule {
                      if(rechercher($3) == true){
                        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , CONSTANTE DEJA DECLARE",ligne,col);
                        YYABORT;
                    }
                    else insert($3,1,1);
                    }
;
type : key_pint {setType(0);}
      | key_pfloat {setType(1);}
;
listevar : key_idf key_or listevar {
          if(rechercher($1) == true){
              printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VARIABLE DEJA DECLARE",ligne,col);
              YYABORT;
          }
          else insert($1,3,0);
         }
         | key_idf {
          if(rechercher($1) == true){
              printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VARIABLE DEJA DECLARE",ligne,col);
              YYABORT;
          }
          else insert($1,3,0);
         }
;
liste_instructions : inst
                   | inst liste_instructions
;
inst : inst_affectation
     | inst_boucle
     | inst_condition
;
inst_affectation : key_idf key_affectation expression_arith key_point_virgule{
    if(rechercher($1) == true){
         if(getNature($1) == 1){
             printf("ERROR SEMANTIQUE , VOUS POUVEZ PAS CHANGER LA VALEUR D'UNE CONSTANTE");
             YYABORT;
         }
         else {
              if(validerAffectation($1) == 1){
                  printf("ligne %d , colonne %d : ERROR SEMANTIQUE , INCOMPATIBILITE DE TYPE",ligne,col);
                  YYABORT;
              }
         }
    }
    else{
        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VARIABLE NO DECLARE",ligne,col);
        YYABORT;
    }
  
  }
                 
;
expression_arith : expression_arith key_plus expression_arith
           | expression_arith key_soustraction expression_arith
           | expression_arith key_multiplication expression_arith
           | expression_arith key_division expression_arith
           | key_idf {
               if(rechercher($1) == true){
               setAffectationType(getType($1));
               }
               else{
                    printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VARIABLE NON DECLARE",ligne,col);
                    YYABORT;
               }
            }
           | pint {
              setAffectationType(0);
           }
           | key_soustraction pint {
              setAffectationType(0);
           }
           | pfloat {
              setAffectationType(1);
           }
           | key_soustraction pfloat {
              setAffectationType(1);
           }
           | key_parenthese expression_arith key_parenthese_end
;
inst_boucle : key_For inst_affectation_boucle key_While key_idf key_Do liste_instructions key_Endfor{
    if(getType($4) == 1){
        printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VOUS POUVEZ PAS UTILISER REEL",ligne,col);
        YYABORT;
    }
}
           | key_For inst_affectation_boucle key_While pint key_Do liste_instructions key_Endfor
;
inst_condition : key_Do liste_instructions key_If key_deux_points key_parenthese condition_complex key_parenthese_end key_EndIf
               | key_Do liste_instructions key_If key_deux_points key_parenthese condition_complex key_parenthese_end key_Else liste_instructions key_EndIf
;
condition_complex : condition_complex key_and condition_simple 
                    | condition_simple
                    | condition_complex key_or condition_simple
;
condition_simple :  key_diffrent condition_simple
                 |  expression_arith operation_cmp expression_arith
                 |  key_parenthese condition_simple key_parenthese_end
;
operation_cmp :    key_biggerorequale
                |  key_equlate
                |  key_notequale
                |  key_smaller
                |  key_lessorequale
                |  key_bigger
;
inst_affectation_boucle : key_idf key_affectation expression_arith_boucle {
        if(rechercher($1) == true){
            if(getNature($1) == 1)
            {
                printf("ERROR SEMANTIQUE , VOUS POUVEZ PAS UTILISER UNE CONSTANTE DANS UNE BOUCLE");
                YYABORT;
            }
            else
            {
                // vérification de comptabilité
            }
         }
        else
        {
           printf("ligne %d , colonne %d : ERROR SEMANTIQUE , VARIABLE NO DECLARE",ligne,col);
           YYABORT;
        }

}
;
expression_arith_boucle : expression_arith_boucle key_plus expression_arith_boucle
           | expression_arith_boucle key_soustraction expression_arith_boucle
           | expression_arith_boucle key_multiplication expression_arith_boucle
           | expression_arith_boucle key_division expression_arith_boucle
           | key_idf
           | pint
           | key_parenthese expression_arith_boucle key_parenthese_end
;

%%

int yyerror(char* msg)
{
    printf("%s ligne %d et colonne %d",msg,ligne,col);
    return 0;
}
int main()
{   

    yyparse();
    return 0;
}
