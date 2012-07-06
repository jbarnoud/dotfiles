" Toggle showmarks and set the terminal size to always have 80 characters
let g:are_marks_showed=0
let g:old_columns=&columns
function! ToggleMarks()
    if g:are_marks_showed
        set columns-=2
        NoShowMarks!
        let g:are_marks_showed=0
    else
        set columns+=2
        DoShowMarks!
        let g:are_marks_showed=1
    endif
endfunction
" By default show the marks
"if exists('loaded_showmarks')
    "call ToggleMarks()
"endif
" Restore the initial terminal width when VIM is closed
au VimLeave * let &columns=g:old_columns

command TM call ToggleMarks()
