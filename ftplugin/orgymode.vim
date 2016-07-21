runtime! ftplugin/markdown.vim

nnoremap <buffer> <c-c> :call g:CheckBox.ToggleCurrent()<cr>
inoremap <buffer> <c-c> <space><backspace><c-o>:call g:CheckBox.NewOnCurLine()<cr>

setl sw=4 sts=4 et
syntax sync minlines=50
setl conceallevel=2
setl foldmethod=expr foldexpr=MarkdownFold()
setl spell

UltiSnipsAddFiletypes markdown
