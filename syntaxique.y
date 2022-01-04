%{
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
S : Entete key_Begin liste_instructions key_End {printf("accepted !\n");YYACCEPT}
;

Entete : key_Program key_idf  key_Dec liste_declaration key_Inst
;

liste_declaration : listevar key_deux_points type key_point_virgule liste_declaration 
                  | listevar key_deux_points type key_point_virgule  
                  | key_define key_pint key_idf key_affectation constante key_point_virgule liste_declaration
                  | key_define key_pfloat key_idf key_affectation constante key_point_virgule liste_declaration 
                  | key_define key_pint key_idf key_affectation constante key_point_virgule
                  | key_define key_pfloat key_idf key_affectation constante key_point_virgule
;

type : key_pint
      | key_pfloat 
;

constante : pint
          | pfloat
;

listevar : key_idf key_or listevar
         | key_idf
;

liste_instructions : inst
                   | inst liste_instructions
;

inst : inst_affectation
     | inst_boucle
     | inst_condition
;

inst_affectation : key_idf key_affectation expression_arith key_point_virgule
;

inst_affectation_sanspvr : key_idf key_affectation expression_arith
;

expression_arith : expression_arith key_plus expression_arith
           | expression_arith key_soustraction expression_arith
           | expression_arith key_multiplication expression_arith
           | expression_arith key_division expression_arith
           | key_idf
           | constante
           | key_parenthese expression_arith key_parenthese_end
;

inst_boucle : key_For inst_affectation_sanspvr key_While pint key_Do liste_instructions key_Endfor
;

inst_condition : key_Do liste_instructions key_If key_deux_points key_parenthese condition_complex key_parenthese_end key_EndIf
               | key_Do liste_instructions key_If key_deux_points key_parenthese condition_complex key_parenthese_end key_Else liste_instructions key_EndIf
;

condition_complex :   condition_complex key_and condition_simple 
                    | condition_simple
                    | condition_complex key_or condition_simple
;

condition_simple :  expression_arith operation_cmp expression_arith
                 |  key_parenthese condition_simple key_parenthese_end
                 |  key_diffrent condition_simple
;

operation_cmp :    key_biggerorequale
                |  key_equlate
                |  key_notequale
                |  key_smaller
                |  key_lessorequale
                |  key_bigger
;

%%

int yyerror(char* msg)
{
    printf("%s ligne %d et colonne %d",msg,ligne,col);
    return 0;
}
int main()
{   
    yyin = fopen("try.txt", "r");
    yyparse();
    return 0;
}
