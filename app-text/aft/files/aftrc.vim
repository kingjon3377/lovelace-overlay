"As far as I know from reading the vim list, etc., there is no way
"of getting rid of the extra spaces. Either backspace or hit
"Ctrl-] once you have unambiguously determined the abbreviation.
"For targets and references you must have no surrounding spaces.

iab ,i *Image:
iab ,l *Image-left:
iab ,r *Image-right:
iab ,c *Image-center:
iab ,C C---
iab ,# #---
iab ,t #---TABSTOP=
iab {+ {++}<ESC>F+i
iab {- {--}<ESC>F-i
iab }+ }++{<ESC>F+i
iab }- }--{<ESC>F-i
iab ,^ ^<<<CR><CR>^>><ESC>^ki
