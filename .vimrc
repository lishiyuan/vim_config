""""""""""""""""""""""""""""""""""""""""""""""""
"编码、语言设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8

""""""""""""""""""""""""""""""""""""""""""""""""
"代码按照缩进收放
"zR:打开所有
"zM:收起所有
"zc:收起光标所在块
"zo:打开光标所在块
"za:光标所在的位置打开/收起状态取反
"set foldmethod=indent

""""""""""""""""""""""""""""""""""""""""""""""""
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i

""""""""""""""""""""""""""""""""""""""""""""""""
"设置状态行显示常用信息
"%= 剩余的内容向右对齐
"\  转义字符
set statusline=%F%=\ asc=%b\ hex=0x%B\ line=%l\[%p%%,%L]\ row=%v\ \ \ \ .
"设置laststatus = 0 ，不显式状态行
"设置laststatus = 1 ，仅当窗口多于一个时，显示状态行
"设置laststatus = 2 ，总是显式状态行
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

""""""""""""""""""""""""""""""""""""""""""""""""
"重映射
"重映射实际行和屏幕行
nnoremap k  gk
nnoremap j  gj
nnoremap gj j
nnoremap gk k
nnoremap gk k

""""""""""""""""""""""""""""""""""""""""""""""""
"TAB
"空格代替Tab"
"注意: 插入模式下输入【ctrl+v+i】可以强制输入一个tab
set tabstop=4     " tabstop 表示一个 tab 显示出来是多少个空格的长度，默认8
set softtabstop=4 " softtabstop 表示在编辑模式的时候按退格键的时候退回缩进的长度，当使用 expandtab 时特别有用
set expandtab     " 当设置成 expandtab 时，缩进用空格来表示，noexpandtab 则是用制表符表示一个缩进
set autoindent    " 自动缩进
set cindent       " 自动缩进补充
set shiftwidth=4  " 自动缩进空白字符个数

""""""""""""""""""""""""""""""""""""""""""""""""
"显示肉眼不可见字符
"显示换行为$符号
set list
"table显示为>---
set listchars=tab:>-
"高亮显示行尾空格
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

""""""""""""""""""""""""""""""""""""""""""""""""
"通用设置
set cursorline    " 突出显示当前行
set syntax=on     " 语法高亮
set scrolloff=5   " 光标上移下移时，始终预留 x 行空格到顶部或底部
set nu            " 显示行号
"set rnu           " 使用相对行号
set history=1000  " 历史记录数
set showmatch     " 高亮显示匹配的括号
set hlsearch      " 搜索逐字符高亮

""""""""""""""""""""""""""""""""""""""""""""""""
""快捷键F4，添加文件头注释，以及版权声明
"备注：后面还有autocmd命令，打开一个新文件自动生成头注释方法
map <F4> :call TitleDet()<cr>'s
function AddTitle()
    "call append( 0, "/* COPYRIGHT NOTICE")
    call append( 0, "\/* 版权声明")
    call append( 1, " * 功能     ：")
    call append( 2, " * 作者     ：lsy")
    call append( 3, " * 文件路径 : ".expand("%:p:h")."/".expand("%:t"))
    call append( 4, " * 创建时间 ：".strftime("%Y/%m/%d %H:%M"))
    call append( 5, " *\/")
    call append( 6, "")

    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/#       @date      /s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/#       @file      /s@:.*$@\=":".expand("%:p:h")."\\".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有COPYRIGHT NOTICE这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n = 1
    "默认为添加
        let line = getline(n)
        "let str = '^/\* COPYRIGHT NOTICE$'
        let str = '^/\* 版权声明$'
        if line =~ str
            call UpdateTitle()
            return
        endif
    call AddTitle()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
""快捷键F5，生成main函数模板
"备注：后面还有autocmd命令，打开一个新文件自动生成头注释方法
map <F5> :call TitleDet_main()<cr>'s
function AddTitle_main()
    "call append( 0, "/* COPYRIGHT NOTICE")
    call append( 0, "\/* 版权声明")
    call append( 1, " * 功能     ：")
    call append( 2, " * 作者     ：lsy")
    call append( 3, " * 文件路径 : ".expand("%:p:h")."/".expand("%:t"))
    call append( 4, " * 创建时间 ：".strftime("%Y/%m/%d %H:%M"))
    call append( 5, " *\/")
    call append( 6, "")
    call append( 7, "#include <stdio.h>")
    call append( 8, "#include <string.h>")
    call append( 9, "")
    call append(10, "int main(int argc, char *argv[])")
    call append(11, "{")
    call append(12, "")
    call append(13, "    return 0;")
    call append(14, "}")

    echohl WarningMsg | echo "Successful in adding the main function." | echohl None
endfunction
"更新最近修改时间和文件名
function UpdateTitle_main()
    normal m'
    execute '/#       @date      /s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/#       @file      /s@:.*$@\=":".expand("%:p:h")."\\".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the main function." | echohl None
endfunction
"判断前10行代码里面，是否有COPYRIGHT NOTICE这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet_main()
    let n = 1
    "默认为添加
        let line = getline(n)
        "let str = '^/\* COPYRIGHT NOTICE$'
        let str = '^/\* 版权声明$'
        if line =~ str
            call UpdateTitle_main()
            return
        endif
    call AddTitle_main()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
"快捷键F6，生成.h文件模板
"备注：后面还有autocmd命令，打开一个新文件自动生成头注释方法
map <F6> :call TitleDet_h()<cr>'s
function AddTitle_h()
    "call append( 0, "/* COPYRIGHT NOTICE")
    call append( 0, "\/* 版权声明")
    call append( 1, " * 功能     ：")
    call append( 2, " * 作者     ：lsy")
    call append( 3, " * 文件路径 : ".expand("%:p:h")."/".expand("%:t"))
    call append( 4, " * 创建时间 ：".strftime("%Y/%m/%d %H:%M"))
    call append( 5, " *\/")
    call append( 6, "")
    call append( 7, "#ifndef ")
    call append( 8, "#define ")
    call append( 9, "")
    call append(10, "")
    call append(11, "")
    call append(12, "#endif")
    echohl WarningMsg | echo "Successful in adding the .h file." | echohl None
endfunction

"更新最近修改时间和文件名
function UpdateTitle_h()
    normal m'
    execute '/#       @date      /s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/#       @file      /s@:.*$@\=":".expand("%:p:h")."\\".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the .h file." | echohl None
endfunction
"判断前10行代码里面，是否有COPYRIGHT NOTICE这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet_h()
    let n = 1
    "默认为添加
        let line = getline(n)
        "let str = '^/\* COPYRIGHT NOTICE$'
        let str = '^/\* 版权声明$'
        if line =~ str
            call UpdateTitle_h()
            return
        endif
    call AddTitle_h()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
"vim打开新的.c文件时，自动生成头注释，并且光标定位到main.c文件第一行
"注意：touch生成的文件，再使用vim打开不会生成头注释
autocmd BufNewFile *.c exec ":call SetTitle_new_file_c()"
func SetTitle_new_file_c()
    "call append( 0, "/* COPYRIGHT NOTICE")
    call append( 0, "\/* 版权声明")
    call append( 1, " * 功能     ：")
    call append( 2, " * 作者     ：lsy")
    call append( 3, " * 文件路径 : ".expand("%:p:h")."/".expand("%:t"))
    call append( 4, " * 创建时间 ：".strftime("%Y/%m/%d %H:%M"))
    call append( 5, " *\/")
    call append( 6, "")
    call append( 7, "#include <stdio.h>")
    call append( 8, "#include <string.h>")
    call append( 9, "")
    call append(10, "int main(int argc, char *argv[])")
    call append(11, "{")
    call append(12, "")
    call append(13, "    return 0;")
    call append(14, "}")
endfunc

autocmd BufNewFile *.c normal G3k

""""""""""""""""""""""""""""""""""""""""""""""""""
"vim打开新的.h文件，自动生成头注释，并且光标定位到 #ifndef 行
"注意：touch生成的文件，再使用vim打开不会生成头注释
autocmd BufNewFile *.h exec ":call SetTitle_new_file_h()"
func SetTitle_new_file_h()
    "call append( 0, "/* COPYRIGHT NOTICE")
    call append( 0, "\/* 版权声明")
    call append( 1, " * 功能     ：")
    call append( 2, " * 作者     ：lsy")
    call append( 3, " * 文件路径 : ".expand("%:p:h")."/".expand("%:t"))
    call append( 4, " * 创建时间 ：".strftime("%Y/%m/%d %H:%M"))
    call append( 5, " *\/")
    call append( 6, "")
    call append( 7, "#ifndef ")
    call append( 8, "#define ")
    call append( 9, "")
    call append(10, "")
    call append(11, "")
    call append(12, "#endif")
endfunc

autocmd BufNewFile *.h normal G6k


""""""""""""""""""taglist 设置""""""""""""""""""
"let Tlist_Auto_Open = 1  "进入vim时自动打开插件
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
set tags=tags

""""""""""""""""""配置WinManager""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
"设置打开WinManager插件快捷键为F8"
nmap <silent> <F8> :WMToggle<cr><C>wl
"进入vim时自动打开插件
let g:AutoOpenWinManager = 1
"设置winmanager的宽度，默认为25"
let g:winManagerWidth = 30
"自动退出Winmanager
"autocmd bufenter * if ((winnr("$") == 3) && (exists("b:NERDTreeType")) && (b:NERDTreeType == "primary")) | qa | endif
autocmd bufenter * if ((winnr("$") == 3) && (exists("b:NERDTreeType"))) | qa | endif

""""""""""""""""""""""""""""""""""""""""""""""""
"""""""Powerline"""""""
set rtp+=/home/lsy/.local/lib/python2.7/site-packages/powerline/bindings/vim
"These lines setup the environment to show graphics and colors correctly.
set nocompatible
set t_Co=256
let g:minBufExplForceSyntaxEnable = 1
if ! has('gui_running')
set ttimeoutlen=10
augroup FastEscape
autocmd!
au InsertEnter * set timeoutlen=0
au InsertLeave * set timeoutlen=1000
augroup END
endif
set laststatus=2 " Always display the statusline in all windows
set guifont=Inconsolata\ for\ Powerline:h14
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
"字体补丁
let laststatus = 2
"使用powerline打过补丁的字体"
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='fancy'


""""""""""""""""""""""""""""""""""""""""""
"set cursorcolumn     "显示光标对齐竖线
"let &colorcolumn=80  "行宽提醒竖线设置为80
set nowrap           "超过屏幕宽度不换行显示


""""""""""""""""""""""""""""""""""""""""""
""""""nerdcommenter config"""""
"本来默认该插件注释先要使用一个反斜杠【\】然后才使用命令，这里自定义将反斜杠修改为逗号【,】
let mapleader=","

"nerdcommenter插件使用快捷键：
"    ,ca         切换注释风格，比如C/C++ 的块注释/* */和行注释//
"    ,cc         注释当前行
"    ,c<space>   切换【注释/非注释】状态
"    ,cs         以”性感”的方式注释
"    ,cA         在当前行尾添加注释符，并进入Insert模式
"    ,cu         取消注释
"
"Normal模式下，几乎所有命令前面都可以指定行数。比如 输入 6,cs 的意思就是以性感方式注释光标所在行开始6行代码
"Visual模式下执行命令，会对选中的特定区块进行注释/反注释
"此外，其它的nerdcommenter命令可以在NORMAL模式下输入命令 :map 看到




"""""""""以下为新增加功能，未更新博客"""""""""""""""""""""""""

