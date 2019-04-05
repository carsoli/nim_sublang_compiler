# Generated from milestone_1.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\u0094")
        buf.write("\7\4\2\t\2\3\2\3\2\3\2\2\2\3\2\2\2\2\5\2\4\3\2\2\2\4\5")
        buf.write("\7\31\2\2\5\3\3\2\2\2\2")
        return buf.getvalue()


class milestone_1Parser ( Parser ):

    grammarFileName = "milestone_1.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'#'", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "'\r\n'", "' '", "<INVALID>", "','", "';'", "':'", 
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
                     "'of'", "'defer'", "'discard'", "'distinct'", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "'\\\"'", "'''", 
                     "<INVALID>", "'\\a'", "'\\b'", "'\\'", "'\\e'", "<INVALID>", 
                     "'\\f'", "<INVALID>", "<INVALID>", "'\\p'" ]

    symbolicNames = [ "<INVALID>", "HASH", "COMMENT_BODY", "COMMENT", "MULTILINE_COMMENT", 
                      "NEWLINE", "WS", "INDENT", "COMMA", "SEMI_COLON", 
                      "COLON", "DOT", "OPEN_PAREN", "CLOSE_PAREN", "OPEN_BRACE", 
                      "CLOSE_BRACE", "OPEN_BRACK", "CLOSE_BRACK", "INTERFACE", 
                      "ENUM", "OBJECT", "CONCEPT", "TYPE", "AND", "OR", 
                      "XOR", "SHL", "SHR", "MOD", "DIV", "AT", "AND_OPERATOR", 
                      "OR_OPERATOR", "ADD_OPERATOR", "MINUS_OPERATOR", "DIV_OPERATOR", 
                      "LESS_THAN", "GREATER_THAN", "MODULUS", "XOR_OPERATOR", 
                      "EQUALS_OPERATOR", "MUL_OPERATOR", "BITWISE_NOT_OPERATOR", 
                      "NOT_OPERATOR", "VARIABLE", "LET", "CONST", "BIND", 
                      "PROC", "STATIC", "METHOD", "FUNC", "MIXIN", "END", 
                      "EXCEPT", "RETURN", "TRY", "RAISE", "FINALLY", "OUT", 
                      "CASE", "ELSE", "ELIF", "DO", "WHILE", "ITERATOR", 
                      "FOR", "IN", "NOTIN", "CONTINUE", "BREAK", "TEMPLATE", 
                      "TUPLE", "USING", "WHEN", "YIELD", "INCLUDE", "IMPORT", 
                      "FROM", "AS", "EXPORT", "REF", "PTR", "ADDR", "IS", 
                      "NOT", "ISNOT", "ASM", "BLOCK", "MACRO", "NIL", "CAST", 
                      "CONVERTER", "OF", "DEFER", "DISCARD", "DISTINCT", 
                      "DIGIT", "LETTER", "IDENTIFIER", "OCTDIGIT", "BINDIGIT", 
                      "HEXDIGIT", "HEX_LIT", "BIN_LIT", "OCT_LIT", "DEC_LIT", 
                      "INT_LIT", "INT_SUFFIX", "INT8_LIT", "INT16_LIT", 
                      "INT32_LIT", "INT64_LIT", "UINT_SUFFIX", "UINT_LIT", 
                      "UINT8_LIT", "UINT16_LIT", "UINT32_LIT", "UINT64_LIT", 
                      "EXP", "FLOAT_LIT", "FLOAT32_SUFFIX", "FLOAT32_LIT", 
                      "FLOAT64_SUFFIX", "FLOAT64_LIT", "QUOTATION_MARK", 
                      "APOSTRAPHE", "CARRIAGE_RETURN", "ALERT", "BACKSPACE", 
                      "BACKSLASH", "ESCAPE", "LINE_FEED", "FORM_FEED", "TAB", 
                      "CODE_CHARACTER", "PLATFORM_SPECIFIC_NEWLINE", "CHAR_ESCAPE_SEQUENCES", 
                      "CHAR_LIT", "STR_LIT", "STR_LIT_ENDING", "TRIPLESTR_LIT", 
                      "RSTR_LIT", "GENERALIZED_RSTR_LIT", "GENERALIZED_STR_LIT", 
                      "GENERALIZED_RTRIPSTR_LIT", "GENERALIZED_TRIPLESTR_LIT" ]

    RULE_start = 0

    ruleNames =  [ "start" ]

    EOF = Token.EOF
    HASH=1
    COMMENT_BODY=2
    COMMENT=3
    MULTILINE_COMMENT=4
    NEWLINE=5
    WS=6
    INDENT=7
    COMMA=8
    SEMI_COLON=9
    COLON=10
    DOT=11
    OPEN_PAREN=12
    CLOSE_PAREN=13
    OPEN_BRACE=14
    CLOSE_BRACE=15
    OPEN_BRACK=16
    CLOSE_BRACK=17
    INTERFACE=18
    ENUM=19
    OBJECT=20
    CONCEPT=21
    TYPE=22
    AND=23
    OR=24
    XOR=25
    SHL=26
    SHR=27
    MOD=28
    DIV=29
    AT=30
    AND_OPERATOR=31
    OR_OPERATOR=32
    ADD_OPERATOR=33
    MINUS_OPERATOR=34
    DIV_OPERATOR=35
    LESS_THAN=36
    GREATER_THAN=37
    MODULUS=38
    XOR_OPERATOR=39
    EQUALS_OPERATOR=40
    MUL_OPERATOR=41
    BITWISE_NOT_OPERATOR=42
    NOT_OPERATOR=43
    VARIABLE=44
    LET=45
    CONST=46
    BIND=47
    PROC=48
    STATIC=49
    METHOD=50
    FUNC=51
    MIXIN=52
    END=53
    EXCEPT=54
    RETURN=55
    TRY=56
    RAISE=57
    FINALLY=58
    OUT=59
    CASE=60
    ELSE=61
    ELIF=62
    DO=63
    WHILE=64
    ITERATOR=65
    FOR=66
    IN=67
    NOTIN=68
    CONTINUE=69
    BREAK=70
    TEMPLATE=71
    TUPLE=72
    USING=73
    WHEN=74
    YIELD=75
    INCLUDE=76
    IMPORT=77
    FROM=78
    AS=79
    EXPORT=80
    REF=81
    PTR=82
    ADDR=83
    IS=84
    NOT=85
    ISNOT=86
    ASM=87
    BLOCK=88
    MACRO=89
    NIL=90
    CAST=91
    CONVERTER=92
    OF=93
    DEFER=94
    DISCARD=95
    DISTINCT=96
    DIGIT=97
    LETTER=98
    IDENTIFIER=99
    OCTDIGIT=100
    BINDIGIT=101
    HEXDIGIT=102
    HEX_LIT=103
    BIN_LIT=104
    OCT_LIT=105
    DEC_LIT=106
    INT_LIT=107
    INT_SUFFIX=108
    INT8_LIT=109
    INT16_LIT=110
    INT32_LIT=111
    INT64_LIT=112
    UINT_SUFFIX=113
    UINT_LIT=114
    UINT8_LIT=115
    UINT16_LIT=116
    UINT32_LIT=117
    UINT64_LIT=118
    EXP=119
    FLOAT_LIT=120
    FLOAT32_SUFFIX=121
    FLOAT32_LIT=122
    FLOAT64_SUFFIX=123
    FLOAT64_LIT=124
    QUOTATION_MARK=125
    APOSTRAPHE=126
    CARRIAGE_RETURN=127
    ALERT=128
    BACKSPACE=129
    BACKSLASH=130
    ESCAPE=131
    LINE_FEED=132
    FORM_FEED=133
    TAB=134
    CODE_CHARACTER=135
    PLATFORM_SPECIFIC_NEWLINE=136
    CHAR_ESCAPE_SEQUENCES=137
    CHAR_LIT=138
    STR_LIT=139
    STR_LIT_ENDING=140
    TRIPLESTR_LIT=141
    RSTR_LIT=142
    GENERALIZED_RSTR_LIT=143
    GENERALIZED_STR_LIT=144
    GENERALIZED_RTRIPSTR_LIT=145
    GENERALIZED_TRIPLESTR_LIT=146

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





