" Vim syntax file
" Language: FML
" Maintainer: Justin Pombrio (jpombrio@commure.com)

" To use:
" - Put this file in ~/.vim/syntax/fml.vim
" - Add this line to `.vimrc`: au BufRead,BufNewFile *.map set filetype=fml

syn match delimiter '('
syn match delimiter ')'
syn match delimiter '\['
syn match delimiter '\]'
syn match delimiter '{'
syn match delimiter '}'
syn match delimiter ':'
syn match delimiter ','
syn match delimiter '+'
syn match delimiter '-'
syn match delimiter '*'
syn match delimiter '/'
syn match delimiter '&'
syn match delimiter '='
syn match delimiter '!='
syn match delimiter '->'
syn match delimiter '<='
syn match delimiter '>='
syn match delimiter '<'
syn match delimiter '>'
syn match delimiter '\.'
syn match delimiter ';'

syn keyword basic map uses alias imports group extends default where check log then
syn keyword basic true false types type first not_first last not_last only_one share
syn keyword basic collate source target queried produced conceptMap prefix
syn keyword basic for input output endgroup make as this
syn keyword basic create copy truncate escape cast append translate reference dateOp
syn keyword basic uuid pointer evaluate cc c qty id cp

syn keyword op push new let set call abort

syn match number "[0-9]+"

syn match comment '//.*$'

syntax region string start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region string start=/\v'/ skip=/\v\\./ end=/\v'/

hi def link string Constant
hi def link comment Comment
hi def link delimeter PreProc
hi def link basic Function
hi def link op Type
