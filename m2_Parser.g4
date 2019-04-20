parser grammar m2_Parser;
options {language='Python3'; tokenVocab=m2_Lexer;}

@parser::members{
parKeyWList = [DISCARD, IF, WHILE, CASE, FOR, BLOCK, CONST, LET, WHEN, VARIABLE]
literals = [INT_LIT, INT8_LIT, INT16_LIT , INT32_LIT , INT64_LIT, UINT_LIT , UINT8_LIT , UINT16_LIT , UINT32_LIT , UINT64_LIT, 
FLOAT_LIT , FLOAT32_LIT , FLOAT64_LIT, STR_LIT , RSTR_LIT , TRIPLESTR_LIT, CHAR_LIT, NIL ]
primarySuffixList = [SYM_HEADER, IDENTIFIER, literals, TYPE]
}

op0: OP0;
op1: OP1 | EQUALS ;
op2: OP2 | COLON | (COLON COLON);
op3: OP3;
op4: OP4;
op5: OP5 | IN | OF | NOT;
op6: OP6 | DOT | (DOT DOT);
op7: OP7;
op8: OP8;
op9: OP9;
op10: OP10;
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 | op7 | op8 | op9 | op10;

prefixOperator: operator;

ind: INDENT;
optInd: ind?;
optPar: ind?;
ded: DEDENT | EOF;

typeKeyw: VARIABLE | REF | TUPLE | PROC;

parKeyw: DISCARD | IF | WHILE | CASE
        | FOR | BLOCK | CONST | LET
        | WHEN | VARIABLE;

keyw: (typeKeyw | parKeyw)  ; //TODO

generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;

pragmaStmt: pragma (COLON stmt)?;

par: OPEN_PAREN optInd
        ( {self._input.LT(1).type in self.parKeyWList}? (complexStmt | simpleStmt) (SEMI_COLON (complexStmt | simpleStmt))*
          | SEMI_COLON (complexStmt | simpleStmt) (SEMI_COLON (complexStmt | simpleStmt))*
          | pragmaStmt
          | simpleExpr ( (EQUALS expr (SEMI_COLON (complexStmt | simpleStmt) (SEMI_COLON (complexStmt | simpleStmt))* )? )
                        | (COLON expr (COMMA exprColonEqExpr (COMMA exprColonEqExpr)*  )? ) 
                       ) 
        )
        optPar CLOSE_PAREN;

tupleConstr: OPEN_PAREN optInd (exprColonEqExpr COMMA?)* optPar CLOSE_PAREN;
arrayConstr: OPEN_BRACK optInd (exprColonEqExpr COMMA?)* optPar CLOSE_BRACK;

typeDesc: simpleExpr;

identOrLiteral: generalizedLit | symbol | literal
               | par | arrayConstr;

indexExpr: expr;
indexExprList: indexExpr (COMMA indexExpr)*; 
primarySuffix: 
        (exprColonEqExpr COMMA?)+ //TODO : REMOVE
      | OPEN_PAREN (exprColonEqExpr COMMA?)* CLOSE_PAREN
      | DOT optInd symbol generalizedLit?
      | OPEN_BRACK optInd indexExprList optPar CLOSE_BRACK
      | {self._input.LT(1).type in self.primarySuffixList}? expr;

primary: typeKeyw typeDesc
        | prefixOperator* identOrLiteral primarySuffix* ;

//TODO: 
pragma: OPEN_BRACE DOT optInd (exprColonExpr COMMA?)* optPar (DOT? CLOSE_BRACE);

simpleExpr: arrowExpr (OP0 optInd arrowExpr)*; //pragma?; //? //TODO: don't need for test cases
arrowExpr: assignExpr (OP1 optInd assignExpr)*;
assignExpr: orExpr (OP2 optInd orExpr)*;
orExpr: andExpr (OP3 optInd andExpr)*;
andExpr: cmpExpr (OP4 optInd cmpExpr)*;
cmpExpr: sliceExpr (OP5 optInd sliceExpr)*;
sliceExpr: ampExpr (OP6 optInd ampExpr)*;
ampExpr: plusExpr (OP7 optInd plusExpr)*;
plusExpr: mulExpr (OP8 optInd mulExpr)*;
mulExpr: dollarExpr (OP9 optInd dollarExpr)*;
dollarExpr: primary (OP10 optInd primary)*;

exprList: expr (COMMA expr)*;
exprColonExpr: expr (COLON expr)?;
exprColonEqExpr: expr (COLON|EQUALS expr)?;
exprColonEqExprList: exprColonEqExpr (COMMA exprColonEqExpr)* (COMMA)?;

condExpr: expr COLON expr optInd (ELIF expr COLON expr optInd)* (ELSE COLON expr);

literal: INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
          | CHAR_LIT
          | NIL;

symbolBody:( 
                keyw | 
                IDENTIFIER | literal | 
                (operator | OPEN_PAREN | CLOSE_PAREN | OPEN_BRACK |
                CLOSE_BRACK | EQUALS) 
        );  

symbol: ( SYM_HEADER symbolBody+ SYM_HEADER )
        // | symbolBody+
        | keyw
        | IDENTIFIER;

blockExpr: BLOCK symbol? COLON stmt;
ifExpr: IF condExpr;
whenExpr: WHEN condExpr;

dotExpr: expr DOT optInd (symbol | (OPEN_BRACK COLON) exprList CLOSE_BRACK );

forExpr: forStmt;

expr: NOT? (
        blockExpr 
        | forExpr 
        | ifExpr 
        | whenExpr 
        | caseExpr 
        | simpleExpr); 


moduleName: IDENTIFIER;
colonBody: COLON stmt;//removed do blocks, don't have them in test cases

returnStmt: RETURN optInd expr?;
discardStmt: DISCARD optInd expr?;
breakStmt: BREAK optInd expr?;
continueStmt: CONTINUE optInd expr?;
importStmt: IMPORT optInd expr (COMMA expr)* ;
fromStmt: FROM moduleName IMPORT optInd expr (COMMA expr)*;

caseExpr: CASE IDENTIFIER ofBranches;
// caseStmt: CASE IDENTIFIER COLON?
        // (ind ofBranches ded | ofBranches);
caseStmt: CASE expr COLON? ((ind ofBranches ded) | ofBranches);//TODO:

ofBranch: OF exprList COLON stmt;
ofBranches: ofBranch+
        (ELIF expr COLON stmt)*
        (ELSE COLON stmt)?;

exprStmt: simpleExpr (EQUALS optInd expr colonBody?)?;

simpleStmt: (
        returnStmt 
        | discardStmt 
        | breakStmt
        | continueStmt
        | pragmaStmt  
        | importStmt 
        | fromStmt
        | exprStmt
        );

condStmt: expr COLON stmt
           (ELIF expr COLON stmt)*
           (ELSE COLON stmt)?;

identVis: symbol operator?; //TODO: speculation: opr is the postfix operator
identVisDot: symbol (DOT symbol)? operator?;//testcase
identWithPragma: identVis pragma?;

ifStmt: IF condStmt;
whenStmt: WHEN condStmt;
whileStmt: WHILE expr COLON stmt;

genericParam: symbol (COMMA symbol)* (COLON expr)? (EQUALS optInd expr)?;
genericParamList: OPEN_BRACK optInd (genericParam ((COMMA|SEMI_COLON) genericParam)*)?  optPar CLOSE_BRACK;

identWithPragmaDot: identVisDot pragma?;
typeDefAux: simpleExpr | objectType;

//==
objectWhen: WHEN expr COLON objectPart
            (ELIF expr COLON objectPart)*
            (ELSE COLON objectPart)?;

objectBranch: OF exprList COLON objectPart;

objectBranches: objectBranch (objectBranch)*
                (ELIF expr COLON objectPart)*
                (ELSE COLON objectPart)?;

objectCase: CASE identWithPragma COLON typeDesc COLON?
        ( (ind objectBranches ded)
          | objectBranches
        );

objectPart: (ind objectPart+ ded)
           | objectWhen 
           | objectCase 
           | NIL 
           | DISCARD 
           | declColonEquals;

objectType: OBJECT pragma? (OF typeDesc)? objectPart;
//==
typeClassParam: VARIABLE? symbol;
typeClass: (typeClassParam (COMMA typeClassParam)*)? (pragma)? (OF (typeDesc (COMMA typeDesc)*)?)?
              {self._input.LT(1).type == self.INDENT}? stmt;

typeDef: identWithPragmaDot genericParamList? EQUALS optInd typeDefAux optInd;

constant: identWithPragma (COLON typeDesc)? EQUALS optInd expr optInd;
varTuple: OPEN_PAREN optInd identWithPragma (COMMA identWithPragma)* optPar CLOSE_PAREN EQUALS optInd expr;

declColonEquals: identWithPragma (COMMA identWithPragma)* COMMA?
                (COLON optInd typeDesc)? (EQUALS optInd expr)?;

identColonEquals: IDENTIFIER (COMMA IDENTIFIER)* COMMA?
        ( (COLON optInd typeDesc) | (EQUALS optInd expr) );

//TODO: think the parantheses should be optional instead of primsuffix
paramList: OPEN_PAREN (declColonEquals ((COMMA | SEMI_COLON) declColonEquals)*)? CLOSE_PAREN
                | (declColonEquals ((COMMA | SEMI_COLON) declColonEquals)*);

paramListColon: paramList? (COLON optInd typeDesc)?;
//TODO: compare to routine 
procExpr: PROC paramListColon pragma? (EQUALS stmt)? optInd;

variable: (varTuple | identColonEquals) colonBody? optInd;

qualifiedIdent: symbol (DOT optInd symbol)?;

forStmt: FOR (identWithPragma (COMMA identWithPragma)*) IN expr COLON stmt;
blockStmt: BLOCK symbol? COLON stmt;
routine: optInd identVis genericParamList?
        paramListColon pragma? (EQUALS stmt)? optInd;

typeDefSection: typeDef | (ind typeDef+ ded);
constantSection: constant | (ind constant+ ded);
variableSection: variable | (ind variable+ ded);

complexStmt: (
        ifStmt 
        | whenStmt 
        | whileStmt
        | forStmt
        | blockStmt 
        | PROC routine //TODO: procStmt?
        | MACRO routine
        | TEMPLATE routine
        | TYPE typeDefSection
        | CONST constantSection
        | (LET | VARIABLE) variableSection
        );


stmt:
      (complexStmt | simpleStmt) (SEMI_COLON? (complexStmt | simpleStmt))* 
    | (ind (complexStmt | simpleStmt) (SEMI_COLON? (complexStmt | simpleStmt))* ded)
    | (simpleStmt (SEMI_COLON? simpleStmt)* );

module: (stmt (SEMI_COLON stmt)*)?;

start: module;