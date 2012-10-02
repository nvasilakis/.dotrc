" Vim syntax file
" By Robin Morisset.
" Inspired by the Haskell syntax file by John Williams
" (and others, look at haskell.vim)

" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" (Qualified) identifiers (no default highlighting)
syn match brConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match brVarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match brVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match brConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match brVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match brConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols--cannot be overloaded.
syn match   brDelimiter  "\[\|\]\|(\|)\|,\|;\|_\|{\|}"

" Strings and constants
syn match   brSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   brSpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   brSpecialCharError	contained "\\&\|'''\+"
syn region  brString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match   brCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match   brCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
syn match   brNumber		"\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match   brFloat		"\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match   brConstant		"()"
syn keyword brConstant		true false

syn keyword brInclude		import open include
syn keyword brConditional	if then else case of
syn keyword brOperator		nav value label error external to classify declassify as
syn keyword brStructure		fun rec local let module interface tests implementation datatype
syn keyword brStatement		setAuth raiseAuth lowerAuth test

" Comments
syn match   brLineComment      "///*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
syn region  brBlockComment     start="/\*"  end="\*/" contains=brBlockComment

hi def link brConSym		    Operator
hi def link brVarSym		    Operator
hi def link brDelimiter		    Delimiter
hi def link brSpecialChar	    SpecialChar
hi def link brSpecialCharError	    Error
hi def link brString		    String
hi def link brCharacter		    Character
hi def link brNumber		    Number
hi def link brFloat		    Float
hi def link brConstant		    Constant
hi def link brInclude		    Include
hi def link brConditional	    Conditional
hi def link brOperator		    Operator
hi def link brStructure		    Structure
hi def link brStatement		    Statement
hi def link brLineComment	    Comment
hi def link brBlockComment	    Comment

let b:current_syntax = "breeze"

" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim
