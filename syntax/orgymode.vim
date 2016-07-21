runtime! syntax/markdown.vim

syn match checkbox #\[[_]\] #he=e-1 contains=checkboxinner containedin=markdownCodeBlock
syn match checkboxinner #[_]#
syn region todoNotDone start=#\[[_]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox,markdownListMarker,markdownLinkText containedin=markdownCodeBlock
syn region todoDone start=#\[[X]\] # end=#\(^\s*$\|^\ze.*\[[X_]\]\)# contains=checkbox containedin=markdownCodeBlock
syn match todoMeta #| \d\{2\}, \w\{3\}\( > \d\{2\}, \w\{3\}\)\?# conceal containedin=todoNotDone,todoDone
syn match todoCode #`[^`]\+`# containedin=todoNotDone

hi def link checkbox Directory
hi def link checkboxinner Statement
hi def link todoNotDone Normal
hi def link todoDone comment
hi def link todoMeta comment
hi def link todoCode string
hi def link markdownCode string
