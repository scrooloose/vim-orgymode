nnoremap <buffer> <c-c> :call g:CheckBox.ToggleCurrent()<cr>

setl sw=4 sts=4 et
syntax sync minlines=50
setl conceallevel=2
setl foldmethod=expr foldexpr=MarkdownFold()
setl spell

if exists("g:loaded_orgymode_ftplugin")
    finish
endif
let g:loaded_orgymode_ftplugin = 1

"tell markdown ftplugin to enable its magic folding
let g:markdown_folding=1

command! -nargs=0 OrgyToggle call <sid>toggleOrgy()
function! s:toggleOrgy() abort
    let winnr = bufwinnr("Orgyfile.md")
    if winnr > 0
        exec winnr . "wincmd c"
    else
        botright 78vs Orgyfile.md
        setl wfw
        setl nonu

        "hack to make nerdtree et al not split the window
        setl previewwindow

        "for some reason this doesnt get run automatically and the cursor
        "position doesn't get set
        doautocmd bufreadpost %
    endif
endfunction

let s:CheckBox = {}
let g:CheckBox = s:CheckBox

function! s:CheckBox.New(args)
    let newObj = copy(self)
    let newObj.content = a:args['content']
    let newObj.lnum = a:args['lnum']
    let newObj.indent = a:args['indent']
    let newObj.checked = a:args['checked']
    return newObj
endfunction

function! s:CheckBox.ToggleCurrent() abort
    let check = s:CheckBox.FromLine(line("."))
    if empty(check)
        return
    endif

    let oldpos = getpos(".")
    call check.toggle()
    keepjumps call setpos(".", oldpos)
endfunction

function! s:CheckBox.toggle() abort
    if !self.checked
        call self.check()
    else
        call self.uncheck()
    endif
endfunction

function! s:CheckBox.check() abort
    exec self.lnum . 's/- \[ \]/- [X]/e'
    exec self.lnum . 's/- \[X\].* | \d\{2}, \w\{3}\zs.*/ > ' . strftime("%d, %b") . '/e'

    if self.allSiblingsChecked()
        let p = self.parent()
        if !empty(p)
            call p.check()
        endif
    endif
endfunction

function! s:CheckBox.uncheck() abort
    exec self.lnum . 's/- \[X\]/- [ ]/e'
    let p = self.parent()
    if !empty(p)
        call p.uncheck()
    endif
endfunction

function! s:CheckBox.FromLine(lnum) abort
    let lnum = a:lnum
    let l = getline(lnum)
    let startIndent = s:CheckBox.IndentFor(l)

    "if we have a checkbox of the form
    "
    "[ ] top line
    "    more text in same box
    "    yet more
    "
    "then go up till we find the actual check line
    while 1
        let curIndent = s:CheckBox.IndentFor(l)

        let lineContainsCheck = l =~ '^\s*- \[[ X]\] '

        if lineContainsCheck
            if startIndent != 0 && startIndent <= curIndent && lnum != a:lnum
                echo startIndent curIndent a:lnum
                throw "FuckedFormattingError Obey the indent rules bitch"
            endif

            break
        endif

        "if on a line of non indented text, it cant be part of a todo
        if !lineContainsCheck && curIndent == 0 && !empty(l)
            return {}
        endif

        let lnum  = lnum - 1
        let l = getline(lnum)

        if lnum <= 0
            return {}
        endif

    endwhile

    return s:CheckBox.New({
        \ 'checked': l =~ '^\s*- \[X\] ',
        \ 'indent': s:CheckBox.IndentFor(l),
        \ 'lnum': lnum,
        \ 'content': substitute(getline(lnum),  '^\s*- \[[X ]\] ', '', '')})
endfunction

function! s:CheckBox.IndentFor(s) abort
    return (match(a:s, '\S') + 1) / 4
endfunction

function! s:CheckBox.siblings() abort
    let siblings = []

    for direction in [-1, 1]
        let curLine = line(".") + direction
        let curCheck = s:CheckBox.FromLine(curLine)

        let twoEmptyLines = empty(getline(curLine)) && empty(getline(curLine + direction))

        while !empty(curCheck) && !twoEmptyLines
            if curLine < 1 || curLine > line("$")
                break
            endif

            if !empty(getline(curLine))
                if curCheck.indent < self.indent
                    break
                endif

                "check for dups since a checkbox can have many lines of text
                if curCheck.indent == self.indent && index(siblings, curCheck) == -1
                    call add(siblings, curCheck)
                endif
            endif

            let curLine = curLine + direction
            let curCheck = s:CheckBox.FromLine(curLine)
        endwhile
    endfor

    return uniq(siblings)
endfunction

function! s:CheckBox.allSiblingsChecked() abort
    for s in self.siblings()
        if !s.checked
            return 0
        endif
    endfor

    return 1
endfunction

function! s:CheckBox.parent() abort
    let curLine = self.lnum - 1
    let curCheck = s:CheckBox.FromLine(curLine)

    while !empty(curCheck) || empty(getline(curLine))

        if !empty(getline(curLine))
            if curCheck.indent == self.indent - 1
                return curCheck
            endif
        else
            if curLine < 1 || curLine > line("$")
                break
            endif
        endif


        let curLine = curLine - 1
        let curCheck = s:CheckBox.FromLine(curLine)
    endwhile
endfunction
