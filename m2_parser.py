# Generated from m2_parser.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\u0084")
        buf.write("\31\4\2\t\2\4\3\t\3\4\4\t\4\3\2\3\2\3\2\3\3\3\3\3\3\3")
        buf.write("\3\7\3\20\n\3\f\3\16\3\23\13\3\5\3\25\n\3\3\4\3\4\3\4")
        buf.write("\2\2\5\2\4\6\2\2\2\30\2\b\3\2\2\2\4\24\3\2\2\2\6\26\3")
        buf.write("\2\2\2\b\t\b\2\1\2\t\n\7z\2\2\n\3\3\2\2\2\13\21\5\2\2")
        buf.write("\2\f\20\7\21\2\2\r\16\7\23\2\2\16\20\5\2\2\2\17\f\3\2")
        buf.write("\2\2\17\r\3\2\2\2\20\23\3\2\2\2\21\17\3\2\2\2\21\22\3")
        buf.write("\2\2\2\22\25\3\2\2\2\23\21\3\2\2\2\24\13\3\2\2\2\24\25")
        buf.write("\3\2\2\2\25\5\3\2\2\2\26\27\5\2\2\2\27\7\3\2\2\2\5\17")
        buf.write("\21\24")
        return buf.getvalue()


class m2_parser ( Parser ):

    grammarFileName = "m2_parser.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "' '", "','", "';'", "':'", "'.'", "'('", 
                     "')'", "'{'", "'}'", "'['", "']'", "'interface'", "'enum'", 
                     "'object'", "'concept'", "'type'", "'and'", "'or'", 
                     "'xor'", "'shl'", "'shr'", "'mod'", "'div'", "'@'", 
                     "'&'", "'|'", "'+'", "'-'", "'/'", "'<'", "'>'", "'%'", 
                     "'^'", "'=='", "'*'", "'~'", "'!'", "'='", "'var'", 
                     "'let'", "'const'", "'bind'", "'proc'", "'static'", 
                     "'method'", "'func'", "'mixin'", "'end'", "'except'", 
                     "'return'", "'try'", "'raise'", "'finally'", "'out'", 
                     "'case'", "'if'", "'elif'", "'else'", "'do'", "'while'", 
                     "'iterator'", "'for'", "'in'", "'notin'", "'continue'", 
                     "'break'", "'template'", "'tuple'", "'using'", "'when'", 
                     "'yield'", "'include'", "'import'", "'from'", "'as'", 
                     "'export'", "'ref'", "'ptr'", "'addr'", "'is'", "'not'", 
                     "'isnot'", "'asm'", "'block'", "'macro'", "'nil'", 
                     "'cast'", "'converter'", "'of'", "'defer'", "'discard'", 
                     "'distinct'" ]

    symbolicNames = [ "<INVALID>", "OP1", "OP2", "OP3", "OP4", "OP5", "OP7", 
                      "OP8", "OP9", "DOCUMENTATION_COMMENT", "MULTILINE_COMMENT", 
                      "COMMENT", "NEWLINE", "WS", "COMMA", "SEMI_COLON", 
                      "COLON", "DOT", "OPEN_PAREN", "CLOSE_PAREN", "OPEN_BRACE", 
                      "CLOSE_BRACE", "OPEN_BRACK", "CLOSE_BRACK", "INTERFACE", 
                      "ENUM", "OBJECT", "CONCEPT", "TYPE", "AND", "OR", 
                      "XOR", "SHL", "SHR", "MOD", "DIV", "AT", "AND_OPERATOR", 
                      "OR_OPERATOR", "ADD_OPERATOR", "MINUS_OPERATOR", "DIV_OPERATOR", 
                      "LESS_THAN", "GREATER_THAN", "MODULUS", "XOR_OPERATOR", 
                      "EQUALS_OPERATOR", "MUL_OPERATOR", "BITWISE_NOT_OPERATOR", 
                      "NOT_OPERATOR", "ASSIGNMENT_OPERATOR", "VARIABLE", 
                      "LET", "CONST", "BIND", "PROC", "STATIC", "METHOD", 
                      "FUNC", "MIXIN", "END", "EXCEPT", "RETURN", "TRY", 
                      "RAISE", "FINALLY", "OUT", "CASE", "IF", "ELIF", "ELSE", 
                      "DO", "WHILE", "ITERATOR", "FOR", "IN", "NOTIN", "CONTINUE", 
                      "BREAK", "TEMPLATE", "TUPLE", "USING", "WHEN", "YIELD", 
                      "INCLUDE", "IMPORT", "FROM", "AS", "EXPORT", "REF", 
                      "PTR", "ADDR", "IS", "NOT", "ISNOT", "ASM", "BLOCK", 
                      "MACRO", "NIL", "CAST", "CONVERTER", "OF", "DEFER", 
                      "DISCARD", "DISTINCT", "IDENTIFIER", "INT_LIT", "INT8_LIT", 
                      "INT16_LIT", "INT32_LIT", "INT64_LIT", "UINT_LIT", 
                      "UINT8_LIT", "UINT16_LIT", "UINT32_LIT", "UINT64_LIT", 
                      "EXP", "FLOAT_LIT", "FLOAT32_LIT", "FLOAT64_LIT", 
                      "CHAR_LIT", "STR_LIT", "TRIPLESTR_LIT", "RSTR_LIT", 
                      "GENERALIZED_STR_LIT", "GENERALIZED_TRIPLESTR_LIT", 
                      "EXIT", "USELESS_LINE", "USELSSS_INDENTS", "INDENT", 
                      "ERROR_INDENT" ]

    RULE_stmt = 0
    RULE_module = 1
    RULE_start = 2

    ruleNames =  [ "stmt", "module", "start" ]

    EOF = Token.EOF
    OP1=1
    OP2=2
    OP3=3
    OP4=4
    OP5=5
    OP7=6
    OP8=7
    OP9=8
    DOCUMENTATION_COMMENT=9
    MULTILINE_COMMENT=10
    COMMENT=11
    NEWLINE=12
    WS=13
    COMMA=14
    SEMI_COLON=15
    COLON=16
    DOT=17
    OPEN_PAREN=18
    CLOSE_PAREN=19
    OPEN_BRACE=20
    CLOSE_BRACE=21
    OPEN_BRACK=22
    CLOSE_BRACK=23
    INTERFACE=24
    ENUM=25
    OBJECT=26
    CONCEPT=27
    TYPE=28
    AND=29
    OR=30
    XOR=31
    SHL=32
    SHR=33
    MOD=34
    DIV=35
    AT=36
    AND_OPERATOR=37
    OR_OPERATOR=38
    ADD_OPERATOR=39
    MINUS_OPERATOR=40
    DIV_OPERATOR=41
    LESS_THAN=42
    GREATER_THAN=43
    MODULUS=44
    XOR_OPERATOR=45
    EQUALS_OPERATOR=46
    MUL_OPERATOR=47
    BITWISE_NOT_OPERATOR=48
    NOT_OPERATOR=49
    ASSIGNMENT_OPERATOR=50
    VARIABLE=51
    LET=52
    CONST=53
    BIND=54
    PROC=55
    STATIC=56
    METHOD=57
    FUNC=58
    MIXIN=59
    END=60
    EXCEPT=61
    RETURN=62
    TRY=63
    RAISE=64
    FINALLY=65
    OUT=66
    CASE=67
    IF=68
    ELIF=69
    ELSE=70
    DO=71
    WHILE=72
    ITERATOR=73
    FOR=74
    IN=75
    NOTIN=76
    CONTINUE=77
    BREAK=78
    TEMPLATE=79
    TUPLE=80
    USING=81
    WHEN=82
    YIELD=83
    INCLUDE=84
    IMPORT=85
    FROM=86
    AS=87
    EXPORT=88
    REF=89
    PTR=90
    ADDR=91
    IS=92
    NOT=93
    ISNOT=94
    ASM=95
    BLOCK=96
    MACRO=97
    NIL=98
    CAST=99
    CONVERTER=100
    OF=101
    DEFER=102
    DISCARD=103
    DISTINCT=104
    IDENTIFIER=105
    INT_LIT=106
    INT8_LIT=107
    INT16_LIT=108
    INT32_LIT=109
    INT64_LIT=110
    UINT_LIT=111
    UINT8_LIT=112
    UINT16_LIT=113
    UINT32_LIT=114
    UINT64_LIT=115
    EXP=116
    FLOAT_LIT=117
    FLOAT32_LIT=118
    FLOAT64_LIT=119
    CHAR_LIT=120
    STR_LIT=121
    TRIPLESTR_LIT=122
    RSTR_LIT=123
    GENERALIZED_STR_LIT=124
    GENERALIZED_TRIPLESTR_LIT=125
    EXIT=126
    USELESS_LINE=127
    USELSSS_INDENTS=128
    INDENT=129
    ERROR_INDENT=130

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None



    levels = []
    indent_level = 0

    def getCurrentToken(self):
        token = super().getCurrentToken()
        print(self.INDENT == token.type)
        return token 

    def jump(self, ttype):
        print("ai haga")



    class StmtContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def CHAR_LIT(self):
            return self.getToken(m2_parser.CHAR_LIT, 0)

        def getRuleIndex(self):
            return m2_parser.RULE_stmt

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStmt" ):
                listener.enterStmt(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStmt" ):
                listener.exitStmt(self)




    def stmt(self):

        localctx = m2_parser.StmtContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_stmt)
        try:
            self.enterOuterAlt(localctx, 1)
            self.jump('beda')
            self.state = 7
            self.match(m2_parser.CHAR_LIT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ModuleContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def stmt(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(m2_parser.StmtContext)
            else:
                return self.getTypedRuleContext(m2_parser.StmtContext,i)


        def SEMI_COLON(self, i:int=None):
            if i is None:
                return self.getTokens(m2_parser.SEMI_COLON)
            else:
                return self.getToken(m2_parser.SEMI_COLON, i)

        def DOT(self, i:int=None):
            if i is None:
                return self.getTokens(m2_parser.DOT)
            else:
                return self.getToken(m2_parser.DOT, i)

        def getRuleIndex(self):
            return m2_parser.RULE_module

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterModule" ):
                listener.enterModule(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitModule" ):
                listener.exitModule(self)




    def module(self):

        localctx = m2_parser.ModuleContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_module)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 18
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==m2_parser.CHAR_LIT:
                self.state = 9
                self.stmt()
                self.state = 15
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==m2_parser.SEMI_COLON or _la==m2_parser.DOT:
                    self.state = 13
                    self._errHandler.sync(self)
                    token = self._input.LA(1)
                    if token in [m2_parser.SEMI_COLON]:
                        self.state = 10
                        self.match(m2_parser.SEMI_COLON)
                        pass
                    elif token in [m2_parser.DOT]:
                        self.state = 11
                        self.match(m2_parser.DOT)
                        self.state = 12
                        self.stmt()
                        pass
                    else:
                        raise NoViableAltException(self)

                    self.state = 17
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StartContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def stmt(self):
            return self.getTypedRuleContext(m2_parser.StmtContext,0)


        def getRuleIndex(self):
            return m2_parser.RULE_start

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStart" ):
                listener.enterStart(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStart" ):
                listener.exitStart(self)




    def start(self):

        localctx = m2_parser.StartContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_start)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 20
            self.stmt()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





