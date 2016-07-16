if exists("b:loaded_orgymode_ftplugin")
    finish
endif
let b:loaded_orgymode_ftplugin = 1

runtime! ftplugin/markdown.vim

nnoremap <buffer> <c-c> :call g:CheckBox.ToggleCurrent()<cr>
inoremap <buffer> <c-c> <space><backspace><c-o>:call g:CheckBox.NewOnCurLine()<cr>

setl sw=4 sts=4 et
syntax sync minlines=50
set conceallevel=2
