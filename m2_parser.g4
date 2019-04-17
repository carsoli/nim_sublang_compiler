parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}

ind: INDENT+;
ded: DEDENT;

stmt: (CHAR_LIT CHAR_LIT | CHAR_LIT CHAR_LIT CHAR_LIT);

//module: (stmt (SEMI_COLON | DOT stmt)* )? ;

start: stmt;