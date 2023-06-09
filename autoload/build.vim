vim9script

# =========================================================
#   Copyright (C) 2023 Allan Downey. All rights reserved.
#
#   File Name     : build.vim
#   Author        : Allan Downey<AllanDowney@126.com>
#   Version       : 0.4
#   Create        : 2023-03-01 23:13
#   Last Modified : 2023-03-12 11:30
#   Describe      : 
#
# =========================================================

const table_path = expand('<script>:p:h:h') .. '/table'
const table_zh = table_path .. '/wubi86.txt'
const table_tw = table_path .. '/wubi86_tw.txt'

export def BuildTable(): dict<list<string>>
	echo '正在建立码表库，请稍候...'

	var table_dict = {}
	var im_gb2312: bool = empty(g:->get('Vimim_config')) ? v:true :
		get(g:Vimim_config, 'gb2312', v:true)

	var startt = reltime()

	var ltable_dict = ReadToDict(table_zh)

	if !im_gb2312
		ExtendD(ltable_dict, ReadToDict(table_tw))
	endif

	{
		var ltable_cust = ReadToDict(g:vimim_table_custom)

		if !empty(ltable_cust)
			ExtendD(ltable_dict, ltable_cust)
		endif
	}

	table_dict = mapnew(ltable_dict, (_, v) =>
		sort(v, (a, b) => -(str2nr(a[1]) - str2nr(b[1])))
		->mapnew((_, w) => w[0]))

	echo '已完成。用时' reltimestr(reltime(startt)) .. 's.'
	echon '  共计:' len(table_dict)->printf('%7d')

	var table_json = substitute(table_zh, 'txt$', 'json', '')
	writefile([js_encode(table_dict)], table_json)

	return table_dict
enddef

def ReadToDict(txtfile: string): dict<list<list<string>>>
	var table_dict = {}

	for line in readfile(txtfile)
		var [len, code, char, freq] = split(line, "\t")

		if has_key(table_dict, code)
			add(table_dict[code], [char, freq])
		else
			table_dict[code] = [[char, freq]]
		endif
    endfor

	var fname = fnamemodify(txtfile, ":t")
	echo fname->printf('%16s') '  计:' len(table_dict)->printf('%7d')
	return table_dict
enddef

def ExtendD(base: dict<list<list<string>>>, secondd: dict<list<list<string>>>):
		\ dict<list<list<string>>>
	for [key, value] in items(secondd)
		if has_key(base, key)
			extend(base[key], value->deepcopy())
		else
			base[key] = value->deepcopy()
		endif
	endfor

	return base
enddef

export def EditTable(txt: string)
	var lfile = txt
	if txt == 'wubi86_dz'
		lfile = table_path .. '/wubi86_dz.txt'
	elseif txt == 'wubi86'
		lfile = table_zh
	elseif txt == '' || txt == 'custom'
		lfile = g:vimim_table_custom
	else
		lfile = g:vimim_table_custom
	endif
	execute 'tabedit ' .. lfile
enddef

#  vim: ts=4 sw=4 noet fdm=indent
