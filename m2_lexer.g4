lexer grammar m2_lexer;

options {language='Python3';}

@lexer::header{
from antlr4.Token import CommonToken
}

@lexer::members{
previous_line_indents = 0
current_line_indents = 0
hook_tokens = []

def nextToken(self):
    if len(self.hook_tokens) > 0:
        return self.hook_tokens.pop()
    return super().nextToken()

def adjustIndents(self):
    self.previous_line_indents = self.current_line_indents
    self.current_line_indents = 0

def incrementIndents(self):
    self.current_line_indents += 1

def canMatch(self):
    return self.current_line_indents >= self.previous_line_indents

def canDedent(self):
    return self.current_line_indents < self.previous_line_indents

def dedent(self):
    dedent_token = self._factory.create(self._tokenFactorySourcePair, self.DEDENT, '', self._channel, 1, 2, self._tokenStartLine, self._tokenStartColumn)
    for i in range(self.previous_line_indents - self.current_line_indents - 1):
        self.hook_tokens.append(dedent_token)
}

OP1: (ASSIGNMENT_OPERATOR );
OP2: AT; 
OP3: OR | XOR;
OP4: AND; 
OP5: EQUALS_OPERATOR | LESS_THAN | GREATER_THAN | IS | ISNOT | IN | NOTIN | NOT | OF; 
OP7: AND_OPERATOR;
OP8: ADD_OPERATOR | MINUS_OPERATOR; 
OP9: MUL_OPERATOR | DIV_OPERATOR | DIV | MOD | SHL | SHR | MODULUS;

fragment HASH: '#';

fragment COMPOSITE_COMMENT_PART: ( [\u0020-\u0022] | [\u0024-\u005A] | [\u005C-\u00FF] | TAB | NEWLINE );
/*
    allow nested documentation comments,
    do not allow ]## within without closing it (part of nested documentation comment)
*/ 
fragment DOCUMENTATION_COMMENT_BODY 
    : (
        COMPOSITE_COMMENT_PART 
        |  DOCUMENTATION_COMMENT
        |  {self._input.LA(-2) != ord(']') or self._input.LA(-1) != ord('#')}? '#' 
        |  {self._input.LA(-2) != ord('#') or self._input.LA(-1) != ord('#')}? '['
    );
DOCUMENTATION_COMMENT: HASH HASH OPEN_BRACK DOCUMENTATION_COMMENT_BODY* CLOSE_BRACK HASH HASH -> skip;

fragment MULTILINE_COMMENT_BODY
    : (
        COMPOSITE_COMMENT_PART 
        |  MULTILINE_COMMENT
        |  {self._input.LA(-1) != ord(']')}? '#' 
        |  {self._input.LA(-1) != ord('#')}? '['
    );
MULTILINE_COMMENT: HASH OPEN_BRACK MULTILINE_COMMENT_BODY* CLOSE_BRACK HASH -> skip;

fragment COMMENT_PART: ( [\u0020-\u005A] | [\u005C-\u00FF] | TAB );
fragment COMMENT_BODY: (COMMENT_PART? | COMMENT_PART COMMENT_PART (COMMENT_PART | OPEN_BRACK)*);
COMMENT: HASH COMMENT_BODY -> skip;

// USELESS_LINE: WS+ NEWLINE;
UNCONDITIONAL_NEWLINE:  '\r'? '\n' {self.adjustIndents()} -> pushMode(INDENTS_MODE), skip;
fragment NEWLINE: '\r'? '\n';
WS: ' ' -> skip;

COMMA: ',';
SEMI_COLON: ';';
COLON: ':';
DOT: '.';
OPEN_PAREN: '(';
CLOSE_PAREN: ')';
OPEN_BRACE: '{';
CLOSE_BRACE: '}';
OPEN_BRACK: '[';
CLOSE_BRACK: ']';

INTERFACE: 'interface';
ENUM: 'enum';
OBJECT: 'object';
CONCEPT: 'concept';
TYPE: 'type';

AND: 'and';
OR: 'or';
XOR: 'xor';
SHL: 'shl';
SHR: 'shr';
MOD: 'mod';
DIV: 'div';

AT: '@';
AND_OPERATOR: '&';
OR_OPERATOR: '|';
ADD_OPERATOR: '+';
MINUS_OPERATOR: '-';
DIV_OPERATOR: '/';
LESS_THAN: '<';
GREATER_THAN: '>';
MODULUS: '%';

XOR_OPERATOR: '^';
EQUALS_OPERATOR: '==';
MUL_OPERATOR: '*';
BITWISE_NOT_OPERATOR: '~';
NOT_OPERATOR: '!'; 

ASSIGNMENT_OPERATOR: '=';

VARIABLE: 'var';
LET: 'let';
CONST: 'const';

BIND: 'bind';

PROC: 'proc';
STATIC: 'static';
METHOD: 'method';
FUNC: 'func';
MIXIN: 'mixin';
END: 'end';
EXCEPT: 'except';

RETURN: 'return';

TRY: 'try';
RAISE: 'raise';
FINALLY: 'finally';

OUT: 'out';

CASE: 'case';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';

DO: 'do';
WHILE: 'while';
ITERATOR: 'iterator';
FOR: 'for';

IN: 'in';
NOTIN: 'notin';

CONTINUE: 'continue';
BREAK: 'break';

TEMPLATE: 'template';
TUPLE: 'tuple';
USING: 'using';
WHEN: 'when';
YIELD: 'yield';

INCLUDE: 'include';
IMPORT: 'import';
FROM: 'from';
AS: 'as';
EXPORT: 'export';

REF: 'ref';
PTR: 'ptr';
ADDR: 'addr';

IS: 'is';
NOT: 'not';
ISNOT: 'isnot';

ASM: 'asm';
BLOCK: 'block';
MACRO: 'macro';

NIL: 'nil';
CAST: 'cast';
CONVERTER: 'converter';
OF: 'of';
DEFER: 'defer';
DISCARD: 'discard';
DISTINCT: 'distinct';

//TODO: ADD A SPECIAL CHARACTER TO TEST THIS
fragment LETTER: ( [A-Za-z] | [\u0080-\u00FF] );
fragment ALPHANUMERIC: (LETTER | DECDIGIT);
IDENTIFIER: LETTER ( '_'ALPHANUMERIC | ALPHANUMERIC )*;

fragment DECDIGIT: [0-9];
fragment OCTDIGIT: [0-7];
fragment BINDIGIT: [0-1];
fragment HEXDIGIT: ( DECDIGIT | [a-fA-F] );

fragment HEX_LIT: '0' ('x' | 'X' ) HEXDIGIT ( ('_')? HEXDIGIT )*;
fragment BIN_LIT: '0' ('b' | 'B') BINDIGIT ( ('_')? BINDIGIT )*;
fragment OCT_LIT: '0' ('o' | 'O') OCTDIGIT ( ('_')? OCTDIGIT )*;
fragment DEC_LIT: DECDIGIT ( ('_')? DECDIGIT )*; 

INT_LIT: HEX_LIT | DEC_LIT | OCT_LIT | BIN_LIT;
fragment INT_SUFFIX: '\''? ('i' | 'I'); 
INT8_LIT: INT_LIT INT_SUFFIX '8';
INT16_LIT: INT_LIT INT_SUFFIX '16';
INT32_LIT: INT_LIT INT_SUFFIX '32';
INT64_LIT: INT_LIT INT_SUFFIX '64';

fragment UINT_SUFFIX: '\''? ('u' | 'U');
UINT_LIT: INT_LIT UINT_SUFFIX;
UINT8_LIT: UINT_LIT '8';
UINT16_LIT: UINT_LIT '16';
UINT32_LIT: UINT_LIT '32';
UINT64_LIT: UINT_LIT '64';

EXP: ('e' | 'E' ) ('+' | '-')? DEC_LIT;

FLOAT_LIT: DEC_LIT ( ( '.' DEC_LIT EXP? ) | EXP );

fragment FLOAT32_SUFFIX: ('f' | 'F') '32'?;
FLOAT32_LIT: ( ( HEX_LIT '\'' FLOAT32_SUFFIX )
            | ( ( FLOAT_LIT | DEC_LIT | OCT_LIT | BIN_LIT ) '\''? FLOAT32_SUFFIX ) );

fragment FLOAT64_SUFFIX: ( ( ('f' | 'F') '64' ) | 'd' | 'D' );
FLOAT64_LIT: ( HEX_LIT '\'' FLOAT64_SUFFIX
            | ( FLOAT_LIT | DEC_LIT | OCT_LIT | BIN_LIT ) '\''? FLOAT64_SUFFIX );

// TODO: could cause problems
fragment CARRIAGE_RETURN: ('\\r' | '\\c') ;
fragment ALERT: '\\a';
fragment BACKSPACE: '\\b';
fragment BACKSLASH: '\\';
fragment ESCAPE: '\\e';
fragment LINE_FEED: ( '\\n' | '\\l' ) ; 
fragment FORM_FEED: '\\f';
fragment TAB: ('\\t' | '\\v');
fragment ASCII_CODE_CHARACTER: '\\' DECDIGIT+ ;
fragment UNICODE_CODE_CHARACTER: '\\' 'u' HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT; 
fragment PLATFORM_SPECIFIC_NEWLINE: '\\p'; 
// UNICODE OF LF is x0A and of CR LF, xOD followed by xOA
// PLATFORM_SPECIFIC_NEWLINE: (\u000A|\u000D \u000A) -> skip;

fragment CHAR_ESCAPE_SEQUENCES: (
    CARRIAGE_RETURN 
    | ALERT 
    | BACKSLASH 
    | BACKSPACE 
    | ESCAPE 
    | LINE_FEED 
    | FORM_FEED 
    | TAB 
    | ASCII_CODE_CHARACTER
    | UNICODE_CODE_CHARACTER
    | ('\\x' HEXDIGIT HEXDIGIT)
    );

CHAR_LIT: '\'' CHAR_LIT_ITEM '\''; 
fragment CHAR_LIT_ITEM: ( CHAR_ESCAPE_SEQUENCES | [\u0020-\u0026] | [\u0028-\u00FF] );

STR_LIT: '"' STR_LIT_ITEM* '"'; //allow for empty string
fragment STR_LIT_ITEM: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u0021] | [\u0023-\u00FF] );

TRIPLESTR_LIT: '"""' QUOTED_TRIPLESTR_LIT_ITEM TRIPLESTR_LIT_ENDING;
fragment QUOTED_TRIPLESTR_LIT_ITEM: (('"' '"'? TRIPLESTR_LIT_ITEM) | TRIPLESTR_LIT_ITEM)* ('"' '"'?)?;
fragment TRIPLESTR_LIT_ITEM: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u0021] | [\u0023-\u00FF] | NEWLINE );
fragment TRIPLESTR_LIT_ENDING: '"""';

RSTR_LIT: RSTR_PREFIX ( '""' | '"' RAW_STR_LIT_BODY (RAW_STR_LIT_BODY | '""')* '"' );
fragment RAW_STR_LIT_BODY: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u0021] | [\u0023-\u00FF] );
fragment RSTR_PREFIX: ('r'|'R');

GENERALIZED_STR_LIT: IDENTIFIER ( '"' RAW_STR_LIT_BODY '"' | GENERALIZED_STR_LIT_LONG );
fragment GENERALIZED_STR_LIT_LONG: OPEN_PAREN RSTR_LIT CLOSE_PAREN;

GENERALIZED_TRIPLESTR_LIT: IDENTIFIER ( TRIPLESTR_LIT | GENERALIZED_TRIPLESTR_LIT_LONG);
fragment GENERALIZED_TRIPLESTR_LIT_LONG: OPEN_PAREN TRIPLESTR_LIT CLOSE_PAREN;

mode INDENTS_MODE;
    fragment SPACE_OR_TAB: WS | TAB;
    DEDENT: {self.canDedent() and self._input.LA(1) not in [ord(' '), ord('\t'), ord('\v')]}? {self.dedent()}-> popMode;
    EXIT: {self._input.LA(1) not in [ord(' '), ord('\t'), ord('\v')]}? -> popMode, skip;
    USELESS_LINE: SPACE_OR_TAB* (MULTILINE_COMMENT | DOCUMENTATION_COMMENT | COMMENT) (NEWLINE? | EOF) -> skip;
    USELSSS_INDENTS: SPACE_OR_TAB* NEWLINE -> skip;
    INDENT: {self.canMatch()}? WS WS WS WS {self.incrementIndents()};
    INDENTS_PASS: WS WS WS WS {self.incrementIndents()} -> skip;
    ERROR_INDENT:  {self.canMatch()}? SPACE_OR_TAB SPACE_OR_TAB? SPACE_OR_TAB?;