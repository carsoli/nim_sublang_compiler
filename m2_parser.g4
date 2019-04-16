parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}

@members {
indent_stk = [0]
indent_mode = False

def getCurrentToken(self):
    token = super().getCurrentToken()
    if token.type == self.INDENT:
        self.indent_mode = True
        self.indent_stk[-1] += 1
        
    elif: token.type == self.NEWLINE:

    elif: self.indent_mode:
        self.indent_mode.push(0)
        self.indent_mode = False

    print(self.INDENT == token.type)
    return token 

def IND():
    return self.indent_stk[-2] == self.indent_stk[-1] - 1
def INDE():
    return self.indent_stk[-2] == self.indent_stk[-1]
def DED():
    self.indent_stk = self.indent_stk[:-1]
}



stmt: {self.jump('beda')} CHAR_LIT;

module: (stmt (SEMI_COLON | DOT stmt)* )? ;

start: stmt;