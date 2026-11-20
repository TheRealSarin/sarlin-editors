if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetSarlinIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,=end

let b:undo_indent = 'setlocal autoindent< indentexpr< indentkeys<'

if exists('*GetSarlinIndent')
  finish
endif

function! GetSarlinIndent() abort
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif
  let previous = substitute(getline(lnum), '^\s*#.*$\|\s\+#[^"]*$', '', '')
  let amount = indent(lnum)
  if previous =~# '[{[(]\s*$' || previous =~# '^\s*external\s\+\w\+\s\+func\>'
    let amount += shiftwidth()
  endif
  if getline(v:lnum) =~# '^\s*\%([})\]]\|end\s\+external\>\)'
    let amount -= shiftwidth()
  endif
  return max([amount, 0])
endfunction
