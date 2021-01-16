" Vim syntax file
" Language: Fhirpath

" To use:
" - Put this file in ~/.vim/syntax/fhirpath.vim
" - It will be loaded by fmlpp.vim

if exists("b:current_syntax")
    finish
endif

" Variables
syn match fhirpathVar "$this"
syn match fhirpathVar "$total"
syn match fhirpathVar "%\w\+"

" Operators
syn match fhirpathOperator display "\%(+\|-\|/\|*\|=\|>\|<\|&\|!\|\~\||\)=\?"
syn keyword fhirpathOperator or xor and implies div mod is as in
" contains is both an operator and a function, but we only want to highlight the
" operator.
syn match fhirpathOperator "\%(\s\|\_^\)\<contains\>"

" Literals
syn keyword fhirpathBool true false
syn match fhirpathNumber display "\<[0-9]\+\(\.[0-9]\+\)\?\>"
syn region fhirpathString start=+'+ end=+'+
" TODO: date, time, and quantity literals.

" Highlighting
hi def link fhirpathVar Constant
hi def link fhirpathOperator Operator
hi def link fhirpathBool Boolean
hi def link fhirpathNumber Number
hi def link fhirpathString String
