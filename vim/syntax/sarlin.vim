if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

syn match sarlinParameter "\<\h\w*\>" contained

syn match sarlinOperator "==\|!=\|>=\|<=\|[-+*/%=<>]"
syn match sarlinUserType "\<\u\w*\>"
syn match sarlinFunctionCall "\<\h\w*\ze\s*("
syn match sarlinBuiltin "\<\%(print\|write\|absolute\|minimum\|maximum\|round_up\|round_down\|round\|square_root\|power\|random_\%(u\=int\%(8\|16\|32\|64\)\|float\%(32\|64\)\|seed\)\)\ze\s*("
syn match sarlinMember "\.\@1<=\%(length\|is_empty\|contains\|add\|insert\|remove_at\|clear\|duplicate\|get\|remove\|keys\|values\|to_upper\|to_lower\|to_u\=int\%(8\|16\|32\|64\)\|to_float\%(32\|64\)\|trim\|replace\|split\|to_bytes\|to_text\|add_line\|reserve\|build\|read_bytes\|write_bytes\|starts_with\|ends_with\|new\|connect\|disconnect\|exists\|read\|write\|append_line\|append\|ensure\|size\|create\|list\|join\|name\|extension\|parent\|absolute\|countdown\|stopwatch\|get_local\|start\|pause\|resume\|stop\|restart\|wait\|remaining\|elapsed\|running\|paused\|finished\|parse\|stringify\)\>"
syn match sarlinNamespace "\<\%(file\|directory\|path\|JSON\|CSV\)\ze\s*\."

syn match sarlinNumber "\<\d\+\%(\.\d\+\)\=\>"
syn match sarlinHex "\<0x\x\+\>"
syn match sarlinDuration "\<\d\+\%(:\d\+\)\+\>"

syn keyword sarlinControl if else while for in break continue to return and or not emit run together
syn keyword sarlinDeclaration local var const class define as callable signal func take
syn match sarlinDeclaration "\<external\>"
syn keyword sarlinType int8 int16 int32 int64 uint8 uint16 uint32 uint64 float32 float64 bool string dictionary Time TextBuilder job
syn keyword sarlinBoolean true false
syn keyword sarlinNull null
syn keyword sarlinSelf self

syn match sarlinFunctionName "\%(\<\%(func\|signal\|emit\)\s\+\)\@<=\h\w*"
syn match sarlinTypeName "\%(\<\%(class\|define\)\s\+\)\@<=\h\w*"
syn match sarlinCallableName "\%(\<callable\s\+\)\@<=\h\w*"
syn match sarlinTypeName "\%(\<callable\s\+\)\@<=\h\w*\ze\s*("

syn match sarlinEscapeError "\\." contained
syn match sarlinEscape "\\[ntr\\\"]" contained
syn region sarlinString start=+"+ end=+"\|$+ oneline contains=sarlinEscape,sarlinEscapeError

syn match sarlinComment "#.*$" contains=sarlinTodo,@Spell
syn match sarlinDocComment "##.*$" contains=sarlinTodo,@Spell
syn match sarlinFileDoc "^\s*####.*$" contains=sarlinTodo,@Spell
syn region sarlinBlockComment start="^\s*###\s*$" end="^\s*###\s*$" fold contains=sarlinTodo,@Spell
syn keyword sarlinTodo TODO FIXME XXX NOTE contained


syn match sarlinExternalBadLang "\%(\<external\s\+\)\@<=\h\w*" contained
syn match sarlinExternalLang "\%(\<external\s\+\)\@<=\%(C\|Cpp\|Rust\)\>" contained

function! s:Embed(cluster, file) abort
  if empty(globpath(&runtimepath, 'syntax/' . a:file . '.vim'))
    return 0
  endif
  unlet! b:current_syntax
  execute 'syn include @' . a:cluster . ' syntax/' . a:file . '.vim'
  unlet! b:current_syntax
  return 1
endfunction

let s:head = 'contains=sarlinExternalBadLang,sarlinExternalLang,sarlinDeclaration,sarlinFunctionName,sarlinParameter,sarlinType'
execute 'syn match sarlinExternalHead "^\s*external\s\+\h\w*\s\+func\>.*$" ' . s:head
syn match sarlinExternalEnd "^\s*end\s\+external\s*$"
syn match sarlinExternalImport "^\s*external\s\+C\ze\s\+\"" contains=sarlinDeclaration,sarlinExternalLang

for [s:name, s:file] in [['C', 'c'], ['Cpp', 'cpp'], ['Rust', 'rust']]
  let s:body = !get(g:, 'sarlin_no_embedded', 0) && s:Embed('sarlin' . s:name, s:file) ? '@sarlin' . s:name : 'NONE'
  execute 'syn match sarlinExternalHead' . s:name . ' "^\s*external\s\+' . s:name . '\s\+func\>.*$" ' . s:head . ' nextgroup=sarlinExternalBody' . s:name . ' skipnl'
  execute 'syn region sarlinExternalBody' . s:name . ' start="^" end="^\ze\s*end\s\+external\s*$" contained keepend fold contains=' . s:body
endfor

syn sync fromstart

hi def link sarlinOperator Operator
hi def link sarlinUserType Type
hi def link sarlinFunctionCall Function
hi def link sarlinBuiltin Function
hi def link sarlinMember Function
hi def link sarlinNamespace Structure
hi def link sarlinNumber Number
hi def link sarlinHex Number
hi def link sarlinDuration Number
hi def link sarlinControl Statement
hi def link sarlinDeclaration Keyword
hi def link sarlinType Type
hi def link sarlinBoolean Boolean
hi def link sarlinNull Constant
hi def link sarlinSelf Identifier
hi def link sarlinFunctionName Function
hi def link sarlinTypeName Type
hi def link sarlinCallableName Identifier
hi def link sarlinEscape SpecialChar
hi def link sarlinEscapeError Error
hi def link sarlinString String
hi def link sarlinComment Comment
hi def link sarlinDocComment SpecialComment
hi def link sarlinFileDoc SpecialComment
hi def link sarlinBlockComment Comment
hi def link sarlinTodo Todo
hi def link sarlinExternalEnd Keyword
hi def link sarlinExternalLang Type
hi def link sarlinExternalBadLang Error
hi def link sarlinParameter Identifier

let b:current_syntax = 'sarlin'

let &cpo = s:cpo_save
unlet s:cpo_save
