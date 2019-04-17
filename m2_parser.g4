parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}

op1: (ASSIGNMENT_OPERATOR );
op2: AT | COLON; 
op3: OR | XOR;
op4: AND; 
op5: EQUALS_OPERATOR | ((LESS_THAN | GREATER_THAN)| EQUAL?) | IS | ISNOT | IN | NOTIN | NOT | OF; 
op6: DOT DOT;
op7: AND_OPERATOR;
op8: ADD_OPERATOR | MINUS_OPERATOR | BITWISE_NOT_OPERATOR | OR_OPERATOR; 
op9: MUL_OPERATOR | DIV_OPERATOR | DIV | MOD | SHL | SHR | MODULUS;

op10: 
operator: op1 | op2 | op3 | op4 | op5 | op6 | op7 | op8 | op9 | STATIC;

// no comment lexemes 
comma: COMMA;
semicolon: SEMICOLON;
colon: COLON; 

ind: INDENT;
ded: DEDENT;


ifStmt: IF expr COLON stmt
        (ELIF expr COLON stmt)*
        (ELSE COLON stmt)?
        ;

simpleStmt: (
        returnStmt 
        | raiseStmt 
        | yieldStmt 
        | discardStmt 
        | breakStmt
        | continueStmt 
        | pragmaStmt 
        | importStmt 
        | exportStmt 
        | fromStmt
        | includeStmt 
        | commentStmt 
        |  exprStmt
        );

// sectionConstant: ;
// sectionTypeDef: ;
// sectionVariable: ;

complexStmt: (
        ifStmt 
        | whenStmt 
        | whileStmt
        | tryStmt 
        | forStmt
        | blockStmt 
        | staticStmt 
        | deferStmt 
        | asmStmt
        | PROC routine
        | METHOD routine
        | ITERATOR routine
        | MACRO routine
        | TEMPLATE routine
        | CONVERTER routine
        | TYPE sectionTypeDef
        | CONST sectionConstant
        | (LET | VAR | USING) sectionVariable
        | bindStmt 
        | mixinStmt
        );


stmt: ind (complexStmt | simpleStmt) (SEMICOLON (complexStmt | simpleStmt))* ded
    | (simpleStmt (SEMICOLON simpleStmt)*;

// module:

start: stmt;