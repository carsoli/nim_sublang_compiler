parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}
@parser::members{
parKeyWList = [self.DISCARD, self.INCLUDE, self.IF, self.WHILE, self.CASE, self.TRY, self.FINALLY, self.EXCEPT, self.FOR, self.BLOCK, self.CONST, self.LET,self.WHEN, self.VARIABLE, self.MIXIN]
primarySuffixList = [self.SYM_HEADER, self.IDENTIFIER, self.literal, self.CAST, self.ADDR, self.TYPE]
}

op0: OP0;
op1: OP1;
op2: OP2;
op3: OP3;
op4: OP4;
op5: OP5 | IN;
op6: OP6;
op7: OP7;
op8: OP8;
op9: OP9;
op10: OP10;
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 | op7 | op8 | op9 | op10 | STATIC;

ind: INDENT;
ded: DEDENT;

typeKeyw: VARIABLE | OUT | REF | PTR | TUPLE
         | PROC | ITERATOR | DISTINCT | OBJECT | ENUM;

parKeyw: DISCARD | INCLUDE | IF | WHILE | CASE | TRY
        | FINALLY | EXCEPT | FOR | BLOCK | CONST | LET
        | WHEN | VARIABLE | MIXIN;

typeDescK: COLON; //TODO
generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;

pragmaStmt: pragma (COLON stmt)?;

par: OPEN_PAREN
          ( {_input.LT(1).getType() in self.parKeyWList}? (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))*
          | COLON (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))*
          | pragmaStmt
          | simpleExpr ( (EQUALS expr (COLON (complexStmt | simpleStmt) (COLON (complexStmt | simpleStmt))* )? )
                       | (COLON expr (COMMA exprColonEqExpr (COLON exprColonEqExpr)*  )? ) ) );


arrayConstr: OPEN_BRACK (exprColonEqExpr COMMA?)* optPar CLOSE_BRACK;

typeDesc: simpleExpr;

setOrTableConstr: OPEN_BRACE ((exprColonEqExpr COMMA)* | COLON ) CLOSE_BRACE;

castExpr: CAST OPEN_BRACK typeDesc optPar CLOSE_BRACK OPEN_PAREN expr optPar CLOSE_PAREN;

identOrLiteral: generalizedLit | symbol | literal
               | par | arrayConstr | setOrTableConstr
               | castExpr;

doBlocks: COLON;//TODO
indexExprList: COLON; //TODO
primarySuffix: OPEN_PAREN (exprColonEqExpr COMMA?)* CLOSE_PAREN doBlocks?
      | doBlocks
      | DOT symbol generalizedLit?
      | OPEN_BRACK indexExprList optPar CLOSE_BRACK
      | OPEN_BRACE indexExprList optPar CLOSE_BRACE
      | {_input.LT(1).getType() in self.primarySuffixList}? expr;

      
primary: typeKeyw typeDescK
        |  operator* identOrLiteral primarySuffix*
        | BIND primary;

optPar: ind?;
exprColonEqExpr: expr (COLON|EQUALS expr)?;
exprColonExpr: expr (COLON expr)?;

pragma: OPEN_BRACE DOT (exprColonExpr COMMA?)* optPar (DOT CLOSE_BRACE | CLOSE_BRACE);

simpleExpr: arrowExpr (OP0 arrowExpr)* pragma?;
arrowExpr: assignExpr (OP1 assignExpr)*;
assignExpr: orExpr (OP2 orExpr)*;
orExpr: andExpr (OP3 andExpr)*;
andExpr: cmpExpr (OP4 cmpExpr)*;
cmpExpr: sliceExpr (OP5 sliceExpr)*;
sliceExpr: ampExpr (OP6 ampExpr)*;
ampExpr: plusExpr (OP7 plusExpr)*;
plusExpr: mulExpr (OP8 mulExpr)*;
mulExpr: dollarExpr (OP9 dollarExpr)*;
dollarExpr: primary (OP10 primary)*;

exprList: expr (COMMA expr);
condExpr: expr COLON expr
        (ELIF expr COLON expr)*
         ELSE COLON expr;

literal: | INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
          | CHAR_LIT
          | NIL;
          
symbol: SYM_HEADER (
        IDENTIFIER
        | literal
        | (operator 
            | OPEN_PAREN 
            | CLOSE_PAREN
            | OPEN_BRACK
            | CLOSE_BRACK
            | OPEN_BRACE
            | CLOSE_BRACE
            | EQUALS
        )+
        )+ SYM_HEADER | IDENTIFIER;

blockExpr: BLOCK symbol? COLON stmt;
ifExpr: IF condExpr;
whenExpr: WHEN condExpr;

caseExpr: COLON;//TODO
forExpr: forStmt;
tryExpr: TRY COLON stmt {_input.LT(1).getType() in [self.EXCEPT, self.FINALLY]}?
           (EXCEPT exprList COLON stmt)*
           (FINALLY COLON stmt)?;

expr: (blockExpr
      | ifExpr
      | whenExpr
      | caseExpr
      | forExpr
      | tryExpr
      | simpleExpr);

ifStmt: IF expr COLON stmt
        (ELIF expr COLON stmt)*
        (ELSE COLON stmt)?
        ;

moduleName: COLON;//TODO
colonBody: COLON stmt doBlocks?;
macroColon: COLON;//TODO

returnStmt: RETURN expr?;
raiseStmt: RAISE expr?;
yieldStmt: YIELD expr?;
discardStmt: DISCARD expr?;
breakStmt: BREAK expr?;
continueStmt: CONTINUE expr?;
importStmt: IMPORT expr ((COMMA expr)* | EXCEPT (expr (COMMA expr)*));
exportStmt: COLON;//TODO
fromStmt: FROM moduleName IMPORT expr (COMMA expr)*;
includeStmt: INCLUDE expr (expr COMMA)*;
exprStmt: simpleExpr
         (  ( EQUALS expr colonBody? )
            | ( expr (COMMA expr)* doBlocks | macroColon)
         )?;

simpleStmt: (
        returnStmt 
        | raiseStmt 
        | yieldStmt 
        | discardStmt 
        | breakStmt
        | continueStmt  
        | importStmt 
        | exportStmt 
        | fromStmt
        | includeStmt
        | exprStmt
        );

condStmt: expr COLON stmt
           (ELIF expr COLON stmt)*
           (ELSE COLON stmt)?;

opr:COLON;//TODO
identVis: symbol opr?;
identVisDot: symbol DOT symbol opr?;
identWithPragma: identVis pragma?;

whenStmt: WHEN condStmt;
whileStmt: WHILE expr COLON stmt;
tryStmt: TRY COLON stmt {_input.LT(1).getType() in [self.EXCEPT, self.FINALLY]}?
           (EXCEPT exprList COLON stmt)*
           (FINALLY COLON stmt)?;

pattern: OPEN_BRACE stmt CLOSE_BRACE;


genericParam: symbol (COMMA symbol)* (COLON expr)? (EQUALS expr)?;
genericParamList: OPEN_BRACK (genericParam ((COMMA|SEMI_COLON) genericParam)*)?  optPar CLOSE_BRACK;

identWithPragmaDot: identVisDot pragma?;
typeDefAux: simpleExpr | CONCEPT;

typeClassParam: (VARIABLE | OUT)? symbol;
typeClass: (typeClassParam (COMMA typeClassParam)*)? (pragma)? (OF (typeDesc (COMMA typeDesc)*)?)?
              {_input.LT(1).getType() == self.IND}? stmt;

typeDef: identWithPragmaDot genericParamList? EQUALS typeDefAux ind?;

constant: identWithPragma (COLON typeDesc)? EQUALS expr ind?;
varTuple: OPEN_PAREN identWithPragma (COMMA identWithPragma)* optPar CLOSE_PAREN EQUALS expr;
identColonEquals: IDENTIFIER (COMMA IDENTIFIER)* COMMA?;
variable: (varTuple | identColonEquals) colonBody? ind?;

qualifiedIdent: symbol (DOT symbol)?;

forStmt: FOR (identWithPragma (COMMA identWithPragma)*) IN expr COLON stmt;
blockStmt: BLOCK symbol? COLON stmt;
staticStmt: STATIC COLON stmt;
deferStmt: DEFER COLON stmt;
asmStmt: ASM pragma? (STR_LIT | RSTR_LIT | TRIPLESTR_LIT);
routine: identVis pattern? genericParamList?;
sectionTypeDef: typeDef | (ind (typeDef | COMMENT)+ ded);
sectionConstant: constant | (ind (constant | COMMENT)+ ded);
sectionVariable: variable | (ind (variable | COMMENT)+ ded);
bindStmt: BIND qualifiedIdent (COMMA qualifiedIdent)*;
mixinStmt: MIXIN qualifiedIdent (COMMA qualifiedIdent)*;

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


stmt: (ind (complexStmt | simpleStmt) (SEMI_COLON (complexStmt | simpleStmt))* ded)
    | (simpleStmt (SEMI_COLON simpleStmt)*);

module: (stmt (SEMI_COLON stmt)*)?;

start: module;