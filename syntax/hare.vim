" Vim syntax file
" Language: Hare

if exists("b:current_syntax")
  finish
endif

syn keyword hareKeyword let const fn def return static export continue break
syn keyword hareRepeat for while
syn keyword hareConditional if else match switch
syn keyword hareBuiltin len offset free alloc assert
" TODO: highlight size correctly both as keyword and type
syn match harePreProc "^use .*;"
syn match harePreProc "@[a-z]*"
syn match hareOperator "\.\.\." "\.\."

syn region hareString start=+\z(["']\)+ end=+\z1+ skip=+\\\\\|\\\z1+

"adapted from c.vim
"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match	hareNumbers	display transparent "\<\d\|\.\d" contains=hareNumber,hareFloat,hareOctalError,hareOctal
" Same, but without octal error (for comments)
syn match	hareNumbersCom	display contained transparent "\<\d\|\.\d" contains=hareNumber,hareFloat,hareOctal
syn match	hareNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match	hareNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match	hareOctal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=hareOctalZero
syn match	hareOctalZero	display contained "\<0"
syn match	hareFloat		display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match	hareFloat		display contained "\d\+\.\d+\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match	hareFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match	hareFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"

syn keyword hareTodo contained TODO FIXME XXX
syn region hareComment start="/\*" end="\*/" contains=hareTodo

syn keyword hareType u8 u16 u32 u64 i8 i16 i32 i64
syn keyword hareType uint int
syn keyword hareType uintptr
syn keyword hareType size
syn keyword hareType f32 f64
syn keyword hareType bool
syn keyword hareType char str
syn keyword hareType void
syn keyword hareType struct union
syn keyword hareType nullable
syn keyword hareNull null
syn keyword hareBoolean true false

hi def link hareBoolean Boolean
hi def link hareComment Comment
hi def link hareConditional Conditional
hi def link hareFloat Number
hi def link hareKeyword Keyword
hi def link hareNumber Number
hi def link hareNull Constant
hi def link hareOctal Number
hi def link hareOperator Operator
hi def link harePreProc PreProc
hi def link hareRepeat Repeat
hi def link hareString String
hi def link hareTodo Todo
hi def link hareType Type
hi def link hareBuiltin Function
