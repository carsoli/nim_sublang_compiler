# Generated from milestone_1.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3v")
        buf.write("\7\4\2\t\2\3\2\3\2\3\2\2\2\3\2\2\2\2\5\2\4\3\2\2\2\4\5")
        buf.write("\7\30\2\2\5\3\3\2\2\2\2")
        return buf.getvalue()


class milestone_1Parser ( Parser ):

    grammarFileName = "milestone_1.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'\\r\\n'", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "' '", "<INVALID>", "','", "';'", "':'", 
                     "'.'", "'('", "')'", "'{'", "'}'", "'['", "']'", "'interface'", 
                     "'enum'", "'object'", "'concept'", "'type'", "'and'", 
                     "'or'", "'xor'", "'shl'", "'shr'", "'mod'", "'div'", 
                     "'@'", "'&'", "'|'", "'+'", "'-'", "'/'", "'<'", "'>'", 
                     "'%'", "'^'", "<INVALID>", "'*'", "'~'", "'!'", "'var'", 
                     "'let'", "'const'", "'bind'", "'proc'", "'static'", 
                     "'method'", "'func'", "'mixin'", "'end'", "'except'", 
                     "'return'", "'try'", "'raise'", "'finally'", "'out'", 
                     "'case'", "'else'", "'elif'", "'do'", "'while'", "'iterator'", 
                     "'for'", "'in'", "'notin'", "'continue'", "'break'", 
                     "'template'", "'tuple'", "'using'", "'when'", "'yield'", 
                     "'include'", "'import'", "'from'", "'as'", "'export'", 
                     "'ref'", "'ptr'", "'addr'", "'is'", "'not'", "'isnot'", 
                     "'asm'", "'block'", "'macro'", "'nil'", "'cast'", "'converter'", 
                     "'of'", "'defer'", "'discard'", "'distinct'" ]

    symbolicNames = [ "<INVALID>", "NEWLINE", "COMMENT", "MULTILINE_COMMENT", 
                      "DOCUMENTATION_COMMENT", "WS", "INDENT", "COMMA", 
                      "SEMI_COLON", "COLON", "DOT", "OPEN_PAREN", "CLOSE_PAREN", 
                      "OPEN_BRACE", "CLOSE_BRACE", "OPEN_BRACK", "CLOSE_BRACK", 
                      "INTERFACE", "ENUM", "OBJECT", "CONCEPT", "TYPE", 
                      "AND", "OR", "XOR", "SHL", "SHR", "MOD", "DIV", "AT", 
                      "AND_OPERATOR", "OR_OPERATOR", "ADD_OPERATOR", "MINUS_OPERATOR", 
                      "DIV_OPERATOR", "LESS_THAN", "GREATER_THAN", "MODULUS", 
                      "XOR_OPERATOR", "EQUALS_OPERATOR", "MUL_OPERATOR", 
                      "BITWISE_NOT_OPERATOR", "NOT_OPERATOR", "VARIABLE", 
                      "LET", "CONST", "BIND", "PROC", "STATIC", "METHOD", 
                      "FUNC", "MIXIN", "END", "EXCEPT", "RETURN", "TRY", 
                      "RAISE", "FINALLY", "OUT", "CASE", "ELSE", "ELIF", 
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
                      "GENERALIZED_STR_LIT", "GENERALIZED_TRIPLESTR_LIT" ]

    RULE_start = 0

    ruleNames =  [ "start" ]

    EOF = Token.EOF
    NEWLINE=1
    COMMENT=2
    MULTILINE_COMMENT=3
    DOCUMENTATION_COMMENT=4
    WS=5
    INDENT=6
    COMMA=7
    SEMI_COLON=8
    COLON=9
    DOT=10
    OPEN_PAREN=11
    CLOSE_PAREN=12
    OPEN_BRACE=13
    CLOSE_BRACE=14
    OPEN_BRACK=15
    CLOSE_BRACK=16
    INTERFACE=17
    ENUM=18
    OBJECT=19
    CONCEPT=20
    TYPE=21
    AND=22
    OR=23
    XOR=24
    SHL=25
    SHR=26
    MOD=27
    DIV=28
    AT=29
    AND_OPERATOR=30
    OR_OPERATOR=31
    ADD_OPERATOR=32
    MINUS_OPERATOR=33
    DIV_OPERATOR=34
    LESS_THAN=35
    GREATER_THAN=36
    MODULUS=37
    XOR_OPERATOR=38
    EQUALS_OPERATOR=39
    MUL_OPERATOR=40
    BITWISE_NOT_OPERATOR=41
    NOT_OPERATOR=42
    VARIABLE=43
    LET=44
    CONST=45
    BIND=46
    PROC=47
    STATIC=48
    METHOD=49
    FUNC=50
    MIXIN=51
    END=52
    EXCEPT=53
    RETURN=54
    TRY=55
    RAISE=56
    FINALLY=57
    OUT=58
    CASE=59
    ELSE=60
    ELIF=61
    DO=62
    WHILE=63
    ITERATOR=64
    FOR=65
    IN=66
    NOTIN=67
    CONTINUE=68
    BREAK=69
    TEMPLATE=70
    TUPLE=71
    USING=72
    WHEN=73
    YIELD=74
    INCLUDE=75
    IMPORT=76
    FROM=77
    AS=78
    EXPORT=79
    REF=80
    PTR=81
    ADDR=82
    IS=83
    NOT=84
    ISNOT=85
    ASM=86
    BLOCK=87
    MACRO=88
    NIL=89
    CAST=90
    CONVERTER=91
    OF=92
    DEFER=93
    DISCARD=94
    DISTINCT=95
    IDENTIFIER=96
    INT_LIT=97
    INT8_LIT=98
    INT16_LIT=99
    INT32_LIT=100
    INT64_LIT=101
    UINT_LIT=102
    UINT8_LIT=103
    UINT16_LIT=104
    UINT32_LIT=105
    UINT64_LIT=106
    EXP=107
    FLOAT_LIT=108
    FLOAT32_LIT=109
    FLOAT64_LIT=110
    CHAR_LIT=111
    STR_LIT=112
    TRIPLESTR_LIT=113
    RSTR_LIT=114
    GENERALIZED_STR_LIT=115
    GENERALIZED_TRIPLESTR_LIT=116

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class StartContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def AND(self):
            return self.getToken(milestone_1Parser.AND, 0)

        def getRuleIndex(self):
            return milestone_1Parser.RULE_start

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStart" ):
                listener.enterStart(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStart" ):
                listener.exitStart(self)




    def start(self):

        localctx = milestone_1Parser.StartContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_start)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 2
            self.match(milestone_1Parser.AND)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





