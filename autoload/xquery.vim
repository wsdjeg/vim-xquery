function! xquery#XQueryTag(is_tjump)

    set iskeyword+=-

    let l:is_xqVariable = synIDattr(synID(line('.'), col('.'), 0), "name") == 'xqVariable'

    let l:word_at_cursor = expand("<cword>")
    let l:WORD_at_cursor = expand("<cWORD>")

    "remove the namespace: part from word_at_cursor

    let l:dollar_index = match(l:word_at_cursor, '$')
    let l:colon_index  = match(l:word_at_cursor, ':')
    let l:word_at_cursor_without_namespace = strpart(word_at_cursor, l:colon_index)

    " if l:word_at_cursor appears to be a function namespace, set it to be
    " the function name so we can tagjump to it
    "
    if matchstr(l:WORD_at_cursor, l:word_at_cursor.':') != ""

        let l:orig_col = getpos('.')[2]
        call search(':')
        let l:word_at_cursor = expand("<cword>")
        " go back to where we were
        call cursor(line('.'), l:orig_col)
    endif

    " finally... do the tag jump 

    let l:tagtojumpto = (colon_index != -1) ? l:word_at_cursor_without_namespace :  l:word_at_cursor

    exec (a:is_tjump ? "tjump " : "tag ") . l:tagtojumpto

    set iskeyword-=-
endfunction


"  :h gd     
"  :h searchdecl()     searchdecl(expand("<cword>"), 0, 0)
"
function! xquery#XQueryGotoDeclaration(is_goto_global)
    set iskeyword+=- | let @/='\<'.expand('<cword>').'\>' | set iskeyword-=- 

    if a:is_goto_global
        call searchdecl(@/, 1, 0)
    else
        call searchdecl(@/, 0, 0)
    endif

    "execute "match Search /" . @/ . "/"
    normal n
    normal N
endfunction 
function! xquery#Star(goforward)
    set iskeyword+=- | let @/='\<'.expand('<cword>').'\>' | set iskeyword-=- 
    if a:goforward
        normal! n 
    else 
        normal! N
    endif
endfunction

function! xquery#BracketI(iscapital)
    set iskeyword+=- 

    " TODO  find function equivalent for [i and [I 

    set iskeyword-=- 
endfunction
