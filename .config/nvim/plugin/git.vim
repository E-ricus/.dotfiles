lua require('git')

let g:signify_sign_change            = '~'
" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

nmap <leader>g :G<CR>
nmap <leader>gg <cmd>Telescope git_status<cr>
nmap <leader>gb <cmd>Telescope git_branches<cr> 
nmap <leader>gd <cmd>DiffviewOpen<cr> 
nmap <leader>gc :Gcommit<CR>
nmap <leader>ga :Gcommit --amend<CR>
nmap <leader>dj :diffget //3<CR>
nmap <leader>df :diffget //2<CR>

" Jump though hunks
nmap <leader>gs :SignifyToggle<CR> 
nmap <leader>gh :SignifyToggleHighlight<CR> 
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

