" Vim syntax file
" Language:    AFT
" Maintainers: David Bourgeois <dbourgeo@thezone.net>
" Last Change: 2002 March 6

" The main caveat is that hilighting indicates certain character sequences.
" They may or may not be meaningful, depending on context. In addition,
" some character sequences can color out others (usually contained), even
" when they might be meaningful. I.E. if *bold* were colored red, but
" contained in another syntax element, it won't be red. Since lots of things
" can contain lots of other things, this is a limitation unless we are willing
" to write a lot of "contains" statements and debug them.

" There are various methods for loading the syntax file. You could just
" ":source" it, or use the vim comment method. Better, see ":he syntax"
" on how to automate the file for all "*aft" files, say.

" The method I use requires root access (on unix), usually, to something
" like /usr/share/vim/vim56. Put THIS file in $VIMRUNTIME/syntax/.
" Edit $VIMRUNTIME/syntax/synload.vim and add a line: "SynAu aft".
" Finally, edit $VIMRUNTIME/filetype.vim and add a line:
"   :autocmd BufRead,BufNewFile *.aft set ft=aft
" You can change "*.aft" to whatever scheme you like. Eg. *.aft,minutes*.txt
" I don't know what to do with vim 6.

" General blathering comments.
" ----------------------------
" I'm a newbie to vim, so this is far from perfect, but provides useful
" 'reminders' that work for me. Use the syntax coloring as guidance only. After
" you get used to it, I hope you find it useful. Any help in improving this
" would be much appreciated. I tried several different detailed routes that
" really taxed the syntax system (and my understanding of it), and short of
" writing an aft parser in the syntax system (REALLY unsuited for this), or the
" obverse of settling on highlighting a few 'keywords' and other simple items,
" this will do for my purposes.

" Also, short of writing tedious functions that somehow construct a syntax
" file, I see no elegant way of accounting for various tab sizes. The 
" only possibility I could see, on somewhat cursory inspection, would be to
" use a set command to inform this file of the desired tab size and copy all
" the relevant code into 'if' blocks for each desired tab size (3,4,8, etc.),
" with the regular expressions suitably changed about.
" You would then set a variable via the set command, such as aft_tabstops.

" N.B. This file needs #---TABSTOP=3.
" Also, you can see a demo of the syntax in syntax-demo.aft.

" Remove any old syntax stuff hanging around.
syn clear

" Aft is case sensitive, when you are matching comment constructs.
syn case match
syn sync ccomment maxlines=50

"Sections and stuff.
"-------------------
syn match aftSection /^\*\{1,4}/ 
syn match aftSection /^\*Title:/
syn match aftSection /^\*Author:/
"Note, other text right after TOC gets eaten, so OK.
syn match aftSection /^\*TOC/
syn match aftSection /^\*Image:/
syn match aftSection /^\*Image-left:/
syn match aftSection /^\*Image-right:/
syn match aftSection /^\*Image-center:/
syn match aftSection /^\*Include:/
syn match aftSection /^\*Insert:/

"Tab modes.
"Continuation mode, verbatim mode.
"---------------------------------
"You can be in tab mode without the hilight showing, owing to the one character
"hilight. This is just here as a slightly helpful reminder, and I find a full
"line annoying. (It also can cause later regions to bleed.)
"We won't even get into whether a single or double tabbed bullet, etc., is
"supposed to be a bullet or something else, depending on the situation. It's
"just flagged as a potential bullet. Likewise, something colored as centred
"may not be (eg. it may be a continuation), we are really marking that
"there are one or two tabs or more in front, that's all.
"Also, we won't mark a hard tab followed by tabstob number of spaces.

"If you don't want this, comment out the two syn aftTab lines below.

"N.B. Change {3} to {8} for regular tabs (spaces). \t, of course, stands
"for a tab.

"Match general tab, continuation mode. Causes funny face stuff.
"(Only if the face character starts directly after a tab.)
"Hence, the weird regexp. Note minor error with the single ' for italic
"in hilighting faces. (Two chars will mark the tabbed column.)
"The characters: },{, and % won't be colored in any tab position.
syn match aftTab /^\( \{3}\|\t\)\('[^']\|[^_'|~}{%]\)/
syn match aftTab /^\( \{3}\|\t\)\(\(mailto\)\|\(ftp\)\|\(http[s]*\)\|\(file\)\)/

"-- Centred line mode. --
"Should be before all other tab modes. Again, eg. lines that start
"with a face etc. won't be colored centered, even though they are, else
"you get bleeding for these regions. Again, I highlight an extra
"char for targets and references, similar to italics in general 
"tab mode. Also, a plain number won't be hilighted, even though centered.
"Likewise, plain } (not }+, etc.). Generally, both ends of the target or ref.
"will light up in all positions.

"All somewhat crufty. (If you left out the tab and centre matches, would
"be pretty consistent coloring.)

"Comment out these two lines if you don't want centre hilighting.
"Note, it finds double tabbing, right....
syn match aftCenter /^\( \{6}\|\t\t\)\('[^']\|[^_'|~}{%]\)/
syn match aftCenter /^\( \{6}\|\t\t\)\(\(mailto\)\|\(ftp\)\|\(http[s]*\)\|\(file\)\)/

"-- Tab list modes. --
" The next three allow multiple levels of indent.
syn match aftList   /^\( \{3}\|\t\)\+[0-9]\+[.)]/
syn match aftBullet /^\( \{3}\|\t\)\+\*\{1}/
"Need both halves of the named list bracket.
syn region aftNamed oneline matchgroup=aftParen start=/^\( \{3}\|\t\)\+\[/
    \ end=/]/ 
"-- Other Tab modes --
"Back to one level of indent.
syn match aftQuote /^\( \{3}\|\t\)\#\{1}/
syn match aftTable /^\( \{3}\|\t\)\!\{1}/


"Literal mode. Not worried about font etc. hilighting (allowed only if
"the Filter mode is on, we hilight in either case).
"---------------------------------------------------------------------
syn region aftLiteral start=/^^<<\(Filter\)*/ end=/^^>>/

"Comment-like things. Includes PASS and TABSTOP.
"-----------------------------------------------
syn match aftComment /^[#C]---.*$/
syn match aftComment /^----.*$/

"Face changes.
"-------------
"Again, a face may not apply if its in a verbatim mode, etc.
"Won't bother matching entire paragraphs. More work. Will match
"the characters by themselves, though. (This needs to be first.)
"Generally, the outer face wins. (Also applies to links and targets.)
syn match  aftParen /[_|~]\|''/
syn match  aftSet /%\S\+%/
syn region aftBold    matchgroup=aftParen start=/_/  skip=/__/  end=/_/ oneline
syn region aftItalics matchgroup=aftParen start=/''/ skip=/''''/ end=/''/ 
    \ oneline 
syn region aftTele  matchgroup=aftParen start=/|/ skip=/||/ end=/|/ oneline
syn region aftSmall matchgroup=aftParen start=/\~/
    \ skip=/\~\~/ end=/\~/ oneline
"Watch out for http /~. Hilight starts at the end. There could be other
"gotchas like this. I am a Pooh of small brain.
syn region aftSmall start=/\/\~/hs=s+2 end=/.\{-}/ oneline


"Targets and References.
"-----------------------
syn region aftTarget matchgroup=aftParen oneline start=/}+/ end=/+{/ 
syn region aftTarget matchgroup=aftParen oneline start=/}-/ end=/-{/
syn region aftRefer  matchgroup=aftParen oneline start=/{+/ end=/+}/
syn region aftRefer  matchgroup=aftParen oneline start=/{-/ end=/-}/

"Plain Old URL Targets.
"----------------------
syn keyword aftPOURL http https ftp mailto file

"Tab size stub.
if exists("aft_tabstops")
   " Need to be able to deal with different tabstop sizes.
   " You could branch depending on the value of aft_tabstops.
   " A reminder stub for now. You would have to reproduce the
   " entire tab section for each tab size AFAIK.
endif

if !exists("did_aft_syntax_inits")
  " The default methods for highlighting.  Can be overridden later
  " Or you can enter in the colors directly: see ":he syntax".
  let did_aft_syntax_inits = 1
  hi link aftSection Statement
  hi link aftCenter Identifier 
  hi link aftTab Identifier
  hi link aftList Statement 
  hi link aftBullet Statement
  hi link aftNamed Statement
  hi link aftParen Constant
  hi link aftQuote Statement
  hi link aftTable Statement
  hi link aftLiteral Special
  hi link aftComment Comment
  hi link aftBold Type
  hi link aftItalics Type
  hi link aftTele Type
  hi link aftSmall Type
  hi link aftTarget Special
  hi link aftRefer Special
  hi link aftPOURL Identifier
  hi link aftSet Constant 
  hi link aftIgnore Ignore
endif

let b:current_syntax = "aft"

" vim: ts=28
