" include with
" source /home/asherman/scripts/gvimrc
"
" make the font big
set guifont=Monospace\ 14

" make gvimdiff look less like 1993
if &diff
    colorscheme ron
endif

" https://unix.stackexchange.com/questions/111558/how-can-i-constantly-see-the-current-filename-in-vim
set laststatus=2
