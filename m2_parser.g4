parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}

@members {
indent_stk = [0]
indent_mode = False

def consume(self):
    token = super().consume()
    if token.type == self.INDENT:
        #self.indent_mode = True
        self.indent_stk[-1] += 1
        return self.getCurrentToken()

    return token

def IND():
    return self.indent_stk[-2] == self.indent_stk[-1] - 1
def INDE():
    return self.indent_stk[-2] == self.indent_stk[-1]
def DED():
    self.indent_stk = self.indent_stk[:-1]
}

stmt: (CHAR_LIT CHAR_LIT | CHAR_LIT CHAR_LIT CHAR_LIT);

//module: (stmt (SEMI_COLON | DOT stmt)* )? ;

start: stmt;