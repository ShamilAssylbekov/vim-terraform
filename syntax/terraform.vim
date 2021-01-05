" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Identifiers are made up of alphanumeric characters, underscores, and
" hyphens.
if has('patch-7.4.1142')
    syn iskeyword a-z,A-Z,48-57,_,-
endif

syn case match

" A block is introduced by a type, some number of labels - which are either
" strings or identifiers - and an opening curly brace.  Match the type.
syn match terraBlockIntroduction /^\s*\zs\K\k*\ze\s\+\(\("\K\k*"\|\K\k*\)\s\+\)*{/ contains=terraBlockType
syn keyword terraBlockType contained data locals module output provider resource terraform variable statement lifecycle_rule principals condition transition required_providers ports

syn keyword terraValueBool true false on off yes no

syn keyword terraTodo         contained TODO FIXME XXX BUG TF-UPGRADE-TODO
syn region  terraComment      start="/\*" end="\*/" contains=terraTodo,@Spell
syn region  terraComment      start="#" end="$" contains=terraTodo,@Spell
syn region  terraComment      start="//" end="$" contains=terraTodo,@Spell

""" misc.
syn match terraValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match terraValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match terraBraces        "[\[\]]"

""" skip \" and \\ in strings.
syn region terraValueString   start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=terraStringInterp
syn region terraStringInterp  matchgroup=terraBraces start=/\${/ end=/}/ contained contains=ALL
"syn region terraStringInterp  matchgroup=terraBraces start=/\${/ end=/}/ contained contains=ALLBUT,terraMod
syn region terraHereDocText   start=/<<-\?\z([a-z0-9A-Z]\+\)/ end=/^\s*\z1/ contains=terraStringInterp

"" Functions.
syn match terraFunction "[a-z0-9]\+(\@="

"" Identifier
syn match terraType2 "\v\s{-}\zs\w+\ze\s{-}\=(\=)@!"
syn match terraVar   "\v\s{-}\zsvar\ze\.\w+"

""" HCL2
syn keyword terraRepeat         for in
syn keyword terraConditional    if
syn keyword terraType           string bool number object tuple list map set any
syn keyword terraValueNull      null

""" Docker, etc.
"syn keyword terraType		docker source

" enable block folding
syn region terraBlockBody matchgroup=terraBraces start="{" end="}" fold transparent

syn match terraMod   "\v\{\zsmodule\ze\.\w+"
syn match terraMod   "\v\s{-}\zsmodule\ze\.\w+"

syn match terraData "\v\s{-}\zsdata\ze\.\w+"

hi def link terraComment           Comment
hi def link terraTodo              Todo
hi def link terraBraces            Delimiter
hi def link terraBlockType         Statement
hi def link terraType2             Type
hi def link terraVar               Identifier
hi def link terraValueBool         Boolean
hi def link terraValueDec          Number
hi def link terraValueHexaDec      Number
hi def link terraValueString       String
hi def link terraHereDocText       String
hi def link terraFunction          Function
hi def link terraRepeat            Repeat
hi def link terraConditional       Conditional
hi def link terraType              Type
hi def link terraValueNull         Constant
hi def link terraMod               Identifier
hi def link terraData               Identifier

let b:current_syntax = 'terraform'

let &cpo = s:cpo_save
unlet s:cpo_save
