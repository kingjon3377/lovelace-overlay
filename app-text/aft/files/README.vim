"Author: David Bourgeois: dbourgeo@thezone.net
"Located: http://home.thezone.net/~dbourgeo/

"Here is an example like what I have in my vimrc (really .vimrc) to use aft
"abbreviations (you can add functions as well). Actually, I have a couple of
"different file types, and I also separate out the BufEnter and BufNewFile to
"use different rc files (separate lines), as for some filetypes I do different
"things for a new file (run scripts to initialize it). You can use pretty
"complete regular expressions here.

" D.B. Sat Feb 16 15:52:01 NST 2002
" Autocommands for various filetypes. Right now, its aft.
autocmd BufEnter,BufNewFile *.aft ~/.vim/aftrc
autocmd BufLeave *.aft ~/.vim/noaftrc

"Files included:
"aft.vim:         aft syntax file
"aftrc:           aft abbreviations
"noaftrc:         undo those abbreviations
"syntax-demo.aft: demo
"syntax-demo.jpg: screenshot of vim in action
