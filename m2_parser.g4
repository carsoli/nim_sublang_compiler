parser grammar m2_parser;

/*=================================
    GRAMMAR
==================================*/

// stmt: CHAR_LIT;

// module: (stmt (SEMI_COLON | DOT stmt)* )? ;

start: module;