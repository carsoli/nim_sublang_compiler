parser grammar nim_Parser;
options {language='Python3'; tokenVocab=m2_Lexer;}

@parser::members{
parKeyWList = [DISCARD, INCLUDE, IF, WHILE, CASE, TRY, FINALLY, EXCEPT, FOR, BLOCK, CONST, LET, WHEN, VARIABLE, MIXIN]
literals = [INT_LIT, INT8_LIT, INT16_LIT , INT32_LIT , INT64_LIT, UINT_LIT , UINT8_LIT , UINT16_LIT , UINT32_LIT , UINT64_LIT, 
FLOAT_LIT , FLOAT32_LIT , FLOAT64_LIT, STR_LIT , RSTR_LIT , TRIPLESTR_LIT, CHAR_LIT, NIL ]
primarySuffixList = [SYM_HEADER, IDENTIFIER, literals, CAST, ADDR, TYPE]
def tryExprBody():
    return self._input.LT(1).type in [self.EXCEPT, self.FINALLY] or (self._input.LT(1).type == self.INDENT and self._input.LT(2).type in [self.EXCEPT, self.FINALLY])
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
operator: op0 | op1 | op2 | op3 | op4 | op5 | op6 | op7 | op8 | op9 | op10 | STATIC;

prefixOperator: operator;

ind: INDENT;
optInd: ind?;
optPar: ind?;
ded: DEDENT | EOF;


literal: INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
          | CHAR_LIT
          | NIL;

importStmt: IMPORT (IDENTIFIER | literal);

// stmt: importStmt | procDef | letSection | command ;

// stmtList: (stmt SEMI_COLON?)+; 

// start: stmtList;