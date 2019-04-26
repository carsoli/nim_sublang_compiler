parser grammar nim_Parser;
options {language='Python3'; tokenVocab=m2_Lexer;}

@parser::members{
# parKeyWList = [IF, WHILE, CASE, FOR, BLOCK, CONST, LET, WHEN, VARIABLE]
literals = [INT_LIT, INT8_LIT, INT16_LIT , INT32_LIT , INT64_LIT, UINT_LIT , UINT8_LIT , 
UINT16_LIT , UINT32_LIT , UINT64_LIT, FLOAT_LIT , FLOAT32_LIT , FLOAT64_LIT, STR_LIT, 
RSTR_LIT , TRIPLESTR_LIT, CHAR_LIT, NIL ]
primarySuffixList = [SYM_HEADER, IDENTIFIER, TYPE] + literals
}

ind: INDENT;
ded: DEDENT | EOF;

typeKeyw: REF | OBJECT ; //|PROC | VARIABLE | 

op0: OP0;
op1: OP1 | EQUALS;
op2: ( OP2 | COLON | (COLON COLON) );
op3: OP3;
op4: OP4;
op5: ( OP5 | IN | OF | NOT );
op6: ( OP6 | DOT | (DOT DOT));
op7: OP7;
op8: OP8;
op9: OP9;
op10: (OP10 | DOLLAR_SIGN);
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 
        | op7 | op8 | op9 | op10;
prefixOperator: operator;

simpleExpr: assignExpr (op1 assignExpr)*;
assignExpr: orExpr (op2 orExpr)*;
orExpr : andExpr (op3 andExpr)*;
andExpr : cmpExpr (op4 cmpExpr)*;
cmpExpr : sliceExpr (op5 sliceExpr)*;
sliceExpr : ampExpr (op6 ampExpr)*;
ampExpr : plusExpr (op7 plusExpr)*;
plusExpr : mulExpr (op8 mulExpr)*;
mulExpr : dollarExpr (op9 dollarExpr)*;
dollarExpr : primary (op10 primary)*;

literal: INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
        | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
        | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
        | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
        | CHAR_LIT
        | NIL;

generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;
symbol: (symbolBody | (SYM_HEADER symbolBody SYM_HEADER));
        // | keyw

// symbolWHeader: SYM_HEADER symbolBody SYM_HEADER | symbolBody;
symbolBody:( 
                // keyw | 
                IDENTIFIER | literal | 
                (operator | OPEN_PAREN | CLOSE_PAREN | OPEN_BRACK |
                CLOSE_BRACK | EQUALS )+ 
        );  


exprColonEqExpr: anyExpr ( (COLON | EQUALS) anyExpr )?;
arrayConstr: OPEN_BRACK exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_BRACK;
tupleConstr: OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN;


identOrLiteral: generalizedLit | symbol | arrayConstr;//| par 

addressLiteral: DOLLAR_SIGN identOrLiteral;

primarySuffix:  
         OPEN_PAREN exprColonEqExpr (COMMA exprColonEqExpr)* CLOSE_PAREN
        | DOT symbol generalizedLit?
        | OPEN_BRACK exprList CLOSE_BRACK
        // | {self._input.LT(1).type in self.primarySuffixList}? expr
        // | expr
      ;

primary:
(
        ( typeKeyw ( simpleExpr | (ind expr ded) ) ) 
        | ( prefixOperator* ( (identOrLiteral primarySuffix*) | primarySuffix+ ) )
);


importStmt: IMPORT IDENTIFIER (COMMA IDENTIFIER)*;
fromStmt: FROM IDENTIFIER importStmt;

blockExpr: BLOCK IDENTIFIER COLON ( (ind (simpleExpr)+ ded) | simpleExpr) ; 
forExpr: forStmt;

anyExpr: simpleExpr | expr;
anyStmt: stmt | exprStmt;
anyStmtOrFuncCall: (anyStmt | primary);


condExprElif: (ELIF simpleExpr COLON ( (ind anyExpr+ ded) | anyExpr));
condExprElse: (ELSE COLON (ind anyExpr+ ded | anyExpr));

condExprBody : ((ind anyExpr+ ded) | anyExpr) condExprElif* condExprElse?;
        
condExpr: simpleExpr COLON condExprBody;

caseExpr: CASE simpleExpr (COLON simpleExpr)? 
        ( (ind ofBranchesExpr ded) |  ofBranchesExpr); 

ofBranchExpr: OF exprList COLON simpleExpr;

ofBranchesExpr: ofBranchExpr+;

whenExpr: WHEN condExpr; 

ifExpr: IF NOT? condExpr;

exprList: simpleExpr (COMMA simpleExpr)*;

caseStmt: CASE simpleExpr ofBranchesStmt; 

ofBranchesStmt: ofBranchStmt+
        ( ELSE COLON ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall ))?;
         
ofBranchStmt: OF exprList COLON ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall);


whileStmt: WHILE anyExpr COLON 
        ((ind ( exprStmt+ | stmt ) ded) | ( exprStmt+ | stmt ));

whenStmt: WHEN condStmt;

idList: (IDENTIFIER (COMMA IDENTIFIER)*);
forStmt: FOR idList IN simpleExpr COLON ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall );

ifStmt: IF NOT? condStmt;

condStmtElif:  ELIF simpleExpr COLON ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall );

condStmtElse:  ELSE COLON ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall );

condStmtBody: ( (ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall )
        (
                (ind condStmtElif* condStmtElse? ded) 
                | (condStmtElif* (ind condStmtElse? ded)) 
                | (condStmtElif* condStmtElse?)
        );

condStmt: simpleExpr COLON condStmtBody; 

blockStmt: BLOCK IDENTIFIER COLON ((ind anyStmtOrFuncCall+ ded) | anyStmtOrFuncCall);
discardStmt: DISCARD; //Empty discard Statement
returnStmt: (RETURN simpleExpr) | RETURN; 
breakStmt: (BREAK simpleExpr) | BREAK;
continueStmt: CONTINUE; 

expr: 
        blockExpr
        | caseExpr
        | forExpr
        | ifExpr
        | whenExpr
        ;

pragma: OPEN_BRACE DOT IDENTIFIER DOT? CLOSE_BRACE;

procRoutineHeader: symbol arrayConstr?;
procRoutineVariableType: IDENTIFIER arrayConstr; 
procRoutineType: (IDENTIFIER arrayConstr?) 
        | (PROC procRoutineBodyList) 
        | (VARIABLE procRoutineVariableType) ;
procRoutineBody: IDENTIFIER ( (COLON procRoutineType) | (EQUALS simpleExpr) );
procRoutineTail: (COLON procRoutineType)? EQUALS ( (anyStmt | anyExpr) | (ind (anyStmt | anyExpr)+ ded) ); 
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


typeSectionBodyExpr: simpleExpr; 
typeSectionBodyHeader: IDENTIFIER arrayConstr? EQUALS ;
typeSectionBody: typeSectionBodyHeader typeSectionBodyExpr;
typeSectionBodyList: (ind typeSectionBody+ ded);
typeSection: typeSectionBodyList;

variableSection: ( variable+ | (ind variable+ ded) ); //TODO

constantSection: ( constant+ | (ind constant+ ded) );//TODO

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

module: stmt (SEMI_COLON? stmt)* EOF; 

start: module;