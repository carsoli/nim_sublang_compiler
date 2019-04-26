from antlr4 import Token, InputStream, CommonTokenStream, ParseTreeWalker
from antlr4.error.ErrorListener import ErrorListener
from antlr4.error.ErrorStrategy import DefaultErrorStrategy, ErrorStrategy, BailErrorStrategy
from antlr4.tree.Tree import ParseTreeVisitor
from antlr4.Utils import escapeWhitespace
from m2_Lexer import m2_Lexer
from nim_ParserListener import nim_ParserListener
from nim_Parser import nim_Parser
from antlr4.tree.Trees import Trees
import re
from pprint import pprint
from tkinter import *  
from tkinter import ttk  

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
    parser = nim_Parser(stream)
    errHandler = BailErrorStrategy()
    visitor = ParseTreeVisitor
    # parser._errHandler = errHandler
    # try:
    st_ctx = parser.module()
    print(st_ctx.EMPTY)
    visitor = PVisitor()
    visitor.visit(st_ctx)
    # pprint(Trees.toStringTree(st_ctx, None, m2_Parser), indent=1, width=1)
    print(visitor.terminalCount)
    print(terminalCnt)
    visualize_tree(st_ctx, parser)
    if abs(visitor.terminalCount - terminalCnt) != 0:
        return False
    # except Exception as e:
        # print(e)
        # return False
    return True

def dfs_tree(treeview, parent_idx, idx_in_parent, node, ruleNames):
    current_rule_text = escapeWhitespace(Trees.getNodeText(node, ruleNames), False)
    print(current_rule_text)
    current_idx = treeview.insert(parent_idx, idx_in_parent, text=current_rule_text)  
    for i in range(0, node.getChildCount()):
        dfs_tree(treeview, current_idx, i, node.getChild(i), ruleNames)

def dfs_tree_w_cs(treeview, parent_idx, idx_in_parent, node, ruleNames):
    current_rule_text = escapeWhitespace(Trees.getNodeText(node, ruleNames), False)
    current_idx = treeview.insert(parent_idx, idx_in_parent, text=current_rule_text)
    subTreeText = (current_rule_text + " " if node.getChildCount() == 0 else "")
    for i in range(0, node.getChildCount()):
        subTreeText += dfs_tree_w_cs(treeview, current_idx, i+1, node.getChild(i), ruleNames)
    
    if node.getChildCount() > 0:
        treeview.insert(current_idx, 0, text=subTreeText)
    
    return subTreeText

def visualize_tree(tree, parser, allow_cs=True):
    ruleNames = parser.ruleNames
    tree_gui = Tk()
    tree_gui.geometry("1680x1200+200+200") 
    tree_gui.title("AST")
    ttk.Label(tree_gui, text="Tree View").pack()  
    treeview=ttk.Treeview(tree_gui, height=37, show="tree")
    treeview.pack(fill="both", expand=True)
    if allow_cs:
        dfs_tree_w_cs(treeview, '', 'end', tree, ruleNames)
    else:
        dfs_tree(treeview, '', 'end', tree, ruleNames)
    tree_gui.mainloop()
    

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