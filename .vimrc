set encoding=utf-8
set hidden
set cmdheight=2

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'LnL7/vim-nix'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --fronzen-lockfile'}
call plug#end()

filetype plugin indent on
syntax on

set ts=4
set sts=4
set sw=4

set expandtab

inoremap {<cr> {<cr>}<c-o>O

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

tnoremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l
tnoremap <c-h> <c-w>h

inoremap <c-u> <esc>viwUA

"nnoremap <c-n> :NERDTreeToggle<cr>
"""""

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n> :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                            \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

"""""

nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute( 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction()


nmap <leader>rn <Plug>(coc-rename)

" Mappings for CocList
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent><nowait> <space>j :<C-u>CocNext<cr>
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<cr>
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<cr>
