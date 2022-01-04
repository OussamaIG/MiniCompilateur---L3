%{
#include <stdio.h>
#include<string.h>
#include "syntaxique.tab.h" 
int ligne=1;
int col=0;
extern YYSTYPE yylval;
%}
chiffre [0-9]
lettre [a-z]
pint {chiffre}{chiffre}*
pfloat [1-9]{chiffre}*[.]{chiffre}{chiffre}*
CONST {pfloat}|{pint}
idf {lettre}({lettre}|{chiffre}|_)*(({lettre}|{chiffre}))*
%%
Program {return key_Program;col=col+yyleng;}
PDEC {return key_Dec;col=col+yyleng;}
PINST {return key_Inst;col=col+yyleng;}
Begin {return key_Begin;col=col+yyleng;}
End {return key_End;col=col+yyleng;}
Pint {return key_pint;col=col+yyleng;}
Pfloat {return key_pfloat;col=col+yyleng;}
"@define" {return key_define;col=col+yyleng;}

FOR {return key_For;col=col+yyleng;}
WHILE {return key_While;col=col+yyleng;}
DO    {return key_Do;col=col+yyleng;}
ENDFOR    {return key_Endfor;col=col+yyleng;}

IF    {return key_If;col=col+yyleng;}
ELSE  {return key_Else;col=col+yyleng;}
ENDIF {return key_EndIf;col=col+yyleng;}

{idf} {if(yyleng <= 12){yylval.str=strdup(yytext);return key_idf;}col=col+yyleng;}
{pfloat}     {yylval.pfloat=atof(yytext);return pfloat;col=col+yyleng;}
{pint}       {yylval.entier=atoi(yytext);return pint ; col=col+yyleng;}

"+"     {return key_plus;col=col+yyleng;}
"-"     {return key_soustraction;col=col+yyleng;}
"/"     {return key_division;col=col+yyleng;}
"*"     {return key_multiplication;col=col+yyleng;}

">"     {return key_bigger;col=col+yyleng;}
"<"     {return key_smaller;col=col+yyleng;}
"<="     {return key_biggerorequale;col=col+yyleng;}
">="     {return key_lessorequale;col=col+yyleng;}
"=="     {return key_equlate;col=col+yyleng;}
"=!"     {return key_notequale;col=col+yyleng;}

":"     {return key_deux_points;col=col+yyleng;}
";"   {return key_point_virgule;col=col+yyleng;}
"|"     {return key_or;col=col+yyleng;}
"("     {return key_parenthese;col=col+yyleng;}
")"     {return key_parenthese_end;col=col+yyleng;}
"<--" {return key_affectation;col=col+yyleng;}

"!"     {return key_diffrent;col=col+yyleng;}
"&"     {return key_and;col=col+yyleng;}

[ \t]   col++;
\n      {ligne++;col=0;}

.       {printf("\nErreur lexical la ligne %d et colonne %d\n",ligne,col);}

%%
int yywrap(void)
{
return 0;
}
