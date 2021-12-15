syntax enable
set ts=4 sw=4
set number

" Move vim keys to the home row
noremap ; l
noremap l k
noremap k j
noremap j h

" Adjust movement keys to compensate
noremap h ,
noremap , ;

" Remember last position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
