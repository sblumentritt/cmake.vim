if exists('g:loaded_compe') && has('nvim')
    lua require('compe').register_source('cmake', require('compe_cmake'))
endif
