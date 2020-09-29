# cmake.vim

Provides cmake completion for [completion-nvim][] / [coc.nvim][] /
[deoplete.nvim][].
> Requires [CMake][] available in the `$PATH`.

[[_TOC_]]

## Customization

Available options to customize the completion:

```vim
" define with which languages the <LANG> keyword should be replaced
" default: ['C', 'CXX', 'PYTHON', 'JAVA', 'FORTRAN']
let g:cmake#supported_languages = ['C', 'CXX']

" define with which build configs the <CONFIG> keyword should be replaced
" default: ['DEBUG', 'RELEASE', 'MINSIZEREL', 'RELWITHDEBINFO']
let g:cmake#supported_configurations = ['CUSTOM_DEBUG']

" define words which should not be shown in the completion (whole completion item will be removed)
" Note: items in blacklist are matched case sensitive!
" default: []
let g:cmake#blacklist = ['XCODE', 'ANDROID', 'OSX', 'VS', 'Fortran', 'Eclipse', 'ECLIPSE']
```

## License

The project is licensed under the MIT license. See [LICENSE](LICENSE) for more
information.

[CMake]: https://cmake.org/
[coc.nvim]: https://github.com/neoclide/coc.nvim
[deoplete.nvim]: https://github.com/Shougo/deoplete.nvim
[completion-nvim]: https://github.com/nvim-lua/completion-nvim
