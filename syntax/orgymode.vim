runtime! syntax/markdown.vim

syn match checkbox #\[[_]\] #he=e-1 contains=checkboxinner containedin=markdownCodeBlock
syn match checkboxinner #[_]#
syn region todoNotDone start=#\[[_]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox,markdownListMarker,markdownLinkText containedin=markdownCodeBlock
syn region todoDone start=#\[[X]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox containedin=markdownCodeBlock
syn match todoCreateDate #| \d\{2\}, \w\{3\}# conceal containedin=todoNotDone,todoDone

hi def link checkbox Directory
hi def link checkboxinner Statement
hi def link todoNotDone Normal
hi def link todoDone ignore
hi def link todoCreateDate ignore
