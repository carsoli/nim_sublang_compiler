grammar milestone_1;

options {language='Python3';}

HASH: '#' -> skip;
NEWLINE: '\\r\\n' ->skip;
// a comment can be followed by another as part of its body
COMMENT_BODY: ( [\u0020-\u00FF] | TAB )* NEWLINE -> skip;
COMMENT: HASH COMMENT_BODY -> skip;

MULTILINE_COMMENT: HASH OPEN_BRACK (COMMENT_BODY+ | ( [\u0020-\u00FF] | TAB )*) CLOSE_BRACK HASH -> skip;
DOCUMENTATION_COMMENT: HASH MULTILINE_COMMENT HASH -> skip;
WS: ' ' -> skip;
INDENT: WS WS WS WS;

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
EQUALS_OPERATOR: ('='|'==');
MUL_OPERATOR: '*';
BITWISE_NOT_OPERATOR: '~';
NOT_OPERATOR: '!'; 

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
ELSE: 'else';
ELIF: 'elif';

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

DIGIT: [0-9] -> skip;
//TODO: ADD A SPECIAL CHARACTER TO TEST THIS
LETTER: ( [A-Za-z] | [\u0080-\u00FF] ) -> skip;
IDENTIFIER: LETTER+ ( '_'(LETTER | DIGIT) )*;

OCTDIGIT: [0-7] -> skip;
BINDIGIT: [0-1] -> skip;
HEXDIGIT: ( DIGIT | [a-f] ) -> skip;

HEX_LIT: '0' ('x' | 'X' ) HEXDIGIT ( ('_')? HEXDIGIT )* -> skip;
BIN_LIT: '0' ('b' | 'B') BINDIGIT ( ('_')? BINDIGIT )* -> skip;
OCT_LIT: '0' 'o' OCTDIGIT ( ('_')? OCTDIGIT )* -> skip;
DEC_LIT: DIGIT ( ('_')? DIGIT )* -> skip; 

INT_LIT: HEX_LIT | DEC_LIT | OCT_LIT | BIN_LIT;
INT_SUFFIX: '\'' ('i' | 'I') -> skip; 
INT8_LIT: INT_LIT INT_SUFFIX '8';
INT16_LIT: INT_LIT INT_SUFFIX '16';
INT32_LIT: INT_LIT INT_SUFFIX '32';
INT64_LIT: INT_LIT INT_SUFFIX '64';

UINT_SUFFIX: '\'' ('u' | 'U') -> skip;
UINT_LIT: INT_LIT UINT_SUFFIX;
UINT8_LIT: UINT_LIT '8';
UINT16_LIT: UINT_LIT '16';
UINT32_LIT: UINT_LIT '32';
UINT64_LIT: UINT16_LIT '64';

EXP: ('e' | 'E' ) ('+' | '-') DEC_LIT;

FLOAT_LIT: DEC_LIT ( ( '.' DEC_LIT EXP? ) | EXP );

FLOAT32_SUFFIX: ('f' | 'F') '32' -> skip;
FLOAT32_LIT: ( ( HEX_LIT '\'' FLOAT32_SUFFIX )
            | ( ( FLOAT_LIT | DEC_LIT | OCT_LIT | BIN_LIT ) '\'' FLOAT32_SUFFIX ) );

FLOAT64_SUFFIX: ( ( ('f' | 'F') '64' ) | 'd' | 'D' ) -> skip;
FLOAT64_LIT: ( HEX_LIT '\'' FLOAT64_SUFFIX
            | ( FLOAT_LIT | DEC_LIT | OCT_LIT | BIN_LIT ) '\'' FLOAT64_SUFFIX );

// TODO: could cause problems
QUOTATION_MARK: '"';
APOSTRAPHE: '\'';
CARRIAGE_RETURN: ('\\r' | '\\c');
ALERT: '\\a';
BACKSPACE: '\\b';
BACKSLASH: '\\';
ESCAPE: '\\e';
LINE_FEED: ( '\\n' | '\\l' );
FORM_FEED: '\\f';
TAB: ('\\t' | '\\v');
CODE_CHARACTER: '\\' DIGIT+;
PLATFORM_SPECIFIC_NEWLINE: '\\p'; 
// UNICODE OF LF is x0A and of CR LF, xOD followed by xOA
// PLATFORM_SPECIFIC_NEWLINE: (\u000A|\u000D \u000A) -> skip;

CHAR_ESCAPE_SEQUENCES: (
    CARRIAGE_RETURN 
    | QUOTATION_MARK 
    | APOSTRAPHE 
    | ALERT 
    | BACKSLASH 
    | BACKSPACE 
    | ESCAPE 
    | LINE_FEED 
    | FORM_FEED 
    | TAB 
    | CODE_CHARACTER
    | ('\\x' HEXDIGIT HEXDIGIT) 
    ) -> skip;

CHAR_LIT: '\'' CHAR_LIT_ITEM '\''; 
fragment CHAR_LIT_ITEM: ( CHAR_ESCAPE_SEQUENCES | [\u0020-\u00FF] );

STR_LIT: '"' STR_LIT_ITEM* '"'; //allow for empty string
fragment STR_LIT_ITEM: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u0021] | [\u0023-\u00FF] );

// TRIPLESTR_LIT: '"""' TRIPLESTR_LIT_ITEM '"""';
STR_LIT_ENDING: '"""' ~('"') -> skip;
TRIPLESTR_LIT: '"""' TRIPLESTR_LIT_ITEM STR_LIT_ENDING;
// [\u000A] //new line 
fragment TRIPLESTR_LIT_ITEM: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u00FF] | NEWLINE )*;

fragment RAW_STR_LIT_BODY: (CHAR_ESCAPE_SEQUENCES | PLATFORM_SPECIFIC_NEWLINE | [\u0020-\u0021] | [\u0023-\u00FF] );

RSTR_LIT: ('r'|'R') '"' ( RAW_STR_LIT_BODY?('""')?RAW_STR_LIT_BODY('""')? )* '"';

GENERALIZED_RSTR_LIT: IDENTIFIER OPEN_PAREN ('r'|'R') STR_LIT CLOSE_PAREN-> skip;
GENERALIZED_STR_LIT: IDENTIFIER STR_LIT;

GENERALIZED_RTRIPSTR_LIT: IDENTIFIER  ('r'|'R') OPEN_PAREN TRIPLESTR_LIT CLOSE_PAREN-> skip;
GENERALIZED_TRIPLESTR_LIT: IDENTIFIER '""' STR_LIT '""';

start: AND;
