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
"    http://www.r-project.org/Licenses/                                                                          
 


" Vim syntax file
" " Language:           Protein DataBank file format
" " Maintainer:         Hubert Santuz <hubert.santuz@gmail.com>
" " Last Change:        21 Feb 2012
" " Filenames:          *.pdb *.ent
" " 

if exists("b:current_syntax")
  finish
endif

" " For Comments
syn match mdpComment "^REMARK" nextgroup=remarkcontent
syn match remarkcontent ".*$" contained

" " ATOM field
syn match atomfield       "^ATOM.*" contains=atoms,residues,coordinates,element
syn region atoms       start="\%7v" end="\%17v" contained
syn region residues    start="\%18v" end="\%27v" contained
syn region coordinates start="\%31v" end="\%55v" contained
syn region element     start="\%78v" end="\%80v" contained

" " NAMD erroneous line
syn match namd "^ATOM.*0\.000.\+0\.000.\+0\.000.\+.*$"
"syn match namd "^.*$"




" "For values (after '=')
syn match mdpEqual       "^HETATM.*"

let b:current_syntax = "pdb"

" "Highlights colors
hi def link mdpComment     Comment
hi def link remarkcontent  Function
hi def link namd           todo
hi def link atomfield      Comment
hi def link atoms          Special
hi def link residues       Keyword
hi def link coordinates    Constant
hi def link element        Keyword
hi def link mdpEqual       Function


