parser grammar m2_parser;
options {language='Python3'; tokenVocab=m2_lexer;}

@members {
levels = []
indent_level = 0

def getToken():
    super().getToken()
    return Token.EOF if tokens.isEmpty() else tokens.poll()

def jump(self, ttype):
    print("ai haga")
}


stmt: {self.jump('beda')} CHAR_LIT;

module: (stmt (SEMI_COLON | DOT stmt)* )? ;

start: stmt;