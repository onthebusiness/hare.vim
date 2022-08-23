" Vim syntax file
" Language: Hare

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword hareConditional if else match switch
syn keyword hareKeyword break continue return yield
syn keyword hareKeyword defer
syn keyword hareKeyword fn
syn keyword hareKeyword let
syn keyword hareLabel case
syn keyword hareOperator as is
syn keyword hareRepeat for
syn keyword hareStorageClass const def export nullable static
syn keyword hareStructure enum struct union
syn keyword hareTypedef type

" C ABI.
syn keyword hareKeyword vastart vaarg vaend

syn keyword hareBuiltin len offset free alloc assert append abort delete insert
syn match hareType "\v<size>((\_s|//.*\n)*\()@!"
syn match hareBuiltin "\v<size>((\_s|//.*\n)*\()@="
syn match harePreProc "^use .*;"
syn match harePreProc "@[a-z]*"
syn match hareOperator "\.\.\." "\.\."
syn match hareErrorAssertion "\v(^([^/]|//@!)*\)\_s*)@<=!\=@!"
syn match hareEscape "\\[\\\'\"0abfnrtv]" contained
syn match hareEscapeRaw "\\[\\0abfnrtv]" contained
syn match hareQuestionMark "?"

syn region hareString start=+\z(["']\)+ end=+\z1+ skip=+\\\\\|\\\z1+ contains=hareEscape
syn region hareString start=+`+ end=+`+ contains=hareEscapeRaw

" Number literals.
syn match hareNumber "\v(\.@1<!|\.\.)\zs<\d+([Ee][+-]?\d+)?(z|[iu](8|16|32|64)?)?>" display
syn match hareNumber "\v(\.@1<!|\.\.)\zs<0b[01]+(z|[iu](8|16|32|64)?)?>" display
syn match hareNumber "\v(\.@1<!|\.\.)\zs<0o\o+(z|[iu](8|16|32|64)?)?>" display
syn match hareNumber "\v(\.@1<!|\.\.)\zs<0x\x+(z|[iu](8|16|32|64)?)?>" display

" Floating-point number literals.
syn match hareFloat "\v<\d+\.\d+([Ee][+-]?\d+)?(f32|f64)?>" display
syn match hareFloat "\v<\d+([Ee][+-]?\d+)?(f32|f64)>" display

syn match	hareSpaceError		display excludenl "\v\s+$"
syn match	hareSpaceError		display "\v +\t"me=e-1

syn keyword hareTodo contained TODO FIXME XXX
syn region hareComment start="//" end="$" contains=hareTodo,@Spell

syn keyword hareType u8 u16 u32 u64 i8 i16 i32 i64
syn keyword hareType uint int
syn keyword hareType uintptr
syn keyword hareType f32 f64
syn keyword hareType bool
syn keyword hareType char str
syn keyword hareType void
syn keyword hareType rune
syn keyword hareType valist
syn keyword hareNull null
syn keyword hareBoolean true false

hi def link hareBoolean Boolean
hi def link hareBuiltin Function
hi def link hareComment Comment
hi def link hareConditional Conditional
hi def link hareFloat Float
hi def link hareKeyword Keyword
hi def link hareLabel Label
hi def link hareNull Constant
hi def link hareNumber Number
hi def link hareOperator Operator
hi def link harePreProc PreProc
hi def link hareQuestionMark Special
hi def link hareRepeat Repeat
hi def link hareEscape SpecialChar
hi def link hareEscapeRaw hareEscape
hi def link hareStorageClass StorageClass
hi def link hareString String
hi def link hareStructure Structure
hi def link hareTodo Todo
hi def link hareType Type
hi def link hareTypedef Typedef

hi def link hareSpaceError Error
autocmd InsertEnter * hi link hareSpaceError NONE
autocmd InsertLeave * hi link hareSpaceError Error

hi def hareErrorAssertion ctermfg=red cterm=bold guifg=red gui=bold

let b:current_syntax = "hare"

" vim: tabstop=8 shiftwidth=2 expandtab
