" --------------------------------------
" coc related functions
" --------------------------------------
function! coc#source#cmake#init() abort
    " options of current source
    return
          \ {
          \     'shortcut': 'cmake',
          \     'filetypes': ['cmake'],
          \     'priority': 3,
          \ }
endfunction

function! coc#source#cmake#complete(opt, cb) abort
    let l:completion_canditates = []

    call extend(l:completion_canditates, cmake#gather_candidates('command'))
    call extend(l:completion_canditates, cmake#gather_candidates('variable'))
    call extend(l:completion_canditates, cmake#gather_candidates('property'))

    call a:cb(l:completion_canditates)
endfunction
