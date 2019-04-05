# Generated from milestone_1.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\u0095")
        buf.write("\7\4\2\t\2\3\2\3\2\3\2\2\2\3\2\2\2\2\5\2\4\3\2\2\2\4\5")
        buf.write("\7\32\2\2\5\3\3\2\2\2\2")
        return buf.getvalue()


class milestone_1Parser ( Parser ):

    grammarFileName = "milestone_1.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'#'", "'\\r\\n'", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "' '", "<INVALID>", "','", 
                     "';'", "':'", "'.'", "'('", "')'", "'{'", "'}'", "'['", 
                     "']'", "'interface'", "'enum'", "'object'", "'concept'", 
                     "'type'", "'and'", "'or'", "'xor'", "'shl'", "'shr'", 
                     "'mod'", "'div'", "'@'", "'&'", "'|'", "'+'", "'-'", 
                     "'/'", "'<'", "'>'", "'%'", "'^'", "<INVALID>", "'*'", 
                     "'~'", "'!'", "'var'", "'let'", "'const'", "'bind'", 
                     "'proc'", "'static'", "'method'", "'func'", "'mixin'", 
                     "'end'", "'except'", "'return'", "'try'", "'raise'", 
                     "'finally'", "'out'", "'case'", "'else'", "'elif'", 
                     "'do'", "'while'", "'iterator'", "'for'", "'in'", "'notin'", 
                     "'continue'", "'break'", "'template'", "'tuple'", "'using'", 
                     "'when'", "'yield'", "'include'", "'import'", "'from'", 
                     "'as'", "'export'", "'ref'", "'ptr'", "'addr'", "'is'", 
                     "'not'", "'isnot'", "'asm'", "'block'", "'macro'", 
                     "'nil'", "'cast'", "'converter'", "'of'", "'defer'", 
                     "'discard'", "'distinct'", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "'\"'", "'''", "<INVALID>", 
                     "'\\a'", "'\\b'", "'\\'", "'\\e'", "<INVALID>", "'\\f'", 
                     "<INVALID>", "<INVALID>", "'\\p'" ]

    symbolicNames = [ "<INVALID>", "HASH", "NEWLINE", "COMMENT_BODY", "COMMENT", 
                      "MULTILINE_COMMENT", "DOCUMENTATION_COMMENT", "WS", 
                      "INDENT", "COMMA", "SEMI_COLON", "COLON", "DOT", "OPEN_PAREN", 
                      "CLOSE_PAREN", "OPEN_BRACE", "CLOSE_BRACE", "OPEN_BRACK", 
                      "CLOSE_BRACK", "INTERFACE", "ENUM", "OBJECT", "CONCEPT", 
                      "TYPE", "AND", "OR", "XOR", "SHL", "SHR", "MOD", "DIV", 
                      "AT", "AND_OPERATOR", "OR_OPERATOR", "ADD_OPERATOR", 
                      "MINUS_OPERATOR", "DIV_OPERATOR", "LESS_THAN", "GREATER_THAN", 
                      "MODULUS", "XOR_OPERATOR", "EQUALS_OPERATOR", "MUL_OPERATOR", 
                      "BITWISE_NOT_OPERATOR", "NOT_OPERATOR", "VARIABLE", 
                      "LET", "CONST", "BIND", "PROC", "STATIC", "METHOD", 
                      "FUNC", "MIXIN", "END", "EXCEPT", "RETURN", "TRY", 
                      "RAISE", "FINALLY", "OUT", "CASE", "ELSE", "ELIF", 
                      "DO", "WHILE", "ITERATOR", "FOR", "IN", "NOTIN", "CONTINUE", 
                      "BREAK", "TEMPLATE", "TUPLE", "USING", "WHEN", "YIELD", 
                      "INCLUDE", "IMPORT", "FROM", "AS", "EXPORT", "REF", 
                      "PTR", "ADDR", "IS", "NOT", "ISNOT", "ASM", "BLOCK", 
                      "MACRO", "NIL", "CAST", "CONVERTER", "OF", "DEFER", 
                      "DISCARD", "DISTINCT", "DIGIT", "LETTER", "IDENTIFIER", 
                      "OCTDIGIT", "BINDIGIT", "HEXDIGIT", "HEX_LIT", "BIN_LIT", 
                      "OCT_LIT", "DEC_LIT", "INT_LIT", "INT_SUFFIX", "INT8_LIT", 
                      "INT16_LIT", "INT32_LIT", "INT64_LIT", "UINT_SUFFIX", 
                      "UINT_LIT", "UINT8_LIT", "UINT16_LIT", "UINT32_LIT", 
                      "UINT64_LIT", "EXP", "FLOAT_LIT", "FLOAT32_SUFFIX", 
                      "FLOAT32_LIT", "FLOAT64_SUFFIX", "FLOAT64_LIT", "QUOTATION_MARK", 
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
    NEWLINE=2
    COMMENT_BODY=3
    COMMENT=4
    MULTILINE_COMMENT=5
    DOCUMENTATION_COMMENT=6
    WS=7
    INDENT=8
    COMMA=9
    SEMI_COLON=10
    COLON=11
    DOT=12
    OPEN_PAREN=13
    CLOSE_PAREN=14
    OPEN_BRACE=15
    CLOSE_BRACE=16
    OPEN_BRACK=17
    CLOSE_BRACK=18
    INTERFACE=19
    ENUM=20
    OBJECT=21
    CONCEPT=22
    TYPE=23
    AND=24
    OR=25
    XOR=26
    SHL=27
    SHR=28
    MOD=29
    DIV=30
    AT=31
    AND_OPERATOR=32
    OR_OPERATOR=33
    ADD_OPERATOR=34
    MINUS_OPERATOR=35
    DIV_OPERATOR=36
    LESS_THAN=37
    GREATER_THAN=38
    MODULUS=39
    XOR_OPERATOR=40
    EQUALS_OPERATOR=41
    MUL_OPERATOR=42
    BITWISE_NOT_OPERATOR=43
    NOT_OPERATOR=44
    VARIABLE=45
    LET=46
    CONST=47
    BIND=48
    PROC=49
    STATIC=50
    METHOD=51
    FUNC=52
    MIXIN=53
    END=54
    EXCEPT=55
    RETURN=56
    TRY=57
    RAISE=58
    FINALLY=59
    OUT=60
    CASE=61
    ELSE=62
    ELIF=63
    DO=64
    WHILE=65
    ITERATOR=66
    FOR=67
    IN=68
    NOTIN=69
    CONTINUE=70
    BREAK=71
    TEMPLATE=72
    TUPLE=73
    USING=74
    WHEN=75
    YIELD=76
    INCLUDE=77
    IMPORT=78
    FROM=79
    AS=80
    EXPORT=81
    REF=82
    PTR=83
    ADDR=84
    IS=85
    NOT=86
    ISNOT=87
    ASM=88
    BLOCK=89
    MACRO=90
    NIL=91
    CAST=92
    CONVERTER=93
    OF=94
    DEFER=95
    DISCARD=96
    DISTINCT=97
    DIGIT=98
    LETTER=99
    IDENTIFIER=100
    OCTDIGIT=101
    BINDIGIT=102
    HEXDIGIT=103
    HEX_LIT=104
    BIN_LIT=105
    OCT_LIT=106
    DEC_LIT=107
    INT_LIT=108
    INT_SUFFIX=109
    INT8_LIT=110
    INT16_LIT=111
    INT32_LIT=112
    INT64_LIT=113
    UINT_SUFFIX=114
    UINT_LIT=115
    UINT8_LIT=116
    UINT16_LIT=117
    UINT32_LIT=118
    UINT64_LIT=119
    EXP=120
    FLOAT_LIT=121
    FLOAT32_SUFFIX=122
    FLOAT32_LIT=123
    FLOAT64_SUFFIX=124
    FLOAT64_LIT=125
    QUOTATION_MARK=126
    APOSTRAPHE=127
    CARRIAGE_RETURN=128
    ALERT=129
    BACKSPACE=130
    BACKSLASH=131
    ESCAPE=132
    LINE_FEED=133
    FORM_FEED=134
    TAB=135
    CODE_CHARACTER=136
    PLATFORM_SPECIFIC_NEWLINE=137
    CHAR_ESCAPE_SEQUENCES=138
    CHAR_LIT=139
    STR_LIT=140
    STR_LIT_ENDING=141
    TRIPLESTR_LIT=142
    RSTR_LIT=143
    GENERALIZED_RSTR_LIT=144
    GENERALIZED_STR_LIT=145
    GENERALIZED_RTRIPSTR_LIT=146
    GENERALIZED_TRIPLESTR_LIT=147

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





