from antlr4 import Token, InputStream, CommonTokenStream, ParseTreeWalker
from m2_lexer import m2_lexer
from m2_parserListener import m2_parserListener
from m2_parser import m2_parser 
import re

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
    lexer = m2_lexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = m2_parser(stream)
    st_ctx = parser.start()

    return True


def tokenize_file(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)
    lexer = m2_lexer(input_stream)
    token = lexer.nextToken()
    res = []
    while not token.type == Token.EOF:
        token_type = get_token_type(token)

        res.append(token_type + "  " + correct_text(token_type, token.text))
        token = lexer.nextToken()
    return res

def get_token_type(token):
    return m2_lexer.symbolicNames[token.type]

triple_str_regex = r'\"\"\"[\t ]+\n'
def correct_text(token_type, token_text):
    if token_type == 'TRIPLESTR_LIT' or token_type == 'GENERALIZED_TRIPLESTR_LIT':
        return re.sub(triple_str_regex, '"""', token_text)

    return token_text