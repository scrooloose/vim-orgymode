syn match markdownCheckbox #- \[[ ]\] #he=e-1 contains=markdownCheckboxInner containedin=markdownCodeBlock
syn match markdownCheckboxInner #[ ]#
syn region markdownTodo start=#- \[[ ]\] # end=#\(\n\n\n\|^\ze.*- \[[X+ ]\]\|^\ze\S\)# contains=markdownCheckbox,markdownListMarker,markdownLinkText containedin=markdownCodeBlock
syn region markdownTodoDone start=#- \[[X]\] # end=#\(\n\n\n\|^\ze.*- \[[X+ ]\]\|^\ze\S\)# contains=markdownCheckbox containedin=markdownCodeBlock
syn region markdownTodoDoing start=#- \[[+]\] # end=#\(\n\n\n\|^\ze.*- \[[X+ ]\]\|^\ze\S\)# contains=markdownCheckbox containedin=markdownCodeBlock
syn match markdownTodoMeta #|\d\{2\},\w\{3\}\(:\d\{2\},\w\{3\}\)\?# conceal containedin=markdownTodo,markdownTodoDone
syn match markdownTodoCode #`[^`]\+`# containedin=markdownTodo

hi def link markdownCheckbox Directory
hi def link markdownCheckboxInner Statement
hi def link markdownTodo Normal
hi def link markdownTodoDone comment
hi def link markdownTodoDoing markdownBold
hi def link markdownTodoMeta comment
hi def link markdownTodoCode string
hi def link markdownCode string
