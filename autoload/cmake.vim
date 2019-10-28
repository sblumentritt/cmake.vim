" --------------------------------------
" global options definition
" --------------------------------------
let g:cmake#blacklist = get(g:, 'cmake#blacklist', [])

let g:cmake#supported_languages = get(g:,
            \ 'cmake#supported_languages',
            \ ['C', 'CXX', 'PYTHON', 'JAVA', 'FORTRAN'])

let g:cmake#supported_configurations = get(g:,
            \ 'cmake#supported_configurations',
            \ ['DEBUG', 'RELEASE', 'MINSIZEREL', 'RELWITHDEBINFO'])

" --------------------------------------
" public functions
" --------------------------------------
function! cmake#gather_candidates(type) abort
    let l:cmake_candidates = []

    if a:type !=# 'command' && a:type !=# 'variable' && a:type !=# 'property'
        throw 'Invalid type specified!'
    endif

    for item in s:cmake_filter(systemlist('cmake --help-' . a:type . '-list'))
        call add(l:cmake_candidates, {'word': item, 'kind': a:type})
    endfor

    return l:cmake_candidates
endfunction

" --------------------------------------
" helper functions
" --------------------------------------
function! s:cmake_filter(cmake_item_list)
    let l:filtered_items = a:cmake_item_list
    let l:config_keyword = '<CONFIG>'
    let l:language_keyword = '<LANG>'

    " replace <CONFIG> and <LANG> placeholder with real keywords
    for item in a:cmake_item_list
        if item =~# l:language_keyword
            for supported_language in g:cmake#supported_languages
                call add(l:filtered_items, substitute(
                                                \ item,
                                                \ l:language_keyword,
                                                \ supported_language,
                                                \ ''
                                                \ ))
            endfor
        endif

        if item =~# l:config_keyword
            for supported_configuration in g:cmake#supported_configurations
                call add(l:filtered_items, substitute(
                                                \ item,
                                                \ l:config_keyword,
                                                \ supported_configuration,
                                                \ ''
                                                \ ))
            endfor
        endif
    endfor

    " remove items which contain <CONFIG>/<LANG> or a string from the blacklist
    for item in l:filtered_items
        if item =~# l:config_keyword
            call remove(l:filtered_items, index(l:filtered_items, item))
        endif

        if item =~# l:language_keyword
            call remove(l:filtered_items, index(l:filtered_items, item))
        endif

        for blacklisted_item in g:cmake#blacklist
            if item =~# blacklisted_item
                call remove(l:filtered_items, index(l:filtered_items, item))
            endif
        endfor
    endfor

    return uniq(l:filtered_items)
endfunction
