vim9script

# =========================================================
#   Copyright (C) 2023 Allan Downey. All rights reserved.
#
#   File Name     : vimim_wubi.vim
#   Author        : Allan Downey<AllanDowney@126.com>
#   Version       : 0.1
#   Create        : 2023-02-28 23:18
#   Last Modified : 2023-02-28 23:18
#   Describe      : 
#
# =========================================================

if g:->get('loaded_vimim_wubi')
	finish
elseif v:version < 900
	echoerr "Error: 需要 Vim-9.0 以上版本."
	finish
endif

g:loaded_vimim_wubi = 1

augroup Vimim
	autocmd!
	autocmd VimEnter * call vimim#LoadTable()
    autocmd BufReadPre */table/*.txt setlocal ts=16 list
augroup END

command -nargs=0 ImBuild vimim#LoadTable(true)
command -nargs=0 ImLoad vimim#LoadTable()
command -nargs=0 ImDisable vimim#Disable()
command -complete=custom,WhFile -nargs=? ImEdit build#EditTable(<q-args>)

func WhFile(A, L, P)
	return "wubi86_zh.txt\nwubi86_dz.txt\ncustom.txt"
endfunc

inoremap <Plug>(VimimStart) <Cmd>call vimim#Enable()<CR>
inoremap <Plug>(VimimStop) <Cmd>ImDisable<CR>
nnoremap <Plug>(VimimStop) <Cmd>ImDisable<CR>
nnoremap <Plug>(VimimEdit) <Cmd>ImEdit<CR>

if !hasmapto('<Plug>(VimimStart)', 'i')
	inoremap  <Leader>im <Plug>(VimimStart)
endif

if !hasmapto('<Plug>(VimimStop)', 'i')
	inoremap  <Leader>in <Plug>(VimimStop)
endif

if !hasmapto('<Plug>(VimimStop)', 'n')
	nnoremap  <Leader>im <Plug>(VimimStop)
endif

if !hasmapto('<Plug>(VimimEdit)')
	nnoremap <Leader>ie <Plug>(VimimEdit)
endif

# vim: ts=4 sw=4 noet fdm=marker