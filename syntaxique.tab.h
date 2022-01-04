
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     key_Program = 258,
     key_Dec = 259,
     key_Inst = 260,
     key_Begin = 261,
     key_End = 262,
     key_For = 263,
     key_While = 264,
     key_Do = 265,
     key_Endfor = 266,
     key_If = 267,
     key_Else = 268,
     key_EndIf = 269,
     key_pint = 270,
     key_pfloat = 271,
     key_define = 272,
     key_plus = 273,
     key_soustraction = 274,
     key_division = 275,
     key_multiplication = 276,
     key_affectation = 277,
     key_bigger = 278,
     key_smaller = 279,
     key_biggerorequale = 280,
     key_lessorequale = 281,
     key_equlate = 282,
     key_notequale = 283,
     key_and = 284,
     key_or = 285,
     key_diffrent = 286,
     key_parenthese = 287,
     key_parenthese_end = 288,
     key_deux_points = 289,
     key_point_virgule = 290,
     key_idf = 291,
     pint = 292,
     pfloat = 293
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 14 "syntaxique.y"

int entier;
float pfloat;
char *str;



/* Line 1676 of yacc.c  */
#line 98 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


