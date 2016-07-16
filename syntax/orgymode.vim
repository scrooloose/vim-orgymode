runtime! syntax/markdown.vim

syn match checkbox #\[[X_]\] #he=e-1 contains=checkboxinner containedin=markdownCodeBlock
syn match checkboxinner #[X_]#
syn region todoNotDone start=#\[[_]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox,markdownListMarker,markdownLinkText containedin=markdownCodeBlock
syn region todoDone start=#\[[X]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox containedin=markdownCodeBlock

hi def link checkbox Directory
hi def link checkboxinner Statement
hi def link todoNotDone Normal
hi def link todoDone ignore
