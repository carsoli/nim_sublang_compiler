parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}
@parser::members{
parKeyWList = [DISCARD, INCLUDE, IF, WHILE, CASE, TRY, FINALLY, EXCEPT, FOR, BLOCK, CONST, LET, WHEN, VARIABLE, MIXIN]
literals = [INT_LIT, INT8_LIT, INT16_LIT , INT32_LIT , INT64_LIT, UINT_LIT , UINT8_LIT , UINT16_LIT , UINT32_LIT , UINT64_LIT, 
FLOAT_LIT , FLOAT32_LIT , FLOAT64_LIT, STR_LIT , RSTR_LIT , TRIPLESTR_LIT, CHAR_LIT, NIL ]
primarySuffixList = [SYM_HEADER, IDENTIFIER, literals, CAST, ADDR, TYPE]
def tryExprBody(self):
    return self._input.LT(1).getType() in [self.EXCEPT, self.FINALLY] or (self._input.LT(1).getType() == self.INDENT and self._input.LT(2).getType() in [self.EXCEPT, self.FINALLY])
}

op0: OP0;
op1: OP1 | EQUALS ;
op2: OP2 | COLON | (COLON COLON);
op3: OP3;
op4: OP4;
op5: OP5 | IN | OF | NOT;
op6: OP6 | DOT;
op7: OP7;
op8: OP8;
op9: OP9;
op10: OP10;
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 | op7 | op8 | op9 | op10 | STATIC;

prefixOperator: operator;

ind: INDENT;
optInd: ind?;
optPar: ind?;
ded: DEDENT;


typeKeyw: VARIABLE | OUT | REF | PTR | TUPLE
         | PROC | ITERATOR | DISTINCT | OBJECT | ENUM;

parKeyw: DISCARD | INCLUDE | IF | WHILE | CASE | TRY
        | FINALLY | EXCEPT | FOR | BLOCK | CONST | LET
        | WHEN | VARIABLE | MIXIN;

// keyw: typeKeyw | parKeyw; //TODO

generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;

pragmaStmt: pragma (COLON stmt)?;

par: OPEN_PAREN optInd
          ( {_input.LT(1).getType() in self.parKeyWList}? (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))*
          | COLON (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))*
          | pragmaStmt
          | simpleExpr ( (EQUALS expr (COLON (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))* )? )
                       | (COLON expr (COMMA exprColonEqExpr (COLON exprColonEqExpr)*  )? ) ) );

tupleConstr: OPEN_PAREN optInd (exprColonEqExpr COMMA?)* optPar CLOSE_PAREN;
arrayConstr: OPEN_BRACK optInd (exprColonEqExpr COMMA?)* optPar CLOSE_BRACK;

typeDesc: simpleExpr;

setOrTableConstr: OPEN_BRACE ((exprColonEqExpr COMMA)* | COLON ) CLOSE_BRACE;

castExpr: CAST OPEN_BRACK optInd typeDesc optPar CLOSE_BRACK OPEN_PAREN optInd expr optPar CLOSE_PAREN;

identOrLiteral: generalizedLit | symbol | literal
               | par | arrayConstr | setOrTableConstr
               | castExpr;

indexExpr: expr;
indexExprList: indexExpr (COMMA indexExpr)*; 
primarySuffix: OPEN_PAREN (exprColonEqExpr COMMA?)* CLOSE_PAREN
      | DOT optInd symbol generalizedLit?
      | OPEN_BRACK optInd indexExprList optPar CLOSE_BRACK
      | OPEN_BRACE optInd indexExprList optPar CLOSE_BRACE
      | {_input.LT(1).getType() in self.primarySuffixList}? expr;

primary: typeKeyw typeDesc
        | prefixOperator* identOrLiteral primarySuffix*
        | BIND primary;

exprColonEqExpr: expr (COLON|EQUALS expr)?;
exprColonExpr: expr (COLON expr)?;

pragma: OPEN_BRACE DOT optInd (exprColonExpr COMMA?)* optPar (DOT CLOSE_BRACE | CLOSE_BRACE);

simpleExpr: arrowExpr (OP0 optInd arrowExpr)* pragma?;
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
condExpr: expr optInd COLON expr optInd 
        (ELIF optInd expr optInd COLON expr optInd)*
         ELSE optInd COLON expr ;

literal: INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
          | CHAR_LIT
          | NIL;

symbolBody:( 
                // keyw | 
                IDENTIFIER | literal | 
                operator | OPEN_PAREN | CLOSE_PAREN | OPEN_BRACK |
                CLOSE_BRACK | OPEN_BRACE | CLOSE_BRACE | EQUALS
        );  

symbol: ( SYM_HEADER symbolBody+ SYM_HEADER ) 
        // | keyw
        | IDENTIFIER;

blockExpr: BLOCK symbol? COLON stmt;
ifExpr: IF condExpr;
whenExpr: WHEN condExpr;

dotExpr: expr DOT optInd (symbol | (OPEN_BRACK COLON) exprList CLOSE_BRACK );

forExpr: forStmt;
tryExpr: TRY COLON stmt { tryExprBody()}?
           (optInd EXCEPT exprList COLON stmt)*
           (optInd FINALLY COLON stmt)?;

expr: NOT? 
     (
        blockExpr
      | ifExpr
      | whenExpr
      | caseExpr
      | forExpr
      | tryExpr
      | simpleExpr
      );

ifStmt: IF expr COLON stmt
        (ELIF expr COLON stmt)*
        (ELSE COLON stmt)?
        ;

moduleName: IDENTIFIER;
colonBody: COLON stmt;

returnStmt: RETURN optInd expr?;
raiseStmt: RAISE optInd expr?;
yieldStmt: YIELD optInd expr?;
discardStmt: DISCARD optInd expr?;
breakStmt: BREAK optInd expr?;
continueStmt: CONTINUE optInd expr?;
importStmt: IMPORT optInd expr ((COMMA expr)* | EXCEPT optInd (expr (COMMA expr)*));
fromStmt: FROM moduleName IMPORT optInd expr (COMMA expr)*;

caseExpr: CASE IDENTIFIER ofBranches;
caseStmt: CASE IDENTIFIER COLON?
        (ind ofBranches ded | ofBranches);

ofBranch: OF exprList COLON stmt;
ofBranches: ofBranch+
        (ELIF expr COLON stmt)*
        (ELSE COLON stmt)?;

includeStmt: INCLUDE optInd expr (expr COMMA)*;

exprStmt: simpleExpr
         (  ( EQUALS optInd expr colonBody? )
         )?;

simpleStmt: (
        returnStmt 
        | raiseStmt 
        | yieldStmt 
        | discardStmt 
        | breakStmt
        | continueStmt  
        | importStmt 
        | fromStmt
        | includeStmt
        | exprStmt
        );

condStmt: expr COLON stmt
           (ELIF expr COLON stmt)*
           (ELSE COLON stmt)?;

identVis: symbol operator?; //
identVisDot: symbol DOT optInd symbol operator?;
identWithPragma: identVis pragma?;

whenStmt: WHEN condStmt;
whileStmt: WHILE expr COLON stmt;
tryStmt: TRY COLON stmt {_input.LT(1).getType() in [self.EXCEPT, self.FINALLY]}?
           (EXCEPT exprList COLON stmt)*
           (FINALLY COLON stmt)?;

pattern: OPEN_BRACE stmt CLOSE_BRACE;


genericParam: symbol (COMMA symbol)* (COLON expr)? (EQUALS optInd expr)?;
genericParamList: OPEN_BRACK optInd (genericParam ((COMMA|SEMI_COLON) genericParam)*)?  optPar CLOSE_BRACK;

identWithPragmaDot: identVisDot pragma?;
typeDefAux: simpleExpr | CONCEPT;

typeClassParam: (VARIABLE | OUT)? symbol;
typeClass: (typeClassParam (COMMA typeClassParam)*)? (pragma)? (OF (typeDesc (COMMA typeDesc)*)?)?
              {_input.LT(1).getType() == self.IND}? stmt;

typeDef: identWithPragmaDot genericParamList? EQUALS optInd typeDefAux ind?;

constant: identWithPragma (COLON typeDesc)? EQUALS optInd expr ind?;
varTuple: OPEN_PAREN optInd identWithPragma (COMMA identWithPragma)* optPar CLOSE_PAREN EQUALS optInd expr;

declColonEquals: identWithPragma (COMMA identWithPragma)* COMMA?
                (COLON optInd typeDesc)? (EQUALS optInd expr)?;

identColonEquals: IDENTIFIER (COMMA IDENTIFIER)* COMMA?
                (COLON optInd typeDesc)? (EQUALS optInd expr)?;


paramList: OPEN_PAREN (declColonEquals ((COMMA | SEMI_COLON) declColonEquals)*)? CLOSE_PAREN;

paramListColon: paramList? (COLON optInd typeDesc)?;

variable: (varTuple | identColonEquals) colonBody? ind?;

qualifiedIdent: symbol (DOT optInd symbol)?;

forStmt: FOR (identWithPragma (COMMA identWithPragma)*) IN expr COLON stmt;
blockStmt: BLOCK symbol? COLON stmt;
staticStmt: STATIC COLON stmt;
deferStmt: DEFER COLON stmt;
asmStmt: ASM pragma? (STR_LIT | RSTR_LIT | TRIPLESTR_LIT);
routine: optInd identVis pattern? genericParamList?
        paramListColon pragma? (EQUALS stmt)? optInd;

sectionTypeDef: typeDef | (ind typeDef+ ded);
sectionConstant: constant | (ind constant+ ded);
sectionVariable: variable | (ind variable+ ded);
bindStmt: BIND optInd qualifiedIdent (COMMA qualifiedIdent)*;
mixinStmt: MIXIN optInd qualifiedIdent (COMMA qualifiedIdent)*;

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
        | (LET | VARIABLE | USING) sectionVariable
        | bindStmt 
        | mixinStmt
        );


stmt: (ind (complexStmt | simpleStmt) (SEMI_COLON (complexStmt | simpleStmt))* ded)
    | (simpleStmt (SEMI_COLON simpleStmt)*);

module: (stmt (SEMI_COLON stmt)*)?;

start: module;