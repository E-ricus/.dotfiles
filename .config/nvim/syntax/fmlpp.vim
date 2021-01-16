" Vim syntax file
" Language: FML++

" To use:
" - Put this file in ~/.vim/syntax/fmlpp.vim
" - Add this line to `.vimrc`: au BufRead,BufNewFile *.fmlpp set filetype=fmlpp

syn include @fhirpath syntax/fhirpath.vim

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword fmlppImport uses
syn keyword fmlppImport imports

syn keyword fmlppKeyword map
syn keyword fmlppKeyword group
syn keyword fmlppKeyword rule
syn keyword fmlppKeyword alias
syn keyword fmlppKeyword returns
syn keyword fmlppKeyword extends

syn keyword fmlppMode source target

syn keyword fmlppStatement let
syn keyword fmlppStatement set
syn keyword fmlppStatement push
syn keyword fmlppStatement mutate
syn keyword fmlppStatement call
syn keyword fmlppStatement log
syn keyword fmlppStatement with

" This is added by map2fmlpp and needs to be manually fixed, so draw attention
" to it.
syn keyword fmlppError set_or_push

syn keyword fmlppFlow if
syn keyword fmlppFlow else
syn keyword fmlppFlow where
syn keyword fmlppFlow rn

syn keyword fmlppLoop for

syn keyword fmlppException check
syn keyword fmlppException abort

" Operators
syn match fmlppAssignment display "="
syn keyword fmlppAssignment as

" Literals
syn match fmlppNumber display "\<[0-9]\+\(\.[0-9]\+\)\?\>"
syn keyword fmlppBool true false
syn region fmlppString start=+"+ end=+"+
syn region fmlppSingleString start=+'+ end=+'+

" Regions
syn region fmlppComment start="//" end="$"
" Highlight the backticks around fhirpath, and highlight the expression itself
" as fhirpath.
syn region fmlppFhirpath matchgroup=fmlppFhirpathBacktick contains=@fhirpath start=+`+ end=+`+

" Highlighting
hi def link fmlppImport Include
hi def link fmlppKeyword Keyword
hi def link fmlppStatement Statement
hi def link fmlppError Error
hi def link fmlppMode StorageClass
hi def link fmlppFlow Conditional
hi def link fmlppLoop Repeat
hi def link fmlppException Exception
hi def link fmlppAssignment Operator
hi def link fmlppNumber Number
hi def link fmlppBool Boolean
hi def link fmlppFhirpathBacktick Delimiter
hi def link fmlppString String
hi def link fmlppSingleString String
hi def link fmlppComment Comment
