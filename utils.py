from antlr4 import Token, InputStream, CommonTokenStream, ParseTreeWalker
from antlr4.error.ErrorListener import *
from m2_Lexer import m2_Lexer
from m2_ParserListener import m2_ParserListener
from m2_Parser import m2_Parser 
from antlr4.tree.Trees import Trees
import re

class DefaultErrorListener(ErrorListener):
 
    def __init__(self):
        self._symbol = ''
    
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):        
        self._symbol = offendingSymbol.text
 
    @property        
    def symbol(self):
        return self._symbol

def read_file(filename):
    file = open(filename, 'r')
    text = file.read()
    file.close()
    return text

def write_to_file(path, txt=''): 
    file = open(path, 'w')   
    file.write(txt) 
    file.close()

def recognize_file(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)
    lexer = m2_Lexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = m2_Parser(stream)
    parser.removeErrorListeners()
    errorListener = DefaultErrorListener()
    parser.addErrorListener(errorListener)
    st_ctx = parser.module()
    print(Trees.toStringTree(st_ctx, None, m2_Parser))
    if len(errorListener.symbol) == 0:
        return True
    return False


def tokenize_file(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)
    lexer = m2_Lexer(input_stream)
    token = lexer.nextToken()
    res = []
    while not token.type == Token.EOF:
        token_type = get_token_type(token)

        res.append(token_type + "  " + correct_text(token_type, token.text))
        token = lexer.nextToken()
    return res

def get_token_type(token):
    return m2_Lexer.symbolicNames[token.type]

triple_str_regex = r'\"\"\"[\t ]+\n'
def correct_text(token_type, token_text):
    if token_type == 'TRIPLESTR_LIT' or token_type == 'GENERALIZED_TRIPLESTR_LIT':
        return re.sub(triple_str_regex, '"""', token_text)

    return token_text