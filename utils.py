from antlr4 import Token, InputStream
from milestone_1Lexer import milestone_1Lexer

def read_file(filename):
    file = open(filename, 'r')
    text = file.read()
    file.close()
    return text

def write_to_file(path, txt=''): 
    file = open(path, 'w')   
    file.write(txt) 
    file.close()

def tokenize_file(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)

    lexer = milestone_1Lexer(input_stream)
    token = lexer.nextToken()
    res = []
    while not token.type == Token.EOF:
        res.append(get_token_type(token) + " " + token.text)
        token = lexer.nextToken()
    return res

def get_token_type(token):
    return milestone_1Lexer.symbolicNames[token.type]