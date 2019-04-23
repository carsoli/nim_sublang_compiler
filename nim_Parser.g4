parser grammar nim_Parser;
options {language='Python3'; tokenVocab=m2_Lexer;}

@parser::members{
parKeyWList = [IF, WHILE, CASE, FOR, BLOCK, CONST, LET, WHEN, VARIABLE]
literals = [INT_LIT, INT8_LIT, INT16_LIT , INT32_LIT , INT64_LIT, UINT_LIT , UINT8_LIT , 
UINT16_LIT , UINT32_LIT , UINT64_LIT, FLOAT_LIT , FLOAT32_LIT , FLOAT64_LIT, STR_LIT, 
RSTR_LIT , TRIPLESTR_LIT, CHAR_LIT, NIL ]
primarySuffixList = [SYM_HEADER, IDENTIFIER, TYPE] + literals
}

ind: INDENT;
optInd: ind?;
ded: DEDENT | EOF;

typeKeyw: VARIABLE | REF | PROC;
parKeyw: DISCARD | IF | WHILE | CASE
        | FOR | BLOCK | CONST | LET
        | WHEN | VARIABLE;

op0: OP0;
op1: OP1 | EQUALS;
op2: OP2 | (COLON COLON) | COLON ;
op3: OP3;
op4: OP4;
op5: OP5 | IN | OF | NOT ;
op6: OP6 | (DOT DOT) | DOT;
op7: OP7;
op8: OP8;
op9: OP9;
op10: OP10;
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 
        | op7 | op8 | op9 | op10;
prefixOperator: operator;

simpleExpr: assignExpr (OP1 assignExpr)*;
assignExpr: orExpr (OP2 orExpr)*;
orExpr : andExpr (OP3 andExpr)*;
andExpr : cmpExpr (OP4 cmpExpr)*;
cmpExpr : sliceExpr (OP5 sliceExpr)*;
sliceExpr : ampExpr (OP6 ampExpr)*;
ampExpr : plusExpr (OP7 plusExpr)*;
plusExpr : mulExpr (OP8 mulExpr)*;
mulExpr : dollarExpr (OP9 dollarExpr)*;
dollarExpr : primary (OP10 primary)*;

literal: INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
        | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
        | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
        | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
        | CHAR_LIT
        | NIL;

generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;
symbol: symbolBody
        | SYM_HEADER symbolBody SYM_HEADER
        | IDENTIFIER;
        // | keyw

// symbolWHeader: SYM_HEADER symbolBody SYM_HEADER | symbolBody;
symbolBody:( 
                // keyw | 
                IDENTIFIER | literal | 
                (operator | OPEN_PAREN | CLOSE_PAREN | OPEN_BRACK |
                CLOSE_BRACK | EQUALS)* 
        );  


exprColonEqExpr: (expr|simpleExpr) (COLON|EQUALS (expr | simpleExpr) )?;
arrayConstr: OPEN_BRACK exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_BRACK;
tupleConstr: OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN;


identOrLiteral: generalizedLit | symbol | literal | par | arrayConstr;
identGeneral: generalizedLit | symbol | par | arrayConstr;


primarySuffix: 
        OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN
      | DOT symbol generalizedLit?
      | OPEN_BRACK (simpleExpr | expr) (COMMA (simpleExpr | expr) )* CLOSE_BRACK
      | {self._input.LT(1).type in self.primarySuffixList}? expr
      ;

primary:
        (
                (typeKeyw) simpleExpr 
         |      ( prefixOperator* ( (identOrLiteral primarySuffix*) | primarySuffix+ ) )
        );

parBody:( {self._input.LT(1).type in self.parKeyWList}? simple_complexStmt (SEMI_COLON simple_complexStmt)?
        | 
          expr | (COLON|EQUALS (expr) ) ( ((COMMA exprColonEqExpr)+) | ((SEMI_COLON (simple_complexStmt)+ ) ) )
        );

par: OPEN_PAREN parBody CLOSE_PAREN | parBody;


//NB: no need for ident with pragma
//NB: identvis was symbol optInd operator? 
// operator was a part of it, no need for it


importStmt: IMPORT IDENTIFIER (COMMA IDENTIFIER)*;
fromStmt: FROM IDENTIFIER importStmt;

blockExpr: BLOCK symbol? COLON stmt; 
forExpr: forStmt;

anyExpr: simpleExpr | expr;
condExprBody : 
        (simpleExpr |expr) 
        (ELIF ( expr | simpleExpr) COLON (ind anyExpr ded | anyExpr))*
        (ELSE COLON (ind andExpr ded | anyExpr));
condExpr: (simpleExpr | expr) COLON (ind condExprBody ded | condExprBody);

caseExpr: CASE ( simpleExpr | expr ) 
        ( (ind ofBranches ded) |  ofBranches); 
whenExpr: WHEN condExpr; 
ifExpr: IF NOT? condExpr;

exprList: (simpleExpr | expr) (COMMA (simpleExpr | expr))*;

ofBranch: OF exprList COLON optInd (exprStmt | stmt)+ ded?;
ofBranches: ofBranch+
        ( ELSE COLON optInd ( exprStmt | stmt )+ ded?)?;

caseStmt: CASE ( simpleExpr | expr ) 
        ( (ind ofBranches ded) |  ofBranches); 

ifStmt: IF NOT? condStmt;
whenStmt: WHEN NOT? condStmt;

forStmt: FOR (IDENTIFIER (COMMA IDENTIFIER)*) IN simpleExpr COLON  (ind (stmt | exprStmt)+ ded | (stmt | exprStmt) );

condStmtBody: (exprStmt | substmt)   
          ( ELIF ( simpleExpr | expr ) COLON (ind (exprStmt+ | substmt) ded | (exprStmt+ | substmt)))*
          ( ELSE COLON (ind ( exprStmt+ | substmt ) ded | ( exprStmt+ | substmt )))?;

condStmt:  (simpleExpr | expr) COLON (ind condStmtBody ded | condStmtBody); 

blockStmt: BLOCK symbol? COLON (optInd stmt ded?);

pragmaStmt: pragma ; //TODO

expr: 
        blockExpr
        | forExpr
        | ifExpr
        | whenExpr;

pragma: OPEN_BRACE DOT IDENTIFIER DOT? CLOSE_BRACE;
routine: par (COLON substmt)*; //TODO
typeSection: OPEN_BRACE;//TODO
variableSection: ( variable+ | (ind (variable)+ ded) );
constantSection: (constant+ | (ind constant+ ded) );

identVis: symbol operator?;
varTuple: OPEN_BRACE identVis 
        (COMMA identVis)* 
        optInd CLOSE_BRACE ded? 
        EQUALS ded? 
        optInd (simpleExpr | expr); 

constant: IDENTIFIER (COMMA IDENTIFIER)* (COLON simpleExpr)? EQUALS optInd expr ded?;
// variable: (varTuple | idColonEq) colonBody? optInd;
variable: idColonEq colonBody? optInd; //this colon is for declarations
idColonEq: IDENTIFIER (COMMA IDENTIFIER)* COMMA?
        (COLON optInd simpleExpr ded?)? ( EQUALS optInd (expr| simpleExpr) ded?)? ; //this colon is for type inference

simple_complexStmt: simpleStmt | complexStmt;
simpleStmt: 
        importStmt 
        | fromStmt 
        // | discardStmt 
        // | returnStmt
        // | breakStmt
        | pragmaStmt
        ;

complexStmt: 
        forStmt
        | ifStmt        
        | blockStmt
        // | whileStmt
        | whenStmt
        | (TEMPLATE | PROC | MACRO) routine
        | TYPE typeSection 
        | CONST constantSection
        | (LET | VARIABLE) variableSection;

colonBody: COLON substmt;
exprStmt: simpleExpr ( EQUALS (expr |simpleExpr) colonBody?);


substmt: ind simple_complexStmt (SEMI_COLON? simple_complexStmt)* ded
    | ( simple_complexStmt );

stmt: (simple_complexStmt (SEMI_COLON? simple_complexStmt)*);

module: stmt+; 

start: module;