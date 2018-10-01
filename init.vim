"dein Scripts-----------------------------
if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/root/.repos/dein/repos/github.com/Shougo/dein.vim

"End dein Scripts-------------------------





"####Plugins####
call dein#begin('/root/.repos/dein')

"####ここから####
"ファイルオープンを便利に
call dein#add('Shougo/unite.vim')
"ツリーを表示する
call dein#add('scrooloose/nerdtree')
"インデントの可視化
call dein#add('nathanaelkane/vim-indent-guides')
"半角スペース可視化
call dein#add('bronson/vim-trailing-whitespace')
"ステータス行強化
call dein#add('itchyny/lightline.vim')
"コード自動補完2
call dein#add('Shougo/neocomplete.vim')
"C/C++のコード補完
call dein#add('justmao945/vim-clang')
"カラースキーマ
call dein#add('jacoborus/tender.vim')
"キーワード切り替え
call dein#add('AndrewRadev/switch.vim')
"if...endなど対応するキーワードの自動補完
call dein#add('tpope/vim-endwise')
"def...end等でも%を使えるようにする
call dein#add('vim-scripts/ruby-matchit')
"括弧補完
call dein#add('cohama/lexima.vim')
"pythonの補完
call dein#add('davidhalter/jedi-vim')
call dein#end()
"####ここまで####

"不足プラグインのインストール
if dein#check_install()
  call dein#install()
endif

"####システム設定####
"ターミナルのタイトルを戻す
let &titleold=expand("%:p:h")
set notitle
set wildmenu "コマンドラインモードでTabキーによるファイル名補完を有効にする
set nobackup "バックアップファイルを作らない
set noswapfile "スワップファイルを作らない
set autoread "編集中のファイルが変更されたら自動で読み直す
set hidden "バッファが編集中でもその他のファイルを開けるようにする
set showcmd "入力中のコマンドをステータスに表示する
"最後のカーソル位置を復元する
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
                  \ endif
                  endif
"####ここまで####

"####表示設定####
"let g:hybrid_use_iTerm_colors = 1
colorscheme tender
set ruler "カーソルの行列番号を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc'&enc).']['.&ff.']'} "ステータス業に表示させる情報の指定
set statusline+={fugitive#statusline()} "ステータス行に現在のgitブランチを表示する
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
"syntax on "コードの色分け
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set cursorline "現在の行を強調表示
set cursorcolumn "現在の行を強調表示（縦）
set virtualedit=onemore "行末の１文字先までカーソルを移動できるようにする
set visualbell "ビープ音を可視化
set laststatus=2 "ステータスラインを常に表示
set wildmode=list:longest "コマンドラインの補完
nnoremap j gj
nnoremap k gk
"####ここまで####

"####検索設定####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set incsearch "検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索語をハイライト表示
"####ここまで####

"####Tab系####
set list listchars=tab:\>\- "不可視文字を可視化
set expandtab "Tab文字をスペースにする
set tabstop=2 "行頭以外のTab文字の表示幅
set shiftwidth=2 "行頭でのTab文字の表示幅
"ここまで####


"####Unite.vimの設定
"バッファ一覧
noremap <C-P> :Unite buffer<CR>
"ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
"最近使ったファイル一覧
noremap <C-Z> :Unite file_mru<CR>
"sourcesを今開いているファイルのディレクトリとする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
"ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite #do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"ウィンドウを盾に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite #do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
"ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"####ここまで####

"####NERDTreeの設定
"ブックマークを初期表示
let g:NERDTreeShowBookmarks=1
"ファイル名が指定されていた場合NERDTreeを表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"NERDTreeを<Ctrl-e>で表示する
map <C-e> :NERDTreeToggle<CR>
"拡張子のハイライトを設定する
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

  call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
  call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
  call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
  call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
  call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
  call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
  call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
"####ここまで####

"####vim-indent-guidesの設定
"vimを起動したときに、オンにする
let g:indent_guides_enable_on_vim_startup=1
"####ここまで####

"####vim-clangの設定
"vim-clanGの自動コンプリート機能を無効にする
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

"default 'longest' can not work with neocomplete
let g:clang_c_completeopt = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
  let g:clang_exec= 'clang-3.6'
elseif executable('clang-3.5')
  let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
  let g:clang_exec = 'clang-3.4'
else
  let g:clang_exeec = 'clang'
endif
if executable('clang-format-3.6')
  let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
  let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
  let g:clang_format_exec = 'clang-format-3.4'
else
  let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"####ここまで

"####ファイルパス補完
inoremap <TAB><TAB> <C-x><C-f>
