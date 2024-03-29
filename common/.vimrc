"===============================================================================
" https://github.com/everbot/dotfiles
"
" My own note of using VIM:
"   * use gvim as it has better font rendering
"   * gvim can auto-reload a file if it's changed externally
"     vim can't do that (???!!!)
"   * use Monospace font
"   * font size is 10
"===============================================================================
"

" Read essential configuration from the mini file
source ~/.vimrc-mini

"===============================================================================
"---begin pathogen plugin
execute pathogen#infect()

" If you want to be able to access the documentation from within vim, you'll
" also need to generate helptags
call pathogen#helptags()

"---end pathogen plugin
"===============================================================================


"===============================================================================
"---begin easy-motion {{{

if !exists('g:vscode')

  "let g:EasyMotion_do_mapping = 0 " Disable default mappings
  "map <Leader> <Plug>(easymotion-prefix)

  let g:EasyMotion_smartcase = 0

  nmap s <Plug>(easymotion-s2)
  nmap t <Plug>(easymotion-t2)

  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)

  " These 'n' & 'N' mappings are options. You do not have to map 'n' & 'N' to
  " EasyMotion.  " Without these mappings, 'n' & 'N' works fine. (These mappings
  " just provide " different highlight method and have some other features )
  " map  n <Plug>(easymotion-next)
  " map  N <Plug>(easymotion-prev)

  " https://www.youtube.com/watch?v=aHm36-na4-4&feature=youtu.be
  " This rewires n and N to do the highlighing...
  if !exists('g:vscode')
    nnoremap <silent> n   n:call HLNext(0.3)<cr>
    nnoremap <silent> N   N:call HLNext(0.3)<cr>
  endif

  " highlight the match in red...
  " function! HLNext (blinktime)
  "     highlight WhiteOnRed ctermfg=white ctermbg=red
  "     let [bufnum, lnum, col, off] = getpos('.')
  "     let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  "     let target_pat = '\c\%#\%('.@/.'\)'
  "     let ring = matchadd('WhiteOnRed', target_pat, 101)
  "     redraw
  "     exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  "     call matchdelete(ring)
  "     redraw
  " endfunction

  function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'), col-1),@/))
    let target_pat = '\c\%#'.@/
    let blinks = 3

    for n in range(1, blinks)
      let red = matchadd('WhiteOnRed', target_pat, 101)
      redraw
      exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . "m"
      call matchdelete(red)
      redraw
      exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . "m"
    endfor
  endfunction

  "map <Leader>l <Plug>(easymotion-lineforward) "comment this out, interfere with
  "latex
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map <Leader>h <Plug>(easymotion-linebackward)
  let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
endif

"---end easy-motion }}}
"===============================================================================


"===============================================================================
"---begin vim-sneak {{{
" let g:sneak#streak = 1
" use case insensitive
" let g:sneak#use_ic_scs = 1
"---end vim-sneak }}}
"===============================================================================

"===============================================================================
"---begin nerdtree {{{

if !exists('g:vscode')
  "autocmd vimenter * NERDTree "auto open nerdtree upon vim launch
  " use Ctrl+n to open nerdtree
  map <C-n> :NERDTreeToggle<CR>

  " fix can't navigate to directory using enter key, due to odd symbols infront
  " of directory name
  let NERDTreeDirArrows=0

  " don't display compile output stuffs
  let NERDTreeIgnore=['.class$[[file]]', '.o$[[file]]']

  " split and vsplit behave similar with Unite candidate window shortcut
  let NERDTreeMapOpenSplit='s'
  let NERDTreeMapOpenVSplit='v'

  "open nerdtree based on the directory of the current buffer, the cursor will be
  "placed at the current opened file
  map <silent> <Leader>r :NERDTreeFind<cr>
endif
"---end nerdtree }}}
"===============================================================================


"match Todo /^ \+/

"highlight current line
color molokai
"color Monokai-Refined


"set linespace=2

"===============================================================================
" for solarized theme
"
"syntax enable
"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif
"colorscheme solarized
"===============================================================================


" automatic reloading of .vimrc, so we don't need to close the .vimrc
" for vim to apply new settings in that file
" currently, this interfeer with identLine and vim-airline (after save the
" .vimrc file, those plugin lost their visual.
"autocmd! bufwritepost .vimrc source %


"===============================================================================
"---begin unite.vim {{{
"usage:
" :Unite line
" :Unite tab

if !exists('g:vscode')

  " "test" ignores test directory/file only.
  " "test/" ignores test directory and inner files.
  " ignore everything at first
  let s:unite_mru_ignores = ['*']
  " add white list of candidates not to be ignored
  let s:unite_mru_whites = ['Test.java',
                      \ '**/Dropbox/dev/**',
                      \ '**/dev/**',
                      \ '*.md',
                      \ 'pacman.log',
                      \ '**/dotfiles/**']
  call unite#custom#source('file_mru', 'ignore_globs', s:unite_mru_ignores)
  call unite#custom#source('file_mru', 'white_globs', s:unite_mru_whites)
  " call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
  "   \ 'ignore_globs', unite#get_all_sources('file_rec')['ignore_globs'] +
  "   \ s:unite_mru_ignores)
  " call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
  "   \ 'white_globs', unite#get_all_sources('file_rec')['white_globs'] +
  "   \ s:unite_mru_whites)

  " The below setting works well to ignore certain patterns in the white_globs list
  " \ '\/.vim\/bundle\/.\+tags$',  : match .vim/bundle/..tags
  call unite#custom#source('file_mru', 'ignore_pattern',
              \ join([
              \ '\.cache',
              \ '\/.vim\/bundle\/',
              \ '\/everbot\.github\.io\/',
              \ '^\/run'],
              \ '\|'
              \ )
              \ )

  " For file_rec/async source: Ignore all files under tmp directory of Rails app
  " call unite#custom#source('file_rec/async', 'ignore_pattern',
  call unite#custom#source('file_rec/git', 'ignore_pattern',
              \ join([
              \ '\.cache',
              \ '\/tmp\/cache\/',
              \ '\/tmp\/pids\/',
              \ '\/tmp\/sessions\/',
              \ '\/tmp\/sockets\/',
              \ '\.\(js\|css\|png\|gif\)$',
              \ 'lib\/ale',
              \ '.*admin\/tmp\/'],
              \ '\|'
              \ )
              \ )

  nnoremap <C-Space> :Unite -start-insert<CR>

  " custom profile:
  " \   'direction': 'botright',
  " 'direction': 'botright', 'topleft'
  " 'prompt_direction': 'top', 'below'
  " \   'prompt': '» ',
  call unite#custom#profile('default', 'context', {
  \   'startinsert': 1,
  \   'prompt': '>> ',
  \   'prompt_direction': 'top',
  \   'direction': 'topleft',
  \ })
  "
  " Set "-no-quit" automatically in grep unite source.
  call unite#custom#profile('source/grep', 'context', {
  \   'no_quit' : 1
  \ })

  " don't limit number of candidate
  let g:unite_source_rec_max_cache_files = 0
    call unite#custom#source('file_rec,file_rec/async,file_rec/neovim,file_rec/git,grep',
    \ 'max_candidates', 0)


  " call unite#util#set_default(
  " \ 'g:unite_source_grep_command', 'grep')
  " call unite#util#set_default(
  " \ 'g:unite_source_grep_default_opts', '-inH')
  " " \ 'g:unite_source_grep_default_opts', '-inH --directories=recurse')
  " call unite#util#set_default('g:unite_source_grep_recursive_opt', '-r')
  " call unite#util#set_default('g:unite_source_grep_max_candidates', 100)
  " call unite#util#set_default('g:unite_source_grep_search_word_highlight', 'Search')
  " call unite#util#set_default('g:unite_source_grep_encoding', 'char')
  "
  let g:unite_source_grep_command = "grep"
  let g:unite_source_grep_recursive_opt = "-R"
  let g:unite_source_grep_default_opts = '-inH'
  " let g:unite_source_grep_default_opts = '-ir'
  " nnoremap <space>/ :Unite grep:.:-iR:tung<cr>
  " nnoremap <space>/ :Unite grep:.::tung<cr>
  " nnoremap <space>/ :Unite grep:.<cr>

  if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden --ignore ' .
    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('pt')
    " Use pt in unite grep source.
    " https://github.com/monochromegane/the_platinum_searcher
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('ack-grep')
    " Use ack in unite grep source.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
    \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('jvgrep')
    " For jvgrep.
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts =
    \ '-i --exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
  endif

  " nnoremap <F8> :Unite -no-quit -keep-focus -no-empty grep:.<cr>

  " Use F8 to grep from the root level of the current git repo
  " nnoremap <F8> :Unite -no-quit -keep-focus -no-empty grep/git:/<cr>

  " use <Leader>s to go to symbol with Unite. This is to replace CtrlP
  " nnoremap <silent> <Leader>s :NeoCompleteIncludeMakeCache<CR>:Unite
  "             \ -silent tag/include -start-insert<CR>
  nnoremap <silent> <Leader>s :Unite tag -no-quit -start-insert<CR>

  " For ack.
  " Using ack-grep as recursive command.
  let g:unite_source_rec_async_command = 'find'

  function! MyFileBrowser()
    if finddir('.git', ';') == ''
      Unite file_rec/neovim -start-insert
    else
      Unite file_rec/git -start-insert
    endif
  endfunction


  " access recently edited files
  nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 -start-insert file_mru<cr>

  " navigates current open buffers
  " nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 -start-insert buffer<cr>

  " open Unite file browser
  " nnoremap <Leader>f :Unite file_rec/neovim -start-insert<cr>
  " nnoremap <Leader>f :call MyFileBrowser()<cr>

  " open bookmark
  nnoremap <silent> <Leader>a :Unite -buffer-name=bookmarks -start-insert bookmark<CR>

  " yank history
  nnoremap <Leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>

  " Unite outline (support markdown quite well!)
  nnoremap <Leader>o :Unite outline -start-insert<cr>

  " list all window except the current one
  nnoremap <Leader>w :Unite window:no-current:all -start-insert<cr>

  nnoremap <Leader>uc :Unite colorscheme -start-insert<cr>


  " control where the unite buffer will appear
  "let g:unite_split_rule = "botright"
  " let g:unite_split_rule = "top"
  " let g:unite_split_rule = "right"

  " open a buffer in new tab or switch to existing tab by default
  " call unite#custom_default_action('file', 'tabopen')
  call unite#custom_default_action('file', 'tabswitch')
  call unite#custom_default_action('buffer', 'tabswitch')


  "fuzzy search within a file using <Leader>q
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  " call unite#custom#source('file,file/new,buffer,file_rec,line', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')
  " call unite#custom#source('line', 'matchers', 'matcher_default')
  call unite#custom#source('line', 'matchers', 'matcher_glob')
  " nnoremap <C-k> :<C-u>Unite -buffer-name=search -start-insert line<cr>
  nnoremap <Leader>q :<C-u>Unite -buffer-name=search -start-insert line -auto-preview<cr>
  " nnoremap <Leader>q :<C-u>Unite -buffer-name=search -start-insert line -auto-preview -vertical-preview<cr>

  " Use Ctrl+l to refresh the directory listing in file in Unite candidate window
  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()"{{{
    " Overwrite settings.
    nmap <buffer> <C-l>      <Plug>(unite_redraw)

    " these mapping are used in the Unite candidate window
    nnoremap <buffer><expr> t unite#do_action('tabswitch')
    nnoremap <buffer><expr> s unite#do_action('splitswitch')
    nnoremap <buffer><expr> v unite#do_action('vsplitswitch')

    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  endfunction"}}}


  let g:unite_source_menu_menus = {}
  let g:unite_source_menu_menus.git = {
      \ 'description' : '            gestionar repositorios git
          \                            ⌘ [espacio]g',
      \}
  let g:unite_source_menu_menus.git.command_candidates = [
      \['▷ tig                                                        ⌘ ,gt',
          \'normal ,gt'],
      \['▷ git status       (Fugitive)                                ⌘ ,gs',
          \'Git'],
      \['▷ git diff         (Fugitive)                                ⌘ ,gd',
          \'Gdiff'],
      \['▷ git commit       (Fugitive)                                ⌘ ,gc',
          \'Git commit'],
      \['▷ git log          (Fugitive)                                ⌘ ,gl',
          \'exe "silent Glog | Unite quickfix"'],
      \['▷ git blame        (Fugitive)                                ⌘ ,gb',
          \'Gblame'],
      \['▷ git stage        (Fugitive)                                ⌘ ,gw',
          \'Gwrite'],
      \['▷ git checkout     (Fugitive)                                ⌘ ,go',
          \'Gread'],
      \['▷ git rm           (Fugitive)                                ⌘ ,gr',
          \'Gremove'],
      \['▷ git mv           (Fugitive)                                ⌘ ,gm',
          \'exe "Gmove " input("destino: ")'],
      \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
          \'Git! push'],
      \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
          \'Git! pull'],
      \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
          \'exe "Git! " input("comando git: ")'],
      \['▷ git cd           (Fugitive)',
          \'Gcd'],
      \]

  " 2015-04-30 below line cause `[m` motion slow
  " nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>

  let g:unite_source_tag_max_name_length=25
  let g:unite_source_tag_max_fname_length=50
  let g:unite_source_tag_relative_fname=1
endif

"---end unite.vim }}}
"===============================================================================


"===============================================================================
" begin vim-airline {{{

set laststatus=2

" update 2017-07-19: just use ASCII symbols instead
set encoding=utf-8 " to use the Powerline font
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1

" display nice icon ontop
" currently having problem messing up the top tabs indicator after a buffer
" is closed
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#tabs_label = ''

" show number of buffer in the current tab in tabline status
" let g:airline#extensions#tabline#tab_nr_type = 0

" show tab number in tabline status
let g:airline#extensions#tabline#tab_nr_type = 1

" let g:airline#extensions#tabline#buffer_nr_show = 1

" not sure if needed
" let g:Powerline_symbols="fancy"

let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '

" make tabline separator straight instead of the nice arrow icon
" let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" disable showing closed buffers' names in the tabline when there is only 1 tab
" open because it looks annoying
let g:airline#extensions#tabline#show_buffers = 0
" when there is only 1 tab open, vim-airline will display all buffers in the
" tabline, we can switch to a buffer by :bn or :bp
" end vim-airline }}}
"===============================================================================


"===============================================================================
"begin indentLine {{{

if !exists('g:vscode')
  if has('gui_running')
      "let g:indentLine_color_gui = '#353833'
      let g:indentLine_color_gui = '#2E322D'
  else
      let g:indentLine_color_term = 239
  endif

  " enable by default
  let g:indentLine_enabled = 1

  let g:indentLine_char = '┊'

  nmap <leader>il :IndentLinesToggle<cr>
endif
"end indentLine }}}
"===============================================================================


"===============================================================================
"---begin vim-latex plugin {{{
filetype plugin indent on "REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'

" use synctex
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -synctex=1 $*'

" to ignore quickfix window automatically open when there is warning, it's
" really annoying!
let g:Tex_IgnoredWarnings =
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n".
    \'LaTex Warning'."\n"
let g:Tex_IgnoreLevel = 9

" which program to use to open pdf file
" let g:Tex_ViewRule_pdf = 'zathura'
" let g:Tex_ViewRule_pdf = "zathura -s -x 'gvim --servername SYNCTEX --remote +%{line} %{input}'".expand("%:p:r").".pdf"
let g:Tex_ViewRule_pdf = "zathura"

" let g:Tex_ViewRule_ps = 'okular'
" let g:Tex_ViewRule_pdf = 'okular'
" let g:Tex_ViewRule_dvi = 'okular'

" In short you should be able to change three global variables to get rid of all folding
"let Tex_FoldedSections=""
"let Tex_FoldedEnvironments=""
"let Tex_FoldedMisc=""

"to disable display inline math notation
let g:tex_conceal = ""

function! SyncTexForward()
     " let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     " let execstr = "silent !zathura --synctex-forward 200:1:thesis.tex thesis.pdf"
     let execstr = "silent !zathura --synctex-forward ".line(".").":1:".expand("%:p:r").".tex ".expand("%:p:r").".pdf"
     exec execstr
endfunction
nmap <Leader>1 :call SyncTexForward()<CR>

"---end vim-latex }}}
"===============================================================================

"===============================================================================
"---begin fugitive {{{
" whow and resize the git status window to be 30% of the screen size
nmap <leader>gs :Git<cr>:exec 'resize' . string(&lines * 0.3)<cr>

nmap <leader>gc :Git commit<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gp :Git push<cr>
nmap <leader>ge :Gedit<cr>

" After analyze :Gdiff we want to just display the current version on disk only,
" and clos the rest of other windows
nmap <leader>gE :Gedit<cr>:only<cr>

" View general git log
" nmap <leader>gl :exe "silent Glog -- \| Unite quickfix -no-quit"<cr>

" View git log of current buffer
nmap <leader>gl :exe "silent Glog \| Unite quickfix -no-quit"<cr>

" Each time you open a git object using fugitive it creates a new buffer. This
" means that your buffer listing can quickly become swamped with fugitive buffers.
" Here’s an autocommand that prevents this from becomming an issue:
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
if has("autocmd")
    autocmd BufReadPost fugitive://* set bufhidden=delete
end

" work around recent key binding changes
" https://github.com/tpope/vim-fugitive/issues/1221
" https://github.com/tpope/vim-fugitive/commit/a510b3aadf3f39711c113371c18adc48ad54e6ee#commitcomment-35424504
autocmd FileType fugitiveblame nmap <buffer> q gq
autocmd FileType fugitiveblame nmap <buffer> D dd
autocmd FileType fugitive nmap <buffer> q gq
autocmd FileType fugitive nmap <buffer> D dd
"---end fugitive }}}
"===============================================================================


"===============================================================================
"---begin supertab plugin
"currently not using supertab
"TODO: try out YouCompleteMe plugin
"
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

"---end supertab
"===============================================================================



" vim-indent guide:
" usage: <leader>ig to toggle/untoggle displaying the ident guide
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=blue ctermbg=4




"===============================================================================
"---begin cursor highlight
" make the cursor at the current line different, highlight current line
if has('gui_running')
    "set cursorline "this make movement quite slow on low spec computer
endif

"should not set color explicitly, leave it to the theme configuration
"hi CursorLine term=bold cterm=bold guibg=Grey40


"------------------
"let g:boostmove=0
"set updatetime=50
"au CursorMoved * call BoostMoveON()
"au CursorMovedI * call BoostMoveON()
"au CursorHold * call BoostMoveOFF()
"au CursorHoldI * call BoostMoveOFF()
"
"function BoostMoveON()
"    if (g:boostmove == 0)
"        let g:boostmove=1
"        setlocal nocursorline
"    endif
"endfunction
"
"function BoostMoveOFF()
"    if g:boostmove==1
"        let g:boostmove=0
"        setlocal cursorline
"    endif
"endfunction


"use Ctrl+spacebar to temporary display the crosshair cursor for awhile and
"disappear
"http://briancarper.net/blog/590/cursorcolumn--cursorline-slowdown
function! CursorPing()
    set cursorline cursorcolumn
    redraw
    sleep 150m
    set nocursorline nocursorcolumn
endfunction

" seldom use this, so use C-Space for Unite because it's more useful!
nmap <leader>. :call CursorPing()<CR>
"---end cursor highlight
"===============================================================================

"===============================================================================
"---begin tcomment-vim

" use Ctrl+m to toggle comment/uncomment a block of code
"vmap <C-m> gc

" Disable tComment to escape some entities
"let g:tcomment#replacements_xml={}

"---end tcomment-vim
"===============================================================================


"===============================================================================
"---begin neocomplete {{{

" "disable AutoComplPop
" let g:acp_enableAtStartup = 0


" " disable annoying preview window of the current item in the completion list
" " especially in clojure file
" set completeopt-=preview

" let g:neocomplete#enable_at_startup = 0
" let g:neocomplete#enable_fuzzy_completion = 1
" let g:neocomplete#enable_ignore_case = 1

" let g:neocomplete#max_list = 15
" let g:neocomplete#enable_auto_select = 1

" " Fix keyword length violate min and max value
" " https://github.com/Shougo/neocomplete.vim/issues/359
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"


" " disable omni completion for Clojure because it's so slow!
" if !exists('g:neocomplete#sources#omni#input_patterns')
"     let g:neocomplete#sources#omni#input_patterns = {}
" endif
" let g:neocomplete#sources#omni#input_patterns.clojure = ''

" " comment out the below line because it interfere with delimitMate of auto
" " insert matching brace - 2015-03-12
" " let g:neocomplete#enable_auto_delimiter = 1

" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 4
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" let g:neocomplete#min_keyword_length = 3

" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType eruby,html,markdown,md setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


" " Enable auto display a completion list candidates, but it's slow
" " if !exists('g:neocomplete#force_omni_input_patterns')
" "     let g:neocomplete#force_omni_input_patterns = {}
" " endif
" " let g:neocomplete#force_omni_input_patterns.ruby =
" "     \ '[^. *\t]\.\w*\|\h\w*::'

" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif


" " completefunc of vim-clojure-static interferes with neocomplcache
" " https://github.com/guns/vim-clojure-static/issues/32
" " let g:neocomplcache_force_overwrite_completefunc = 1
" let g:neocomplete#force_overwrite_completefunc = 1

"---end neocomplete }}}
"===============================================================================

"===============================================================================
"---begin neosnippet {{{
"usage:
" C-n or C-p to move around the suggested snippets
" C-k to expand the chosen suggested snippets
" C-k in insert mode to move to next field in the snippets (using Tab is fine
" too)

" Disable runtime snippet
let g:neosnippet#disable_runtime_snippets = { "_": 1, }

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"---end neosnippet }}}
"===============================================================================


"===============================================================================
"---begin vimux {{{
let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"
let g:VimuxPromptString = "Command: "

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vc :VimuxCloseRunner<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run the current file with rspec
map <Leader>vr :call MyVimux()<CR>

" for compiling and running Hadoop
map <Leader>vh :call MyHadoop()<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
" vnoremap <Leader>vs "vy :call VimuxSlime()<CR>
nnoremap <silent> <f7> :call VimuxRunCommand(getline("."))<cr>
vnoremap <silent> <f7> "vy :call VimuxSlime()<CR>

function! MyHadoop()
    call ChangeDirToCurrentBuffer()
    let cp = expand('%:p:h') " current path
    let className = expand('%:t:r')

    let cmd = 'hadoop com.sun.tools.javac.Main ' . className . '.java' .
            \ '; jar cf ' . className . '.jar ' . className . '*.class' .
            \ '; hadoop jar ' . className . '.jar '. className . ' input output'

    " send command to change dir to the shell first
    call VimuxRunCommand('cd ' . cp)

    " then run the actual compile/run command
    call VimuxRunCommand(cmd)
endfunction

" compile and run Java file and optionally feed an input text file
function! MyVimux()
    call ChangeDirToCurrentBuffer()
    let cp = expand('%:p:h') " current path

    " try to split the file name by dash character `-`
    let splitDash = split(expand('%:t:r'), '-')
    let className = splitDash[0] " the first element is always the class's name

    if (&filetype ==? 'cpp')
        let cmd = 'g++ ' . expand('%:p') . ' -o a.cout && ./a.cout'
    elseif (&filetype ==? 'c')
        let cmd = 'gcc -std=c99 ' . expand('%:p') . ' -o a.cout && ./a.cout'
    else
        " now handling Java and its stuff

        if len(splitDash) <= 1
            " the current file should be a Java source code

            " now check if the className has the form of xxxxTest
            if (match(className, 'Test$') > 0)
                let cmd = 'rake "test1[' . className . ']"'
            else
                let cmd = "javac " . className . ".java" .
                    \ "; java -cp " .  cp . " " . className
            endif
        else
            " now the current file is a input text file
            let cmd = "javac " . className . ".java" .
                    \ "; java -cp " .  expand('%:p:h') . " " .
                    \ className . " " . expand('%:t')
        endif
    endif

    " send command to change dir to the shell first
    call VimuxRunCommand('cd ' . cp)

    " then run the actual compile/run command
    call VimuxRunCommand(cmd)
endfunction
"---end vimux }}}
"===============================================================================

"===============================================================================
"---begin rainbow_parentheses {{{
" \ ['black',       'SeaGreen3'], << original at 10th
" change it to yellow
" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['yellow',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]

" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
"---end rainbow_parentheses }}}
"===============================================================================

"===============================================================================
"---begin rainbow {{{
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold',
                \ 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick',
                \ 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/',
                \ 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody',
                \ 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/
                \ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|
                \ input|keygen|link|menuitem|meta|param|source|track|wbr)
                \ [ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"
                \ |'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/
                \ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}
"---end rainbow }}}
"===============================================================================

"===============================================================================
"---begin vim-dispatch {{{
function! MyDispatch()
    call ChangeDirToCurrentBuffer()
    :Dispatch!

    " having problem here, sometime the quickfix window is empty and doesn't
    " contain the output result, or it contains the old (previous output)
    " So, comment it out to avoid misleading result!
    " :Copen
    execute "normal \<c-w>L"
endfunction

autocmd FileType java let b:dispatch = 'javac % && java -cp %:p:h %:t:r'
" nnoremap <F9> :call MyDispatch()<CR>

" automatic open quickfix window to see result
" autocmd QuickFixCmdPost * copen

" <Leader><Enter> only active on quickfix window (qf) and move it to the right
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w>L
"---end vim-dispatch }}}
"===============================================================================


"===============================================================================
"---begin ctrlp {{{
if !exists('g:vscode')
  "Usage:
  "  Once ctrlp appeared: press <c-f> and <c-b> to cycle between modes.

  ""mimic Ctrl+r go to symbol as in Sublime Text
  "ref: https://github.com/subvim/subvim/blob/master/vim/base/vimrc
  "use C-j and C-k or arrow keys to navigate through the result list
  "<c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.

  " Open goto symbol on current buffer
  " update 2014-09-17: use Unite instead of this
  " nmap <Leader>s :MyCtrlPTag<cr>

  "imap <Leader>s<esc>:MyCtrlPTag<cr>


  " function MyCtrlPTag()
  "     let g:ctrlp_prompt_mappings = {
  "     \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  "     \ 'AcceptSelection("t")': ['<c-t>'],
  "     \ }
  "     CtrlPBufTag
  " endfunc
  " com! MyCtrlPTag call MyCtrlPTag()


  " Open goto symbol on all buffers
  nmap <Leader>S :CtrlPBufTagAll<cr>
  "imap <Leader>S<esc>:CtrlPBufTagAll<cr>

  " Exclude files and directories using Vim's wildignore and CtrlP's own
  " g:ctrlp_custom_ignore:
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  " let g:ctrlp_custom_ignore = {
  "    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  "    \ 'file': '\v\.(exe|so|dll)$',
  "    \ 'link': 'some_bad_symbolic_links',
  "    \ }
endif
"---end ctrlp }}}
"===============================================================================

"===============================================================================
"---begin tagbar {{{
noremap <F2> :TagbarToggle<CR>
inoremap <F2> <ESC> :TagbarToggle<CR>
"---end tagbr }}}
"===============================================================================


"===============================================================================
"---begin commentary {{{
"usage:
" gc{motion} comment/uncomment lines that {motion} moves over
" gcc : comment/uncomment the whole line
" gcgc/gcu : uncomment all the current and adjacent commented lines

" default comment style for cpp
"autocmd FileType cpp set commentstring="/*%s*/"

" now use // instead of /*   */
autocmd FileType cpp set commentstring=//\ %s

" for matlab file:
autocmd FileType matlab set commentstring=\%\ %s

" autocmd FileType py set commentstring=#\ %s
"---end commentary }}}
"===============================================================================


"===============================================================================
"---begin syntastic {{{

"use Ctrl+w E to check error
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" disable checking for cpp file type
let g:syntastic_cpp_checkers=['']

let g:syntastic_disabled_filetypes=['html', 'ts']

let g:syntastic_ruby_checkers = ['rubocop', 'mri']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"---end syntastic }}}
"===============================================================================

"===============================================================================
"---begin abolish {{{
"Usage:
"   search and replace "tung le" to "squallltt"
"       :%S/tung le/squallltt/gc
"   other usage:
"       :%Subvert/facilit{y,ies}/building{,s}/g
"       :%Subvert/address{,es}/reference{,s}/g
"
"       Want to turn fooBar into foo_bar? Press crs (coerce to snake_case).
"       MixedCase (crm), camelCase (crc), snake_case (crs), and UPPER_CASE (cru)
"       are all just 3 keystrokes away.

"---end abolish }}}
"===============================================================================

"===============================================================================
"---begin delimitMate {{{
"create line break when pressing enter
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let delimitMate_jump_expansion = 1
"---end delimitMate }}}
"===============================================================================

"===============================================================================
"---begin vim-session {{{
if !exists('g:vscode')
  " let g:session_directory='~/.vim/data/sessions'
  let g:session_directory='~/dev/mylinux/nogit/vimdata/sessions'
  let g:session_autosave = 'yes'
  let g:session_autoload = 'yes'
  let g:session_default_to_last = 1
endif
"---end vim-session }}}
"===============================================================================

"===============================================================================
"---begin vim-simple-todo {{{
" Comment out to use <Space> for folding/unfolding because it's more useful than
" this plugin

let g:simple_todo_map_keys = 0
" nmap <Space>i <Plug>(simple-todo-new)
" " imap <Space>i <Plug>(simple-todo-new)

" nmap <Space>o <Plug>(simple-todo-below)
" " imap <Space>o <Plug>(simple-todo-below)

" nmap <Space>O <Plug>(simple-todo-above)
" " imap <Space>O <Plug>(simple-todo-above)

" nmap <Space>x <Plug>(simple-todo-mark-as-done) :nohl<CR>
" " imap <Space>x <Plug>(simple-todo-mark-as-done)

" nmap <Space>X <Plug>(simple-todo-mark-as-undone) :nohl<CR>
" " imap <Space>X <Plug>(simple-todo-mark-as-undone)

"---end vim-simple-todo }}}
"===============================================================================

"===============================================================================
"---begin markdown {{{
" below section need to be at the bottom of the file, or else the auto bullet in
" markdown will not work

" Set *.md file to be markdown filetype instead of modula2 as default
" autocmd BufRead,BufNew,BufNewFile *.md set filetype=markdown

" http://stackoverflow.com/questions/19211839/markdown-lists-in-vim
autocmd Filetype markdown setlocal com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:-,b:+ | set formatoptions+=tcroqln

" make markdown auto insert list with 1. when possible
autocmd Filetype markdown setlocal com+=b:1.
"---end markdown }}}
"===============================================================================

"===============================================================================
"---begin dragvisuals.vim {{{
" move the whole visual block (select by pressing <C-v>
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1
"---end dragvisuals.vim }}}
"===============================================================================

"===============================================================================
"---begin vim-sexp {{{
" disable automatically producing closing bracket because we already have it
let g:sexp_enable_insert_mode_mappings = 0
"---end vim-sexp }}}
"===============================================================================

"===============================================================================
" setup some aliases {{{
source ~/.config/nvim/bundle/cmdalias.vim/plugin/cmdalias.vim

" View Git log (limit to 9 items) and load previous revision of the current file.
" To disable file filtering (view global Git log) and load commit, append `--`
call CmdAlias('GL', 'silent Glog -i -9 --author= --grep=')
" Vim doesn't expand 2 abbre on the same cmd line?
" call CmdAlias('UQ', 'Unite quickfix -no-quit')
command UQ Unite quickfix -no-quit
" end aliases }}}
"===============================================================================

"===============================================================================
"--- vim-test {{{
function! MyStrategy(cmd)
  let app = '/usr/bin/top'
  rightbelow vnew
  " call termopen(app)
  call termopen(a:cmd)
  startinsert
  echo 'It works! Command for running tests: ' . a:cmd
endfunction

let test#ruby#rspec#options = {
  \ 'nearest': '--color',
  \ 'file':    '--format documentation --color',
\}

" let g:test#custom_strategies = {'my_strategy': function('MyStrategy')}
" let g:test#strategy = 'my_strategy'

let test#strategy = "vimux"

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
"--- end vim-test
"===============================================================================

"===============================================================================
"--- begin neoterm {{{
if has("nvim")
  " DEPRECATED - See |g:neoterm_default_mod|.
  " let g:neoterm_position = 'vertical'

  let g:neoterm_automap_keys = ',tt'

  " nnoremap <silent> <f10> :TREPLSendFile<cr>
  " nnoremap <silent> <f9> :TREPLSend<cr>
  " vnoremap <silent> <f9> :TREPLSend<cr>

  " run set test lib
  " Don't use this to run test, it will cause `segmentation fault (core dumped)`
  " Use `vim-test` plugin to run test instead!
  nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
  nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
  nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
  nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

  " Useful maps
  " hide/close all terminals
  nnoremap <silent> ,th :call neoterm#close_all()<cr>
  " clear terminal
  nnoremap <silent> ,tl :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> ,tc :call neoterm#kill()<cr>

  " Rails commands
  command! Troutes :T rake routes
  command! -nargs=+ Troute :T rake routes | grep <args>
  command! Tmigrate :T rake db:migrate

  " Git commands
  command! -nargs=+ Tg :T git <args>
endif
"--- end neoterm }}}
"===============================================================================

"===============================================================================
"--- begin vim-rest-console {{{
let g:vrc_curl_opts = {
  \ '-sS': '',
  \ '--connect-timeout': 10,
  \}
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_auto_format_uhex = 1
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_auto_format_response_enabled = 1

" using Perl's `/usr/bin/json_pp` to pretty print json result. If `json_pp` is
" not installed, use the python version at `~/bin/jsonpp.py`
let g:vrc_auto_format_response_patterns = {
  \ 'json': 'jsonpp.py',
  \ 'xml': 'xmllint --format -',
  \}
"--- end vim-rest-console }}}
"===============================================================================

"===============================================================================
"--- begin colorscheme {{{
set background=dark

" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_contrast_light='light'

" let g:solarized_termcolors=256
" let g:solarized_contrast = "high"
" let g:solarized_visibility= "high"
" let g:solarized_italic = 1
" let g:solarized_termtrans = 1

" colorscheme gruvbox

" comment out to fix no highligh color on 80th column
" if (has("termguicolors"))
"  set termguicolors
" endif

" Theme
syntax enable
syntax on
" colorscheme OceanicNext
" let g:airline_theme='oceanicnext'
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1

colorscheme onedark
let g:airline_theme='onedark'
"--- end colorscheme }}}
"===============================================================================

let g:ragtag_global_maps = 1

" show quote character in json file!!!
" by default, the quote characters in json file are hidden
let g:vim_json_syntax_conceal = 0


if has("nvim") && !exists('g:vscode')
  " ============= NEOVIM ================ {{{
  " makes the cursor a pipe in insert-mode, and a block in normal-mode
  " let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

  " Use double ESC to go to normal mode in terminal window. We want to reserve a
  " single ESC to use vi editing mode for the line-editor
  tnoremap <Esc><Esc> <C-\><C-n>

  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  " Use smartcase.
  call deoplete#custom#option('smart_case', v:true)

  let g:deoplete#disable_auto_complete = 0

  inoremap <expr><C-y>  deoplete#mappings#close_popup()
  inoremap <expr><C-e>  deoplete#mappings#cancel_popup()

  " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
  set completeopt+=noinsert
  if has("patch-7.4.314")
    set shortmess+=c
  endif

  call deoplete#custom#source('buffer', 'filetypes', ['c', 'cpp'])

  let g:deoplete#omni_patterns = {}
  " let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
  " let g:deoplete#omni_patterns.ruby = ''
  " let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
  let g:deoplete#omni_patterns.rust = '[(\.)(::)]'

  " let g:deoplete#keyword_patterns = {}
  " let g:deoplete#keyword_patterns.ruby = ''

  " end Neovim }}}
endif



"===============================================================================
"--- begin terminal window {{{
if has("nvim")
  function! ToggleTerm()
    " if you close the terminal buffer, then `g:termbuf` exists but it doesn't
    " point to any buffer, so we gotta check `bufexists(g:termbuf)` as well
    if !exists('g:termbuf') || !bufexists(g:termbuf)
      exec "botright vert new"
      call termopen("zsh")
      let g:termbuf=bufnr('%')
      exec "wincmd w"
    else
      " if there is no visible terminal window in the current tab
      if bufwinnr(g:termbuf) < 0
        exec "botright vert new"
        exec g:termbuf . "buffer"
        exec "wincmd w"
      else
        " you can't call `exec g:termbuf."hide"` here
        exec bufwinnr(g:termbuf)."hide"
      end
    endif
  endfunction

  au TermOpen * let g:last_term_job_id = b:terminal_job_id
  function! SendToTerm(lines)
    call jobsend(g:last_term_job_id, add(a:lines, ''))
  endfunction

  function! MySelection(text)
    call SendToTerm(split(a:text, '\n'))
  endfunction

  nnoremap <leader>` :call ToggleTerm()<CR>
  nnoremap <silent> <f9> :call SendToTerm([ getline(".") ])<cr>
  vnoremap <f9> "vy :call MySelection(@v)<cr>
endif

"--- end terminal window }}}
"===============================================================================

" disable annoying additional window with autocomplete in Clojure and Go
set completeopt-=preview

" Rust
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src/"


" Fix death slow with Ruby files
set regexpengine=1


"===============================================================================
"--- begin denite {{{

if !exists('g:vscode')

  " Denite general settings
  call denite#custom#option('_', {
    \ 'prompt': '❯',
    \ 'auto_resume': 1,
    \ 'start_filter': 1,
    \ 'statusline': 1,
    \ 'smartcase': 1,
    \ 'vertical_preview': 0,
    \ 'max_dynamic_update_candidates': 50000,
    \ 'post_action': 'open',
    \ })

  " Interactive grep search
  call denite#custom#var('grep', 'min_interactive_pattern', 2)
  call denite#custom#source('grep', 'args', ['', '', '!'])

  " Use Neovim's floating window
  if has('nvim')
    call denite#custom#option('_', {
      \ 'statusline': 0,
      \ 'floating_preview': 1,
      \ 'filter_split_direction': 'floating',
      \ })
  endif

  " Denite EVENTS
  augroup user_plugin_denite
    autocmd!

    autocmd FileType denite call s:denite_settings()
    autocmd FileType denite-filter call s:denite_filter_settings()
    autocmd User denite-preview call s:denite_preview()

    " autocmd VimResized * call s:denite_resize(g:denite_position)

    " Enable Denite special cursor-line highlight
    " autocmd WinEnter * if &filetype =~# '^denite'
    " 	\ |   highlight! link CursorLine WildMenu
    " 	\ | endif

    " " Disable Denite special cursor-line highlight
    " autocmd WinLeave * if &filetype ==# 'denite'
    " 	\ |   highlight! link CursorLine NONE
    " 	\ | endif
  augroup END

  " Denite main window settings
  function! s:denite_settings() abort
    " Window options
    setlocal signcolumn=no cursorline

    " Denite selection window key mappings
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> /    denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> dd   denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> st   denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> sg   denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> sv   denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> '    denite#do_map('quick_move')
    nnoremap <silent><buffer><expr> q    denite#do_map('quit')
    nnoremap <silent><buffer><expr> r    denite#do_map('redraw')
    nnoremap <silent><buffer><expr> yy   denite#do_map('do_action', 'yank')
    nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
    " nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
  endfunction

  " Denite-preview window settings
  function! s:denite_preview() abort
    " Window options
    setlocal nocursorline colorcolumn= signcolumn=no nonumber nolist nospell

    " if &lines > 35
    " 	resize +8
    " endif
    " let l:pos = win_screenpos(win_getid())
    " let l:heighten = &lines - l:pos[0]
    " execute 'resize ' . l:heighten

    " Clear indents
    if exists('*indent_guides#clear_matches')
      call indent_guides#clear_matches()
    endif
  endfunction

  " Denite-filter window settings
  function! s:denite_filter_settings() abort
    " Window options
    setlocal signcolumn=yes nocursorline nonumber norelativenumber

    " Disable Deoplete auto-completion within Denite filter window
    if exists('*deoplete#custom#buffer_option')
      call deoplete#custom#buffer_option('auto_complete', v:false)
    endif

    " Denite Filter window key mappings
    imap <silent><buffer> jj          <Plug>(denite_filter_quit)
    nmap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
    imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
    nmap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
    imap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
    inoremap <silent><buffer> <Tab>
      \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <S-Tab>
      \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  endfunction

  " denite

  " reset 50% winheight on window resize
  " augroup deniteresize
  "   autocmd!
  "   autocmd VimResized,VimEnter * call denite#custom#option('default',
  "         \'winheight', winheight(0) / 2)
  " augroup end

  call denite#custom#var('file/rec', 'command',
        \ ['fd', '-H', '--full-path'])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--hidden', '--vimgrep', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>',
        \'noremap')
  call denite#custom#map('normal', '<Esc>', '<NOP>',
        \'noremap')
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>',
        \'noremap')
  call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
        \'noremap')
  call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>',
        \'noremap')

  nnoremap <C-p> :<C-u>Denite file/rec<CR>
  " nnoremap <leader>s :<C-u>Denite buffer<CR>
  nnoremap <leader><Space>s :<C-u>DeniteBufferDir buffer<CR>
  nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
  nnoremap <leader>/ :<C-u>Denite grep:. -mode=normal<CR>
  nnoremap <leader><Space>/ :<C-u>DeniteBufferDir grep:. -mode=normal<CR>
  " nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR>
  " nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
  nnoremap <leader><C-r> :<C-u>Denite register:. -mode=normal<CR>
  " references source from LanguageClient
  nnoremap <leader>lr :<C-u>Denite references -mode=normal<CR>

  hi link deniteMatchedChar Special

  nnoremap <space>v :Denite file_rec -default-action=vsplit<cr>
  nnoremap <space>s :Denite file_rec -default-action=split<cr>
  nnoremap <space>e :Denite file_rec -winheight=10 <cr>
  nnoremap <space>m :Denite file_mru -winheight=10 -vertical-preview -auto-preview <cr>
  nnoremap <space>l :Denite line <cr>
endif

"--- end denite }}}
"===============================================================================


"===============================================================================
"--- begin vim-dadbod {{{

" let g:dbs = {
" \  'dev': 'mysql://user:password@host:3306'
" \ }

" For built in omnifunc
autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

" Source is automatically added, you just need to include it in the chain complete list
let g:completion_chain_complete_list = {
    \   'sql': [
    \    {'complete_items': ['vim-dadbod-completion']},
    \   ],
    \ }
" Make sure `substring` is part of this list. Other items are optional for this completion source
let g:completion_matching_strategy_list = ['exact', 'substring']
" Useful if there's a lot of camel case items
let g:completion_matching_ignore_case = 1

let g:db_ui_use_nerd_fonts = 1

"--- end vim-dadbod }}}
"===============================================================================


"===============================================================================
"--- begin fzf {{{
" Ctrl+t : open in new tab
" Ctrl+x : open in new split
" Ctrl+v : open in new vertical split

" git files
nnoremap <leader>f :GFiles<CR>
" Open buffers
nnoremap <leader>b :Buffers<CR>
" rg search result
nnoremap <leader>s :Rg<CR>
" Lines in loaded buffers
nnoremap <leader>l :Lines<CR>
" Git commits of the whole project (requires fugitive.vim)
nnoremap <leader>gc :Commits<CR>
" Git commits for the current buffer; visual-select lines to track changes in the range
nnoremap <leader>gb :BCommits<CR>
" Git files status
nnoremap <leader>gf :GFiles?<CR>
" Search vim's commands
nnoremap <leader>vc :Commands<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

"--- end fzf }}}
"===============================================================================

