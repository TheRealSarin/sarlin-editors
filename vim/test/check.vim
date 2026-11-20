set nocompatible
let s:root = fnamemodify(expand('<sfile>:p'), ':h:h')
execute 'set runtimepath^=' . fnameescape(s:root)
filetype plugin indent on
set expandtab shiftwidth=4
syntax enable
let s:failures = []

function! s:Expect(line, column, group) abort
  let actual = synIDattr(synID(a:line, a:column, 1), 'name')
  if actual !=# a:group
    call add(s:failures, printf('%d:%d expected %s, got %s', a:line, a:column, a:group, actual))
  endif
endfunction

execute 'edit ' . fnameescape(s:root . '/test/sample.sar')
if &filetype !=# 'sarlin'
  call add(s:failures, 'filetype is ' . &filetype)
endif
call s:Expect(1, 1, 'sarlinFileDoc')
call s:Expect(2, 1, 'sarlinDeclaration')
call s:Expect(2, 10, 'sarlinExternalLang')
call s:Expect(2, 17, 'sarlinFunctionName')
call s:Expect(2, 29, 'sarlinType')
call s:Expect(3, 5, 'cStatement')
call s:Expect(4, 1, 'sarlinExternalEnd')
call s:Expect(6, 10, 'sarlinExternalLang')
call s:Expect(10, 10, 'sarlinExternalBadLang')
call s:Expect(14, 1, 'sarlinBlockComment')
call s:Expect(17, 1, 'sarlinDocComment')
call s:Expect(18, 1, 'sarlinDeclaration')
call s:Expect(18, 7, 'sarlinTypeName')
call s:Expect(19, 19, 'sarlinHex')
call s:Expect(22, 10, 'sarlinTypeName')
call s:Expect(25, 25, 'sarlinEscape')
call s:Expect(25, 28, 'sarlinEscapeError')
call s:Expect(26, 25, 'sarlinDuration')
call s:Expect(27, 5, 'sarlinControl')
call s:Expect(27, 8, 'sarlinBoolean')
call s:Expect(28, 9, 'sarlinBuiltin')
call s:Expect(28, 15, 'sarlinNamespace')
call s:Expect(28, 20, 'sarlinMember')
call s:Expect(30, 14, 'sarlinFunctionName')
call s:Expect(11, 1, 'sarlinExternalEnd')
call s:Expect(7, 5, 'sarlinExternalBodyRust')
call s:Expect(8, 1, 'sarlinExternalEnd')

normal! gg=G
let s:expected = readfile(s:root . '/test/sample.sar')
if getline(1, '$') !=# s:expected
  call add(s:failures, 'reindenting changed the sample')
endif

if empty(s:failures)
  qall!
endif
call writefile(s:failures, '/dev/stderr')
cquit!
