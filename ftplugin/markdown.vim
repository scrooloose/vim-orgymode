syntax sync minlines=50

nnoremap <Plug>OrgymodeCheckToggle :call OrgymodeCheckBox.ToggleCurrent()<cr>
if !hasmapto('<Plug>OrgymodeCheckToggle')
    nmap <buffer> <c-c> <Plug>OrgymodeCheckToggle
endif
