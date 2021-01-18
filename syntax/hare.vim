" Vim syntax file
" Language: Hare

if exists("b:current_syntax")
  finish
endif

syn keyword hareKeyword let const fn def type static export defer
syn keyword hareBranch for return break continue
syn keyword hareConditional if else match switch
syn keyword hareBuiltin len offset free alloc assert append abort
syn keyword hareOperator is as
" TODO: highlight size correctly both as keyword and type
syn match harePreProc "^use .*;"
syn match harePreProc "@[a-z]*"
syn match hareOperator "\.\.\." "\.\."

syn region hareString start=+\z(["']\)+ end=+\z1+ skip=+\\\\\|\\\z1+

"adapted from c.vim
"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match	hareNumbers	display transparent "\<\d" contains=hareNumber,hareOctalError,hareOctal
" Same, but without octal error (for comments)
syn match	hareNumbersCom	display contained transparent "\<\d\|\.\d" contains=hareNumber,hareFloat,hareOctal
syn match	hareNumber		display contained "\d\+\([ziu]\d*\)\?\>"
"hex number
syn match	hareNumber		display contained "0x\x\+\([ziu]\d*\)\?\>"
" Flag the first zero of an octal number as something special
syn match	hareOctal		display contained "0\o\+\([ziu]\d*\)\?\>" contains=hareOctalZero
syn match	hareOctalZero	display contained "\<0"
syn match	hareFloat		display contained "\d\+\(f32\|f64\)"
"floating point number, with dot, optional exponent
syn match	hareFloat		display contained "\d\+\.\d+\(e[-+]\=\d\+\)\=\(f32\|f64\)\="
"floating point number, starting with a dot, optional exponent
syn match	hareFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=\(f32\|f64\)\=\>"
"floating point number, without dot, with exponent
syn match	hareFloat		display contained "\d\+e[-+]\=\d\+\(f32\|f64\)\=\>"

syn keyword hareTodo contained TODO FIXME XXX
syn region hareComment start="//" end="$" contains=hareTodo,@Spell

syn keyword hareType u8 u16 u32 u64 i8 i16 i32 i64
syn keyword hareType uint int
syn keyword hareType uintptr
syn keyword hareType size
syn keyword hareType f32 f64
syn keyword hareType bool
syn keyword hareType char str
syn keyword hareType void
syn keyword hareType struct union
syn keyword hareType enum
syn keyword hareType nullable
syn keyword hareType rune
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
hi def link hareBranch Repeat
hi def link hareString String
hi def link hareTodo Todo
hi def link hareType Type
hi def link hareBuiltin Function
