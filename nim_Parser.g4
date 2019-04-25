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
op10: OP10 | DOLLAR_SIGN;
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
        | SYM_HEADER symbolBody SYM_HEADER;
        // | keyw

// symbolWHeader: SYM_HEADER symbolBody SYM_HEADER | symbolBody;
symbolBody:( 
                // keyw | 
                IDENTIFIER | literal | 
                (operator | OPEN_PAREN | CLOSE_PAREN | OPEN_BRACK |
                CLOSE_BRACK | EQUALS )* 
        );  


exprColonEqExpr: anyExpr ( (COLON | EQUALS) anyExpr )?;
arrayConstr: OPEN_BRACK exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_BRACK;
tupleConstr: OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN;


identOrLiteral: generalizedLit | symbol | arrayConstr;//| par 

addressLiteral: DOLLAR_SIGN identOrLiteral;

primarySuffixSimpleBody: 
        ( 
        (IDENTIFIER (arrayConstr | tupleConstr)?) 
        | literal 
        | generalizedLit  
        | addressLiteral 
        );

primarySuffix:
        // primarySuffixSimpleBody (COMMA primarySuffixSimpleBody)*
         OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN
        | DOT symbol generalizedLit?
        | OPEN_BRACK exprList CLOSE_BRACK
        | {self._input.LT(1).type in self.primarySuffixList}? expr
      ;

primary:
(
        ( typeKeyw simpleExpr ) 
        | ( prefixOperator* ( (identOrLiteral primarySuffix*) | primarySuffix+ ) )
);

parBody:( {self._input.LT(1).type in self.parKeyWList}? simple_complexStmt (SEMI_COLON simple_complexStmt)?
        | 
          expr | ((COLON | EQUALS) expr ) ( ((COMMA exprColonEqExpr)+) | ((SEMI_COLON (simple_complexStmt)+ ) ) )
        );

//TODO:
par: OPEN_PAREN parBody CLOSE_PAREN;// | parBody;

importStmt: IMPORT IDENTIFIER (COMMA IDENTIFIER)*;
fromStmt: FROM IDENTIFIER importStmt;

blockExpr: BLOCK symbol COLON ( stmt | (ind stmt ded)); 
forExpr: forStmt;

anyExpr: simpleExpr | expr;
anyStmt: stmt | exprStmt;

condExprBody : 
        (anyExpr) 
        (ELIF ( anyExpr) COLON (ind anyExpr ded | anyExpr))*
        (ELSE COLON (ind anyExpr ded | anyExpr));
condExpr: anyExpr COLON (ind condExprBody ded | condExprBody);

caseExpr: CASE anyExpr  
        ( (ind ofBranches ded) |  ofBranches); 

whenExpr: WHEN condExpr; 

ifExpr: IF NOT? condExpr;

exprList: anyExpr (COMMA anyExpr)*;

ofBranch: OF exprList COLON (ind anyStmt+ ded | anyStmt);

ofBranches: ofBranch+
        ( ELSE COLON ( (ind anyStmt+ ded) | anyStmt ))?;

caseStmt: CASE anyExpr 
        ( (ind ofBranches ded) |  ofBranches); 

whileStmt: WHILE anyExpr COLON 
        ((ind ( exprStmt+ | stmt ) ded) | ( exprStmt+ | stmt ));

whenStmt: WHEN condStmt;

idList: (IDENTIFIER (COMMA IDENTIFIER)*);
forStmt: FOR idList IN simpleExpr COLON  ( (ind (stmt)+ ded) | anyStmt );

ifStmt: IF NOT? condStmt;

condStmtElif:  ELIF (anyExpr) COLON ((ind (exprStmt+ | stmt) ded) | (exprStmt+ | stmt));
condStmtElse:  ELSE COLON ((ind ( exprStmt+ | stmt ) ded) | ( exprStmt+ | stmt ));

condStmtBody: ( (ind stmt ded) | stmt )
           ((ind condStmtElif* condStmtElse? ded) | (condStmtElif* ind condStmtElse? ded) | (condStmtElif* condStmtElse?));

condStmt:  anyExpr COLON condStmtBody; 

blockStmt: BLOCK symbol COLON ((ind stmt ded) | stmt);
discardStmt: DISCARD; //Empty discard Statement
returnStmt: (RETURN simpleExpr) | RETURN; 
breakStmt: (BREAK simpleExpr) | BREAK;
continueStmt: CONTINUE; 

expr: 
        blockExpr
        | forExpr
        | ifExpr
        | whenExpr;

pragma: OPEN_BRACE DOT IDENTIFIER DOT? CLOSE_BRACE;

procRoutineHeader: symbol arrayConstr?;
procRoutineVariableType: IDENTIFIER arrayConstr; 
procRoutineType: (IDENTIFIER arrayConstr?) 
        | (PROC procRoutineBodyList) 
        | (VARIABLE procRoutineVariableType) ;
procRoutineBody: IDENTIFIER ( (COLON procRoutineType) | (EQUALS simpleExpr) );
procRoutineTail: (COLON procRoutineType)? EQUALS ( anyStmt | (ind anyStmt+ ded) ); 
procRoutineBodyList: OPEN_PAREN procRoutineBody (COMMA procRoutineBody)* CLOSE_PAREN; 
procRoutine: procRoutineHeader procRoutineBodyList procRoutineTail; 

templateRoutineHeader: IDENTIFIER;
templateRoutineBodyList: OPEN_PAREN templateRoutineBody (COMMA templateRoutineBody)* CLOSE_PAREN;
templateRoutineBody: IDENTIFIER;
templateRoutineTail: pragma? EQUALS ( anyStmt | (ind anyStmt+ ded) ); 
templateRoutine: templateRoutineHeader templateRoutineBodyList templateRoutineTail; 

macroRoutineHeader: IDENTIFIER;
macroRoutineType: IDENTIFIER;
macroRoutineBody:IDENTIFIER (COLON macroRoutineType);
macroRoutineBodyList: OPEN_PAREN macroRoutineBody (( COLON | SEMI_COLON ) macroRoutineBody)* CLOSE_PAREN;
macroRoutineTail: (COLON macroRoutineType)? EQUALS ( anyStmt | (ind anyStmt+ ded) ); 
macroRoutine: macroRoutineHeader macroRoutineBodyList macroRoutineTail;

typeSection: OPEN_BRACE;//TODO
variableSection: ( variable+ | (ind variable+ ded) );
constantSection: ( constant+ | (ind constant+ ded) );
letSection: (IDENTIFIER EQUALS simpleExpr) | (ind (IDENTIFIER EQUALS simpleExpr)+ ded); 

identVis: symbol operator?;
varTuple: 
        (OPEN_BRACE identVis (COMMA identVis)* (ind CLOSE_BRACE ded | CLOSE_BRACE) )
        EQUALS ded? ( (ind andExpr ded) | anyExpr); 

constant: IDENTIFIER (COMMA IDENTIFIER)* (COLON simpleExpr)? EQUALS (ind anyExpr ded | anyExpr);
// variable: idColonEq;
variable: idColonEq colonBody?; //this colon is for declarations
idColonEq: IDENTIFIER (COMMA IDENTIFIER)* COMMA?
        //this colon is for type inference
        (COLON (ind simpleExpr ded | simpleExpr))? ( EQUALS ( ind anyExpr ded | anyExpr))? ; 

simple_complexStmt: simpleStmt | complexStmt;
simpleStmt: 
        importStmt 
        | fromStmt 
        | discardStmt 
        | returnStmt
        | breakStmt
        | continueStmt
        ;

complexStmt: 
        forStmt
        | ifStmt
        | caseStmt        
        | blockStmt
        | whileStmt
        | whenStmt
        | TEMPLATE templateRoutine
        | PROC procRoutine
        | MACRO macroRoutine
        | TYPE typeSection 
        | CONST constantSection
        | VARIABLE variableSection
        | LET letSection;

colonBody: COLON stmt;
exprStmt: (simpleExpr EQUALS anyExpr);// | (IDENTIFIER primarySuffix); //CHECK WHEN TESTING

stmt: simple_complexStmt;

module: stmt (SEMI_COLON? stmt)*; 

start: module;