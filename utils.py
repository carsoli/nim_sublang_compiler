from antlr4 import Token, InputStream
from m2_lexer import m2_lexer as milestone_2Lexer
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

def tokenize_file(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)

    lexer = milestone_2Lexer(input_stream)
    token = lexer.nextToken()
    res = []
    while not token.type == Token.EOF:
        token_type = get_token_type(token)

        res.append(token_type + "  " + correct_text(token_type, token.text))
        token = lexer.nextToken()
    return res

    

def tokenize_file2(filename):
    prog = read_file(filename)
    input_stream = InputStream(prog)

    lexer = milestone_2Lexer(input_stream)
    token = lexer.nextToken()
    res = []
    allow_indents = True 
    indent_list = []
    while not token.type == Token.EOF:
        token_type = get_token_type(token)
        if token_type == 'NEWLINE':
            allow_indents = True
            indent_list.clear()
            token = lexer.nextToken()
            continue
        elif token_type == 'ERROR_INDENT' or token_type == 'INDENT':
            if allow_indents:
                indent_list.append(token_type + "  " + token.text)
            token = lexer.nextToken()
            continue
        
        allow_indents = False
        res = res + indent_list
        indent_list.clear()

        res.append(token_type + "  " + correct_text(token_type, token.text))
        token = lexer.nextToken()
    return res

def get_token_type(token):
    return milestone_2Lexer.symbolicNames[token.type]

triple_str_regex = r'\"\"\"[\t ]+\n'
def correct_text(token_type, token_text):
    if token_type == 'TRIPLESTR_LIT' or token_type == 'GENERALIZED_TRIPLESTR_LIT':
        return re.sub(triple_str_regex, '"""', token_text)

    return token_text