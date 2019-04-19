from antlr4 import Token, InputStream, CommonTokenStream, ParseTreeWalker
from antlr4.error.ErrorListener import ErrorListener
from antlr4.error.ErrorStrategy import DefaultErrorStrategy, ErrorStrategy, BailErrorStrategy
from antlr4.tree.Tree import ParseTreeVisitor
from m2_Lexer import m2_Lexer
from m2_ParserListener import m2_ParserListener
from m2_Parser import m2_Parser 
from antlr4.tree.Trees import Trees
import re
from pprint import pprint

class PVisitor(ParseTreeVisitor):
    def __init__(self):
        super().__init__()
        self.terminalCount = 0
    def visitTerminal(self, node):
        if str(node) != '<EOF>':
            self.terminalCount += 1

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
    terminalCnt = len(tokenize_file(filename))
    prog = read_file(filename)
    input_stream = InputStream(prog)
    lexer = m2_Lexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = m2_Parser(stream)
    errHandler = BailErrorStrategy()
    visitor = ParseTreeVisitor
    parser._errHandler = errHandler
    try:
        st_ctx = parser.start()
        visitor = PVisitor()
        visitor.visit(st_ctx)
        pprint(Trees.toStringTree(st_ctx, None, m2_Parser), indent=1, width=1)
        print(visitor.terminalCount)
        print(terminalCnt)
        if abs(visitor.terminalCount - terminalCnt) != 0:
            return False
    except Exception as e:
        print(e)
        return False
    return True

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