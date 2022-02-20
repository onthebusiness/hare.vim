" Vim indent file
" Language: Hare

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

if !has("cindent") || !has("eval")
  finish
endif

setlocal cindent
setlocal tabstop=8 shiftwidth=8 noexpandtab

" L0 -> don't deindent labels
" :0 -> don't indent cases
" (s -> use one indent after a trailing (
" m1 -> if ) starts a line, indent it the same as its matching (
" ks -> add an extra indent to extra lines in an if expression or for expression
" j1 -> indent code inside {} one level when in parentheses
" J1 -> see j1
" *0 -> don't search for unclosed block comments
" #1 -> don't deindent lines that begin with #
setlocal cinoptions=L0,:0,(s,m1,ks,j1,J1,*0,#1

" Controls which keys reindent the current line.
" 0{     -> { at beginning of line
" 0}     -> } at beginning of line
" 0)     -> ) at beginning of line
" !^F    -> <C-f> (not inserted)
" o      -> <CR> or `o` command
" O      -> `O` command
" e      -> else
" 0=case -> case
setlocal indentkeys=0{,0},0),!^F,o,O,e,0=case

setlocal cinwords=if,else,for,switch,match

setlocal indentexpr=GetHareIndent()

function! FloorCindent(lnum)
  return cindent(a:lnum) / shiftwidth() * shiftwidth()
endfunction

function! GetHareIndent()
  let line = getline(v:lnum)
  let prevlnum = prevnonblank(v:lnum - 1)
  let prevline = getline(prevlnum)
  let prevprevline = getline(prevnonblank(prevlnum - 1))

  " This is all very hacky and imperfect, but it's tough to do much better when
  " working with regex-based indenting rules.

  " TODO: The following edge-case is still indented incorrectly:
  " case =>
  "         if (foo) {
  "                 bar;
  "         };
  " | // cursor is incorrectly deindented by one shiftwidth.
  "
  " This only happens if the {} block is the first statement in the case body.
  " If `case` is typed, the case will also be incorrectly deindented by one
  " shiftwidth. Are you having fun yet?

  " Deindent cases.
  if line =~# '\v^\s*case'
    " If the previous line was also a case, don't do any special indenting.
    if prevline =~# '\v^\s*case'
      return indent(v:lnum)
    end

    " If the previous line started a block, deindent by one shiftwidth.
    " This handles the first case in a switch/match block.
    if prevline =~# '\v\{\s*(//.*)?$'
      return FloorCindent(v:lnum) - shiftwidth()
    end

    " If the previous line ended in a semicolon and the line before that wasn't
    " a case, deindent by one shiftwidth.
    if prevline =~# '\v;\s*(//.*)?$' && prevprevline !~# '\v\=\>\s*(//.*)?$'
      return FloorCindent(v:lnum) - shiftwidth()
    end

    " Otherwise, do a normal cindent.
    return FloorCindent(v:lnum)
  endif

  " Indent the body of a case.
  " If the previous line ended in a semicolon and the line before that was a
  " case, don't do any special indenting.
  if prevline =~# '\v;\s*(//.*)?$' && prevprevline =~# '\v\=\>\s*(//.*)?$'
    return indent(v:lnum)
  endif

  " If everything above is false, do a normal cindent.
  return FloorCindent(v:lnum)
endfunction

" vim: tabstop=2 shiftwidth=2 expandtab
