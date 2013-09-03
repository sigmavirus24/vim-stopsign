if exists('g:loaded_stopsign')
  finish
endif
let g:loaded_stopsign = 1

if !exists('g:stopsign_trigger')
  let g:stopsign_trigger = 'dbg'
endif

let s:stopsign_replacement_defaults = {
      \ 'javascript': 'debugger;',
      \ 'python': 'import pdb; pdb.set_trace()',
      \ 'ruby': "require 'pry'; binding.pry;"
      \ }

if exists('g:stopsign_replacements')
  call extend(g:stopsign_replacements,
        \ s:stopsign_replacement_defaults,
        \ 'keep')
else
  let g:stopsign_replacements = s:stopsign_replacement_defaults
endif

for [ft,replacement] in items(g:stopsign_replacements)
  exe printf("autocmd FileType %s iabbrev <buffer> %s %s",
        \ ft,
        \ g:stopsign_trigger,
        \ replacement)
endfor
