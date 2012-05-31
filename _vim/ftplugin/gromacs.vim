"                                                                           
"    This program is free software: you can redistribute it and/or modify  
"    it under the terms of the GNU General Public License as published by   
"    the Free Software Foundation, either version 3 of the License, or      
"    (at your option) any later version.                                    
"                                                                           
"    This program is distributed in the hope that it will be useful,        
"    but WITHOUT ANY WARRANTY; without even the implied warranty of         
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          
"    GNU General Public License for more details.                           
"                                                                           
"    A copy of the GNU General Public License is available at
"    <http://www.gnu.org/licenses/>.


" " Maintainer:         Jonathan Barnoud <jonathan@barnoud.net>
" " Last Change:        22 Apr 2012

" Shortcuts:
"   ];      -- Comment the selected block
"   ]:      -- Uncomment the selected block
"   ],      -- Jump to the next section
"   [,      -- Jump to the previous section


if exists("b:loaded_gmx_plugin")
  finish
endif
let b:loaded_gmx_plugin = 1

map  ];   :call GromacsCommentSelection()<CR>
vmap ];   :call GromacsCommentSelection()<CR>
map  ]:   :call GromacsUncommentSelection()<CR>
vmap ]:   :call GromacsUncommentSelection()<CR>
map  ],   :call GromacsMoveSection(1)<CR>
map  [,   :call GromacsMoveSection(-1)<CR>


" Apply given arithmetic operation on integer
" Example: GAA + 1
" This would add one for each number.
command! -nargs=+ -range GAA call GAAf(<f-args>)


" Apply given arithmetic operation on integer if condition is true
" Example: GCA > 50 - 1
" This would subtract one from each number larger than 50.
command! -nargs=+ -range GCA call GCAf(<f-args>)


" Multiply lines in a given range making repeating identical lines
" Example: GAM 2
" Each line in the range would be duplicated
command! -nargs=1 -range GAM call GAMf(<f-args>, <line1>, <line2>)


" Comment out selected lines
" Add the comment character as first column
function! GromacsCommentSelection() range
    let commentString = ";"
    let cl = a:firstline
    while (cl <= a:lastline)
        let ul = substitute(getline(cl), "^\\(.*\\)$", commentString."\\1", "")
        call setline(cl, ul)
        let cl = cl + 1
    endwhile
endfunction

" Uncomment  selected lines
" Remove the first comment character
function! GromacsUncommentSelection() range
    let commentString = ";"
    let cl = a:firstline
    while (cl <= a:lastline)
        let ul = substitute(getline(cl),
            \"\\([ \\t]*\\\)".commentString."\\(.*\\)$", "\\1\\2", "")
        call setline(cl, ul)
        let cl = cl + 1
    endwhile
endfunction

" Move to the next (1) or previous (-1) section
function! GromacsMoveSection(direction)
    let regexp = "^[^;]*\\[.*\\]"
    let flag = "W"
    if (a:direction == -1)
        let flag = flag."b"
    endif
    let res = search(regexp, flag)
endfunction


" Apply a given arithmetic operation on integer
" O - arithmetic operator to apply
" N - value for arithmetic operation
fun! GAAf(O, N) range
	let n=str2nr(a:N)
	execute "'<,'>s/\\%V\\d\\+/\\=submatch(0) " . a:O . n . "/g"
endfun


" Apply a given arithmetic operation on integer if condition is true
" C - comparison operator for condition
" L - limiting value for comparison
" O - arithmetic operator to apply
" N - value for arithmetic operation
fun! GCAf(C, L, O, N) range
	let l=str2nr(a:L)
	let n=str2nr(a:N)
	execute "'<,'>s/\\%V\\d\\+/\\=submatch(0) " . a:C . l . " ? submatch(0) " . a:O . n . " : submatch(0)/g"
endfun


" Multiply lines in a given range making repeating identical lines
" M - final number of identical lines
fun! GAMf(M, ...) range
	let m=str2nr(a:M)-1

	if a:0 == 2
		let nlines=a:2 - a:1 + 1
	else
		let nlines=a:lastline - a:firstline + 1
	endif

	for n in range(nlines)
		execute "normal Vy" . m . "p" . m . "j\<ESC>"
	endfor
endfun
