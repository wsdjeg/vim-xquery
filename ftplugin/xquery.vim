" Vim filetype plugin file
" Language:	    XQuery
" Maintainer:	David Lam <dlam@dlam.me>
" Last Change:  2011 Jun 2
"
" Notes: 
"    -Makes keys like gd and <C-]> work better when editing XQuery files 
"     by temporarily adding the hyphen - to the 'iskeyword' variable
"     (one could add it to 'iskeyword' permanently... but that makes the 
"     basic movement keys move a bit too far)
"
"    -Sets options that are useful when editing XQuery (like 'set comments')

"    -Sets a few variables to make matchit.vim and taglist.vim work 
"     better with XQuery
"
"    -Sets the omnicomplete function to xquerycomplete.vim, which completes 
"     XQuery keywords and function names from 
"     http://developer.marklogic.com/learn/4.1/api-reference
"


" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1
setlocal comments=sr:(:,mb::,ex::)
setlocal formatoptions=croq
setlocal textwidth=78
" Comment blocks always start with a (: and end with a :)
" Works for XQDoc style start comments like (:~ too.
setlocal comments=s1:(:,mb::,ex::)
setlocal commentstring=(:%s:)

" Format comments to be up to 78 characters long  (from vim.vim)
" if &tw == 0
"   setlocal tw=78
" endif

" Set 'formatoptions' to break comment lines but not other lines,  
" and insert the comment leader when hitting <CR> or using "o".     
"    see...  :h fo-table
setlocal formatoptions-=t formatoptions+=croql



" http://markmail.org/message/5vfzrb7ojvds5drx
autocmd InsertEnter *.xqy,*.xql,*.xqe,*.xq set iskeyword+=-
autocmd InsertLeave *.xqy,*.xql,*.xqe,*.xq set iskeyword-=-
"imap <C-c> <ESC>   "Because <C-c> dosent trigger InsertLeave (see help) 
inoremap <C-c> <C-c>:set isk-=-<cr>

"12/1/2010  Because XQueryTag() does not trigger InsertLeave when you come back
"           to the buffer you made the jump in via i_Ctrl-T or i_Ctrl-O or something
autocmd BufEnter *.xqy,*.xql,*.xqe,*.xq set iskeyword-=-   



"  these from :h write-filetype-plugin
"
" Add mappings, unless the user didn't want this.
if !exists("no_plugin_maps") && !exists("no_mail_maps")

    if !hasmapto('xquery#XQueryTag')
        noremap <buffer> <C-]> :call xquery#XQueryTag(0)<CR>
        noremap <buffer> g<C-]> :call xquery#XQueryTag(1)<CR>
    endif

    if !hasmapto('xquery#XQueryGotoDeclaration')
        noremap <buffer> gd :call xquery#XQueryGotoDeclaration(0)<CR>
        noremap <buffer> gD :call xquery#XQueryGotoDeclaration(1)<CR> 
    endif

    if !hasmapto('xquery#Star')
        noremap <buffer> # :call xquery#Star(0)<CR>
        noremap <buffer> * :call xquery#Star(1)<CR>
    endif

    "     if !hasmapto('xqueryft:BracketI')
    "         noremap <buffer> [i :call xquery#BracketI(0)<CR>
    "         noremap <buffer> [I :call xquery#BracketI(1)<CR>
    "     endif

endif

if exists('&ofu')
    setlocal omnifunc=xquery#omni#complete
endif

" from html.vim
if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
                \ '(:),' .
                \ '{:},' .
                \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
                \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
                \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

let b:undo_ftplugin = 'setlocal formatoptions<'
            \  . ' comments< commentstring< omnifunc<'
            \  . ' shiftwidth< tabstop<' 


" vim:sw=4 fdm=marker tw=80
