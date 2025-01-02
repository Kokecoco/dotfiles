function! BufferTabLine() 
	let buffer_tabline = '' 
	let sep = '|' 
	let s:buffer_info = s:GetBufferName() 
	for i in s:buffer_info 
		if i[3] == 1 
			let buffer_tabline = buffer_tabline . '%#TabLineSel#' 
		else 
			let buffer_tabline = buffer_tabline . '%#TabLine#' 
		endif 
	
		let buffer_tabline = buffer_tabline . i[0] . ': ' . i[1] 
	
		if i[2] == 1 
			let buffer_tabline = buffer_tabline . ' +' 
		endif 
	
		let buffer_tabline = buffer_tabline . sep 
	endfor 

	let buffer_tabline = buffer_tabline . '%#TabLineFill#%T' 
	let buffer_tabline = buffer_tabline . '%=buffers' 
	return buffer_tabline 
endfunction 

function! s:GetBufferName() 
	let s:buffers = execute('ls') 
	let s:result = [] 
	let s:buffer_list = split(s:buffers, "\n") 
	for b in s:buffer_list 
		let s:buffer_line = split(b) 
		let s:buffer_num = s:buffer_line[0] 
		let s:buffer_name = '' 
		let s:current_buffer = 0 
		let s:edit_flag = 0
		let s:unmodifiable = 0 
		
		for i in s:buffer_line 
			if i == '%a' 
				let s:current_buffer = 1 
			elseif i == '+' 
				let s:edit_flag = 1 
			elseif i == 'a-' || i == '%a-'
				let s:unmodifiable = 1
			elseif i[0] == '"' 
				let s:path = substitute(i, '"', '', 'g') 
				let s:name_path = split(s:path, '/') 
				let s:buffer_name = s:name_path[len(s:name_path) - 1]
			else 
			endif 
		endfor 
	
		if s:unmodifiable != 1
			let s:result = add(s:result, [s:buffer_num, s:buffer_name, s:edit_flag, s:current_buffer]) 
		endif
	endfor 
	return s:result 
endfunction 

set tabline=%!BufferTabLine()
set showtabline=2

command! -nargs=* Grep call s:grep_all(<f-args>)
let g:searched_dir = ""
let g:searched_filetype = ""
 
function s:grep_all(...) abort
	if a:0 < 1
		call s:find_dir("\"*.*\"", "\./")
		call s:grep(expand('<cword>'))
	elseif a:0 == 1
		call s:find_dir("\"*.*\"", "\./")
		call s:grep(a:1)
	elseif a:0 == 2
		call s:find_dir(a:2, "\./")
		call s:grep(a:1)
	elseif a:0 == 3
		call s:find_dir(a:2, a:3)
		call s:grep(a:1)
	else
	endif
endfunction

function s:find_dir(filetype, search_dir) abort
	if stridx(a:search_dir, g:searched_dir) == -1 || stridx(a:filetype,   g:searched_filetype) == -1 || !exists("g:find_dir_tmp")
		let g:searched_dir = a:search_dir
		let g:searched_filetype = a:filetype
		let l:find_sh = "find " . a:search_dir . " -name " . a:filetype . " -type f ! -path \"*.git/*\""
		let g:find_dir_tmp = tempname()
		call writefile(split(system(l:find_sh), "\n"), g:find_dir_tmp)
	endif
endfunction

function s:grep(text) abort
	let l:grep_sh = "cat " . g:find_dir_tmp . " | xargs grep -n " . a:text . " /dev/null"
	cexpr system(l:grep_sh) | cw
endfunction

" バナーを表示しない(分割ウィンドウで表示すると邪魔になる)
let g:netrw_banner = 0
" ファイラウィンドウのサイズ、お好みに
let g:netrw_winsize = 20
" ファイラウィンドウを垂直分割で表示(水平分割のときは0)
let g:netrw_preview = 1
" ツリー形式で表示する
let g:netrw_liststyle = 3
" 選択ファイルを開く(ファイラ以外のウィンドウで開く)
let g:netrw_browse_split = 4
" 開いたディレクトリに移動する
let g:netrw_keepdir = 0

autocmd! VimEnter * Ve | wincmd w

set autochdir
