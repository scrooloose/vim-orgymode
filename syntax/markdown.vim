syn match checkbox #- \[[ ]\] #he=e-1 contains=checkboxinner containedin=markdownCodeBlock
syn match checkboxinner #[ ]#
syn region todoNotDone start=#- \[[ ]\] # end=#\(\n\n\n\|^\ze.*- \[[X ]\]\)# contains=checkbox,markdownListMarker,markdownLinkText containedin=markdownCodeBlock
syn region todoDone start=#- \[[X]\] # end=#\(\n\n\n\|^\ze.*- \[[X ]\]\)# contains=checkbox containedin=markdownCodeBlock
syn match todoMeta #| \d\{2\}, \w\{3\}\( > \d\{2\}, \w\{3\}\)\?# conceal containedin=todoNotDone,todoDone
syn match todoCode #`[^`]\+`# containedin=todoNotDone

hi def link checkbox Directory
hi def link checkboxinner Statement
hi def link todoNotDone Normal
hi def link todoDone comment
hi def link todoMeta comment
hi def link todoCode string
hi def link markdownCode string
