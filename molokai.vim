" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

let s:molokai_original = 1


hi Boolean         guifg=#AE81FF gui=NONE
hi Character       guifg=#E6DB74 gui=NONE
hi Number          guifg=#AE81FF gui=NONE
hi String          guifg=#E6DB74 gui=NONE
hi Conditional     guifg=#F92672 gui=NONE
hi Constant        guifg=#AE81FF gui=NONE
hi Cursor          guifg=#000000 guibg=#F8F8F0 gui=NONE
hi iCursor         guifg=#000000 guibg=#F8F8F0 gui=NONE
hi Debug           guifg=#BCA3A3 gui=NONE
hi Define          guifg=#66D9EF gui=NONE
hi Delimiter       guifg=#8F8F8F gui=NONE
hi DiffAdd                       guibg=#13354A gui=NONE
hi DiffChange      guifg=#89807D guibg=#4C4745 gui=NONE
hi DiffDelete      guifg=#960050 guibg=#1E0010 gui=NONE
hi DiffText                      guibg=#4C4745 gui=NONE

hi Directory       guifg=#A6E22E gui=NONE
hi Error           guifg=#E6DB74 guibg=#1E0010 gui=NONE
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=NONE
hi Exception       guifg=#A6E22E gui=NONE
hi Float           guifg=#AE81FF gui=NONE
hi FoldColumn      guifg=#465457 guibg=#000000 gui=NONE
hi Folded          guifg=#465457 guibg=#000000 gui=NONE
hi Function        guifg=#A6E22E gui=NONE
hi Identifier      guifg=#FD971F gui=NONE
hi Ignore          guifg=#808080 guibg=bg gui=NONE
hi IncSearch       guifg=#C4BE89 guibg=#000000 gui=NONE

hi Keyword         guifg=#F92672 gui=NONE
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89 gui=NONE
hi SpecialKey      guifg=#66D9EF gui=NONE

hi MatchParen      guifg=#000000 guibg=#FD971F gui=NONE
hi ModeMsg         guifg=#E6DB74 gui=NONE
hi MoreMsg         guifg=#E6DB74 gui=NONE
hi Operator        guifg=#F92672 gui=NONE

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000 gui=NONE
hi PmenuSel                      guibg=#808080 gui=NONE
hi PmenuSbar                     guibg=#080808 gui=NONE
hi PmenuThumb      guifg=#66D9EF gui=NONE

hi PreCondit       guifg=#A6E22E gui=NONE
hi PreProc         guifg=#A6E22E gui=NONE
hi Question        guifg=#66D9EF gui=NONE
hi Repeat          guifg=#F92672 gui=NONE
hi Search          guifg=#000000 guibg=#FFE792 gui=NONE
" marks
hi SignColumn      guifg=#A6E22E guibg=#232526 gui=NONE
hi SpecialChar     guifg=#F92672 gui=NONE
hi SpecialComment  guifg=#7E8E91 gui=NONE
hi Special         guifg=#66D9EF guibg=bg gui=NONE
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672 gui=NONE
hi StatusLine      guifg=#000000 guibg=#777777 gui=NONE
hi StatusLineNC    guifg=#808080 guibg=#080808 gui=NONE
hi StorageClass    guifg=#FD971F gui=NONE
hi Structure       guifg=#66D9EF gui=NONE
hi Tag             guifg=#F92672 gui=NONE
hi Title           guifg=#ef5939 gui=NONE
hi Todo            guifg=#FFFFFF guibg=bg gui=NONE

hi Typedef         guifg=#66D9EF gui=NONE
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline gui=NONE

hi VertSplit       guifg=#808080 guibg=#080808 gui=NONE
hi VisualNOS                     guibg=#403D3D gui=NONE
hi Visual                        guibg=#403D3D gui=NONE
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=NONE
hi WildMenu        guifg=#66D9EF guibg=#000000 gui=NONE

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E gui=NONE
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822 gui=NONE
   hi Comment         guifg=#75715E gui=NONE
   hi CursorLine                    guibg=#3E3D32 gui=NONE
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#3E3D32 gui=NONE
   hi ColorColumn                   guibg=#3B3A32 gui=NONE
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32 gui=NONE
   hi NonText         guifg=#75715E gui=NONE
   hi SpecialKey      guifg=#75715E gui=NONE
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E gui=NONE
   hi Comment         guifg=#7E8E91 gui=NONE
   hi CursorLine                    guibg=#293739 gui=NONE
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#293739 gui=NONE
   hi ColorColumn                   guibg=#232526 gui=NONE
   hi LineNr          guifg=#465457 guibg=#232526 gui=NONE
   hi NonText         guifg=#465457 gui=NONE
   hi SpecialKey      guifg=#465457 gui=NONE
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   if s:molokai_original == 1
      hi Normal                   ctermbg=234 gui=NONE
      hi CursorLine               ctermbg=235   cterm=none gui=NONE
      hi CursorLineNr ctermfg=208               cterm=none gui=NONE
   else
      hi Normal       ctermfg=252 ctermbg=233 gui=NONE
      hi CursorLine               ctermbg=234   cterm=none gui=NONE
      hi CursorLineNr ctermfg=208               cterm=none gui=NONE
   endif
   hi Boolean         ctermfg=135 gui=NONE
   hi Character       ctermfg=144 gui=NONE
   hi Number          ctermfg=135 gui=NONE
   hi String          ctermfg=144 gui=NONE
   hi Conditional     ctermfg=161 gui=NONE
   hi Constant        ctermfg=135 gui=NONE
   hi Cursor          ctermfg=16  ctermbg=253 gui=NONE
   hi Debug           ctermfg=225 gui=NONE
   hi Define          ctermfg=81 gui=NONE
   hi Delimiter       ctermfg=241 gui=NONE

   hi DiffAdd                     ctermbg=24 gui=NONE
   hi DiffChange      ctermfg=181 ctermbg=239 gui=NONE
   hi DiffDelete      ctermfg=162 ctermbg=53 gui=NONE
   hi DiffText                    ctermbg=102 gui=NONE

   hi Directory       ctermfg=118 gui=NONE
   hi Error           ctermfg=219 ctermbg=89 gui=NONE
   hi ErrorMsg        ctermfg=199 ctermbg=16 gui=NONE
   hi Exception       ctermfg=118 gui=NONE
   hi Float           ctermfg=135 gui=NONE
   hi FoldColumn      ctermfg=67  ctermbg=16 gui=NONE
   hi Folded          ctermfg=67  ctermbg=16 gui=NONE
   hi Function        ctermfg=118 gui=NONE
   hi Identifier      ctermfg=208               cterm=none gui=NONE
   hi Ignore          ctermfg=244 ctermbg=232 gui=NONE
   hi IncSearch       ctermfg=193 ctermbg=16 gui=NONE

   hi keyword         ctermfg=161 gui=NONE
   hi Label           ctermfg=229               cterm=none gui=NONE
   hi Macro           ctermfg=193 gui=NONE
   hi SpecialKey      ctermfg=81 gui=NONE

   hi MatchParen      ctermfg=208  ctermbg=233 gui=NONE
   hi ModeMsg         ctermfg=229 gui=NONE
   hi MoreMsg         ctermfg=229 gui=NONE
   hi Operator        ctermfg=161 gui=NONE

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16 gui=NONE
   hi PmenuSel        ctermfg=255 ctermbg=242 gui=NONE
   hi PmenuSbar                   ctermbg=232 gui=NONE
   hi PmenuThumb      ctermfg=81 gui=NONE

   hi PreCondit       ctermfg=118 gui=NONE
   hi PreProc         ctermfg=118 gui=NONE
   hi Question        ctermfg=81 gui=NONE
   hi Repeat          ctermfg=161 gui=NONE
   hi Search          ctermfg=0   ctermbg=222   cterm=NONE gui=NONE

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235 gui=NONE
   hi SpecialChar     ctermfg=161 gui=NONE
   hi SpecialComment  ctermfg=245 gui=NONE
   hi Special         ctermfg=81 gui=NONE
   if has("spell")
       hi SpellBad                ctermbg=52 gui=NONE
       hi SpellCap                ctermbg=17 gui=NONE
       hi SpellLocal              ctermbg=17 gui=NONE
       hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse gui=NONE
   endif
   hi Statement       ctermfg=161 gui=NONE
   hi StatusLine      ctermfg=238 ctermbg=253 gui=NONE
   hi StatusLineNC    ctermfg=244 ctermbg=232 gui=NONE
   hi StorageClass    ctermfg=208 gui=NONE
   hi Structure       ctermfg=81 gui=NONE
   hi Tag             ctermfg=161 gui=NONE
   hi Title           ctermfg=166 gui=NONE
   hi Todo            ctermfg=231 ctermbg=232 gui=NONE

   hi Typedef         ctermfg=81 gui=NONE
   hi Type            ctermfg=81                cterm=none gui=NONE
   hi Underlined      ctermfg=244               cterm=underline gui=NONE

   hi VertSplit       ctermfg=244 ctermbg=232 gui=NONE
   hi VisualNOS                   ctermbg=238 gui=NONE
   hi Visual                      ctermbg=235 gui=NONE
   hi WarningMsg      ctermfg=231 ctermbg=238 gui=NONE
   hi WildMenu        ctermfg=81  ctermbg=16 gui=NONE

   hi Comment         ctermfg=59 gui=NONE
   hi CursorColumn                ctermbg=236 gui=NONE
   hi ColorColumn                 ctermbg=236 gui=NONE
   hi LineNr          ctermfg=250 ctermbg=236 gui=NONE
   hi NonText         ctermfg=59 gui=NONE

   hi SpecialKey      ctermfg=59 gui=NONE

   if exists("g:rehash256") && g:rehash256 == 1
       hi Normal       ctermfg=252 ctermbg=234 gui=NONE
       hi CursorLine               ctermbg=236   cterm=none gui=NONE
       hi CursorLineNr ctermfg=208               cterm=none gui=NONE

       hi Boolean         ctermfg=141 gui=NONE
       hi Character       ctermfg=222 gui=NONE
       hi Number          ctermfg=141 gui=NONE
       hi String          ctermfg=222 gui=NONE
       hi Conditional     ctermfg=197 gui=NONE
       hi Constant        ctermfg=141 gui=NONE

       hi DiffDelete      ctermfg=125 ctermbg=233 gui=NONE

       hi Directory       ctermfg=154 gui=NONE
       hi Error           ctermfg=222 ctermbg=233 gui=NONE
       hi Exception       ctermfg=154 gui=NONE
       hi Float           ctermfg=141 gui=NONE
       hi Function        ctermfg=154 gui=NONE
       hi Identifier      ctermfg=208 gui=NONE

       hi Keyword         ctermfg=197 gui=NONE
       hi Operator        ctermfg=197 gui=NONE
       hi PreCondit       ctermfg=154 gui=NONE
       hi PreProc         ctermfg=154 gui=NONE
       hi Repeat          ctermfg=197 gui=NONE

       hi Statement       ctermfg=197 gui=NONE
       hi Tag             ctermfg=197 gui=NONE
       hi Title           ctermfg=203 gui=NONE
       hi Visual                      ctermbg=238 gui=NONE

       hi Comment         ctermfg=244 gui=NONE
       hi LineNr          ctermfg=239 ctermbg=235 gui=NONE
       hi NonText         ctermfg=239 gui=NONE
       hi SpecialKey      ctermfg=239 gui=NONE
   endif
end

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
