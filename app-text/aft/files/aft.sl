% File:          aft.sl      -*- mode: SLang -*-
%
% Author:        Guido Gonzato, <guido.gonzato@univr.it>
% Version:       1.0.8
% Date:          9 January 2004
%
% Description:   This mode is designed to facilitate the task of editing
%                AFT files. AFT (Almost Free Text) is a document
%                preparation system, please visit
%                http://www.maplefish.com/todd/aft.html
%                for details.
%
% Installation:  copy aft.sl JED_ROOT/lib, then add these lines to .jedrc:
%
%                  autoload ("aft_mode", "aft");
%                  add_mode_for_extension ("aft", "aft");
%                  enable_dfa_syntax_for_mode ("aft");

% -----


autoload ("tex_insert_quote", "texcom");
custom_variable ("view_html_cmd", "mozilla");

variable aft_buf, aft_file, aft_file_dir;

static variable
  TRUE = 1,
  FALSE = 0,
  is_bullet_list = FALSE,
  is_enumerated_list = FALSE,
  is_named_list = FALSE,
  is_table = FALSE;

% -----

static define aft_paragraph_separator ()
{
  bol_skip_white ();
  eolp () or
    ffind ("|") or ffind ("''") or ffind ("_") or % character styles
    ffind ("*") or % lists
    ffind ("^>>") or % verbatim
    ffind ("["); % links
}


% -----

static define aft_insert_pair_around_region (left, right)
{
  exchange_point_and_mark ();
  insert (left);
  exchange_point_and_mark ();
  insert (right);
  pop_spot ();
  pop_mark_0 ();
}

% -----

define aft_insert_tags (tag1, tag2, do_push_spot, do_pop_spot)
{
  variable
    chr = what_char (),
    tmp = get_word_chars ();
  if ('\\' == chr)
    chr = 'x'; % avoid the \ problem
  % if the current position is within a word, then select it
  if ( (0 == markp ()) and % no region defined
       (0 == string_match (" \t\n", char (chr), 1)) ) {
    % ok, the cursor isn't on a space
    () = right (1);
    define_word ("_0-9A-Za-z\\");
    bskip_word ();
    push_mark ();
    skip_word ();
    define_word (tmp);
  }
  % if a region is defined, insert the tags around it
  if (markp () ) {
    aft_insert_pair_around_region (tag1, tag2);
    return;
  }
  % the remaining cases
  insert (tag1);
  if (do_push_spot)
    push_spot ();
  insert (tag2);
  if (do_pop_spot)
    pop_spot ();
}

% -----

define aft_named_item ()
{
  is_named_list = TRUE;
  insert ("\n\t[");
  push_spot ();
  insert ("] ");
  pop_spot ();
}

define aft_bullet_item ()
{
  is_bullet_list = TRUE;
  insert ("\n\t* ");
}

define aft_enumerated_item ()
{
  is_enumerated_list = TRUE;
  insert ("\n\t#. ");
}

define aft_table_row ()
{
  is_table = TRUE;
  insert ("\n\t! ");
}

% -----

define aft_return ()
{
  % normal situation
  if ( (FALSE == is_enumerated_list) and
       (FALSE == is_named_list) and
       (FALSE == is_bullet_list) and
       (FALSE == is_table) ) {
    insert ("\n");
    return;
  }
  if (1 == what_column) { % switch off list modes
    is_enumerated_list = FALSE;
    is_named_list = FALSE;
    is_bullet_list = FALSE;
    is_table = FALSE;
    insert ("\n");
    return;
  }
  if (is_bullet_list)
    aft_bullet_item ();
  if (is_enumerated_list)
    aft_enumerated_item ();
  if (is_named_list)
    aft_named_item ();
  if (is_table)
    aft_table_row ();
}

% -----

define aft_table_template ()
{
  push_spot ();
  insert ("\n#---SET-CONTROL tableparser=new\n");
  insert ("\t! Sample Table!\n");
  insert ("\t!-------------!\n");
  insert ("\t! 1 ! 2 ! 3   !\n");
  insert ("\t!-------------!\n");
  pop_spot ();
}

% ----- Converting

define aft_convert (format, autonumber)
{
  variable
    fmt,
    tmp = "aft ",
    out_file = extract_element (aft_file, 0, '.') + "." + format;
  !if (strcmp (format, "tex"))
    fmt = "LaTeX";
  else
    fmt = format;
  flush ("Converting to " + fmt + "...");
  save_buffer ();
  if (autonumber)
    tmp = tmp + "--autonumber --type=";
  else
    tmp = tmp + "--type=";
  if (0 == run_shell_cmd (tmp + format + " " +
                          dircat (aft_file_dir, aft_file)))
    flush ("File " +
           dircat (aft_file_dir, out_file) + 
           " written successfully.");
  else
    error ("Errors occurred running aft!");
}

% ----- Document structure

static variable
  AFT_Tree_Buffer = "*structure*",
  line_mark;

% -----

static define getline ()
{
  variable line, numline;
  push_mark ();
  eol ();
  line = bufsubstr ();
  pop_mark_0 ();
  numline = what_line ();
  return (line, numline);
}

% -----

define goto_source_line ()
{
  variable line, tmp = get_word_chars ();
  % extract the line number
  bol ();
  define_word ("0-9");
  skip_word ();
  push_mark ();
  bskip_word ();
  line = integer (bufsubstr ());
  sw2buf (aft_file);
  goto_line (line);
  % bob ();
  % () = down (line - 1);
  define_word (tmp);
}

% -----

% this one creates the buffer that contains the
% document tree (structure)
define aft_build_doc_tree ()
{
  variable i, found, line, numline,
    num_sections = 0, level = -1,
    sections = String_Type [4];
  
  sw2buf (AFT_Tree_Buffer);
  set_readonly (0);
  erase_buffer ();
  insert ("Document structure ('q' to quit, <Ret> or double click to select):\n\n");
  push_spot ();
  
  sections [0] = "^\\*[^\\*]";
  sections [1] = "^\\*\\*[^\\*]";
  sections [2] = "^\\*\\*\\*[^\\*]";
  sections [3] = "^\\*\\*\\*\\*";
  
  % now, let's search for sectioning commands.
  % The algorithm is horrible, but it works and is probably more
  % efficient than the "right" one.
  
  for (i = 0; i < 4; i++) {
    sw2buf (aft_buf);
    bob ();
    do {
    
      found = FALSE;
      sw2buf (aft_buf);
      if (0 != re_fsearch (sections [i])) {
        if (-1 == level)
          level = i; % first level of indentation
        if (0 == bfind ("%")) { % not in a comment
          (line, numline) = getline ();
          num_sections++;
          sw2buf (AFT_Tree_Buffer);
          vinsert ("%6d%s", numline, "   ");
          insert_spaces ((i - level + 1) * 2);
          insert (line + "\n");
        }
        found = TRUE;
        () = down (1);
      }
    } while (TRUE == found);
  }
  
  % ok, the tree is done; let's sort it
  sw2buf (AFT_Tree_Buffer);
  bob ();
  () = down (2);
  push_mark ();
  () = down (num_sections - 1);
  skip_word ();
  sort ();
  pop_mark_0 ();
  set_readonly (1);
  setbuf_info (getbuf_info () & 0xFE); % not modified
  sw2buf (aft_buf);
  pop_spot ();
}

% -----

static define update_tree_hook ()
{
  line_mark = create_line_mark (color_number ("menu_selection"));
}

% -----

define aft_browse_tree ()
{
  variable tmode = "tree";
  !if (keymap_p (tmode))
    make_keymap (tmode);
  create_syntax_table (tmode);
  define_syntax ("0-9", '0', tmode); % numbers
  define_syntax ("*", ',', tmode);   % start of section '*'
  % keys
  definekey ("delbuf (whatbuf()); pop_spot", "q", tmode);
  definekey ("goto_source_line", "\r", tmode);
  push_spot ();
  aft_build_doc_tree ();
  sw2buf (AFT_Tree_Buffer);
  set_buffer_hook ("update_hook", &update_tree_hook);
  set_readonly (1);
  use_keymap (tmode);
  set_mode (tmode, 0);
  use_syntax_table (tmode);
  set_buffer_hook ("mouse_2click", "goto_source_line");
}

% ----- view LaTeX source

define aft_view_latex ()
{
  variable latex_file =
    path_sans_extname (dircat (aft_file_dir, aft_file)) + ".tex";
  if (0 == file_status (latex_file)) {
    beep ();
    flush ("LaTeX file not found!");
    usleep (1000);
    aft_convert ("tex", TRUE);
  }
  find_file (latex_file);
}


% ----- view HTML

define aft_view_html ()
{
  variable html_file =
    path_sans_extname (dircat (aft_file_dir, aft_file)) + ".html";
  if (0 == file_status (html_file)) {
    beep ();
    flush ("HTML file not found!");
    usleep (1000);
    aft_convert ("html", TRUE);
  }
  flush ("Viewing " + html_file + "...");
  system (view_html_cmd + " " + html_file + "&");
}

% ----- Menus

static define init_menu (menu)
{
  % Sections
  menu_append_popup (menu, "&Sections");
  $1 = sprintf ("%s.&Sections", menu);
  menu_append_item ($1, "*&Title:", "insert (\"*Title: \");");
  menu_append_item ($1, "*&Author:", "insert (\"*Author: \");");
  menu_append_item ($1, "*&TOC:", "insert (\"*TOC\\n\");");
  menu_append_item ($1, "*&Image:", "insert (\"*Image: \");");
  menu_append_item ($1, "*Image-&left:", "insert (\"*Image-left: \");");
  menu_append_item ($1, "*Image-&center:", "insert (\"*Image-center: \");");
  menu_append_item ($1, "*Image-&left:", "insert (\"*Image-left: \");");
  menu_append_item ($1, "&Section", "insert (\"* \");");
  menu_append_item ($1, "S&ubsection", "insert (\"** \");");
  menu_append_item ($1, "Su&bsubsection", "insert (\"*** \");");
  menu_append_item ($1, "&Paragraph", "insert (\"**** \");");
  menu_append_item ($1, "&Comment", "insert (\"#--- \");");
  % Lists
  menu_append_popup (menu, "&Lists");
  $1 = sprintf ("%s.&Lists", menu);
  menu_append_item ($1, "&Enumerated", "aft_enumerated_item");
  menu_append_item ($1, "&Bullet", "aft_bullet_item");
  menu_append_item ($1, "&Named", "aft_named_item");
  % Styles
  menu_append_popup (menu, "St&yles");
  $1 = sprintf ("%s.St&yles", menu);
  menu_append_item ($1, "&Bold", "aft_insert_tags (\"_\", \"_\", 1, 1)");
  menu_append_item ($1, "&Italics", "aft_insert_tags (\"''\", \"''\", 1, 1)");
  menu_append_item ($1, "&Small", "aft_insert_tags (\"~\", \"~\", 1, 1)");
  menu_append_item ($1, "&Typewriter",
                    "aft_insert_tags (\"|\", \"|\", 1, 1)");
  menu_append_item ($1, "&Quoted", "insert (\"\t# \");");
  menu_append_item ($1, "&Centered", "insert (\"\t\t\");");
  menu_append_item ($1, "&Tabbed Verbatim", "insert (\"\t \");");
  menu_append_item ($1, "&Literal",
                    "aft_insert_tags (\"^<<\\n\", \"^>>\", 1, 1);" +
                    " () = up (1)");
  menu_append_item ($1, "&Filtered Literal",
                    "aft_insert_tags (\"^<<Filter\\n\\n\", \"^>>\", 1, 1);" +
                    " () = up (1)");
  menu_append_item ($1, "&Page Break", "insert (\"\")");
  menu_append_item ($1, "Li&ne", "insert (\"----\\n\")");
  % Links
  menu_append_popup (menu, "Lin&ks");
  $1 = sprintf ("%s.Lin&ks", menu);
  menu_append_item ($1, "&Visible Target",
                    "aft_insert_tags (\"=[\", \"]=\", 1, 1)");
  menu_append_item ($1, "&Invisible Target",
                    "aft_insert_tags (\"=[(\", \")]=\", 1, 1)");
  menu_append_item ($1, "&Reference",
                    "aft_insert_tags (\"[\", \"target]\", 1, 1)");
  % Table
  menu_append_popup (menu, "&Table");
  $1 = sprintf ("%s.&Table", menu);
  menu_append_item ($1, "&Table Template", "aft_table_template");
  menu_append_item ($1, "Table &Row", "aft_table_row");
  % Pragmas
  menu_append_popup (menu, "&Pragmas");
  $1 = sprintf ("%s.&Pragmas", menu);
  menu_append_item ($1, "#---PASS-HTML", "insert (\"#---PASS-HTML \");");
  menu_append_item ($1, "#---PASS-LaTeX", "insert (\"#---PASS-LaTeX \");");
  menu_append_item ($1, "#---PASS-RTF", "insert (\"#---PASS-RTF \");");
  menu_append_item ($1, "#---SET x=y", "insert (\"#---SET x=y\");");
  menu_append_item ($1, "#---SET-HTML x=y",
                    "insert (\"#---SET-HTML x=y\");");
  menu_append_item ($1, "#---SET-LaTeX x=y",
                    "insert (\"#---SET-LaTeX x=y\");");
  menu_append_item ($1, "#---SET-RTF x=y",
                    "insert (\"#---SET-RTF x=y\");");
  menu_append_item ($1, "#---SET-CONTROL verbatimsquarebrackets=yes",
                    "insert (\"#---SET-CONTROL " + 
                    "verbatimsquarebrackets=yes\");");
  menu_append_item ($1, "#---TABSTOP=", "insert (\"#---TABSTOP= \");");
  menu_append_separator (menu);
  menu_append_item (menu, "&Document Structure", "aft_browse_tree");
  menu_append_item (menu, "Convert to &HTML",
                    "aft_convert (\"html\", 1)");
  menu_append_item (menu, "Convert to HTML (&unnumbered)",
                    "aft_convert (\"html\", 0)");
  menu_append_item (menu, "Convert to &LaTeX",
                    "aft_convert (\"tex\", 0)");
  menu_append_item (menu, "Convert to &RTF",
                    "aft_convert (\"rtf\", 1)");
  menu_append_item (menu, "Convert to L&out",
                    "aft_convert (\"lout\", 1)");
  menu_append_item (menu, "View HTML", "aft_view_html");
   menu_append_item (menu, "View LaTeX", "aft_view_latex");
}

% ----- Final stuff

$1 = "aft";
create_syntax_table ($1);

define_syntax ("-*0-9A-Za-z:/[]", 'w', $1); % words
define_syntax ("#0-9", '0', $1);            % numbers
define_syntax ("#---", "", '%', $1);        % comments
define_syntax ("%_|~=[!", ',', $1);         % delimiters
set_syntax_flags ("aft", 0x04);

!if (keymap_p ($1))
  make_keymap ($1);
USE_TABS = 1;
WRAP_INDENTS = 1;
Tab_Always_Inserts_Tab = 1;

definekey ("call (\"self_insert_cmd\")", "^I", $1);
definekey ("aft_return", "^M", $1);
definekey ("tex_insert_quote", "'", $1);
definekey ("tex_insert_quote", "\"", $1);
% fonts
definekey_reserved ("aft_insert_tags (\"_\", \"_\", 1, 1)", "_", $1);
definekey_reserved ("aft_insert_tags (\"''\", \"''\", 1, 1)", "'", $1);
definekey_reserved ("aft_insert_tags (\"~\", \"~\", 1, 1)", "~", $1);
definekey_reserved ("aft_insert_tags (\"|\", \"|\", 1, 1)", "|", $1);
definekey_reserved ("aft_insert_tags (\"%\", \"%\", 1, 1)", "%", $1);
definekey_reserved ("aft_insert_tags (\"^<<\\n\", \"^>>\", 1, 1);" +
                    " () = up (1)", "^", $1);
definekey_reserved ("insert (\"----\\n\")", "-", $1);
% lists
definekey_reserved ("aft_enumerated_item", "LE", $1);
definekey_reserved ("aft_enumerated_item", "^L^E", $1);
definekey_reserved ("aft_bullet_item", "LB", $1);
definekey_reserved ("aft_bullet_item", "^L^B", $1);
definekey_reserved ("aft_named_item", "LN", $1);
definekey_reserved ("aft_named_item", "^L^N", $1);
% table row
definekey_reserved ("aft_table_row", "!", $1);
% document structure
definekey_reserved ("aft_browse_tree", "D", $1);
definekey_reserved ("aft_browse_tree", "^D", $1);
% conversion
definekey_reserved ("aft_convert (\"tex\", 0)", "CL", $1);
definekey_reserved ("aft_convert (\"tex\", 0)", "^C^L", $1);
definekey_reserved ("aft_convert (\"html\", 1)", "CH", $1);
definekey_reserved ("aft_convert (\"html\", 1)", "^C^H", $1);
definekey_reserved ("aft_convert (\"html\", 0)", "CU", $1);
definekey_reserved ("aft_convert (\"html\", 0)", "^C^U", $1);
definekey_reserved ("aft_convert (\"rtf\", 1)", "CR", $1);
definekey_reserved ("aft_convert (\"rtf\", 1)", "^C^R", $1);
definekey_reserved ("aft_convert (\"lout\", 1)", "CO", $1);
definekey_reserved ("aft_convert (\"lout\", 1)", "^C^O", $1);
definekey_reserved ("aft_view_html", "VH", $1);
definekey_reserved ("aft_view_html", "^V^H", $1);
definekey_reserved ("aft_view_latex", "VL", $1);
definekey_reserved ("aft_view_latex", "^V^L", $1);


% type 1 keywords
() = define_keywords_n ($1, "ftp", 3, 1);
() = define_keywords_n ($1, "http", 4, 1);
() = define_keywords_n ($1, "mailto", 6, 1);

() = define_keywords_n ($1, "*", 1, 0);
() = define_keywords_n ($1, "**", 2, 0);
() = define_keywords_n ($1, "***^<<^>>", 3, 0);
() = define_keywords_n ($1, "*****TOC----", 4, 0);
() = define_keywords_n ($1, "*Image:*Title:", 7, 0);
() = define_keywords_n ($1, "*Author:", 8, 0);
() = define_keywords_n ($1, "*Image-left:", 12, 0);
() = define_keywords_n ($1, "*Image-right:", 13, 0);
() = define_keywords_n ($1, "*Image-center:", 14, 0);

#ifdef HAS_DFA_SYNTAX
%%% DFA_CACHE_BEGIN %%%
static define setup_dfa_callback (name)
{
  dfa_enable_highlight_cache ("aft.dfa", name);
  
  % the TAB character
  % dfa_define_highlight_rule ("^[\t]+", "Qstring", name);
  
  % preprocessor directives
  dfa_define_highlight_rule ("^#---SET.*$", "PQpreprocess", name);
  dfa_define_highlight_rule ("^#---PASS.*$", "PQpreprocess", name);
  dfa_define_highlight_rule ("^#---.*$", "comment", name);

  % keywords, type 0
  dfa_define_highlight_rule ("^\\^<<", "keyword", name);
  dfa_define_highlight_rule ("^\\^>>", "keyword", name);
  dfa_define_highlight_rule ("^\\*Title:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*Author:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*Image:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*Image-left:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*Image-center:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*Image-right:.*", "keyword", name);
  dfa_define_highlight_rule ("^\\*TOC$", "keyword", name);
  dfa_define_highlight_rule ("^\\*\ *.*$", "keyword", name);
  dfa_define_highlight_rule ("^\\*\\* *.*$$", "keyword", name);
  dfa_define_highlight_rule ("^\\*\\*\\* *.*$", "keyword", name);
  dfa_define_highlight_rule ("^\\*\\*\\*\\* *.*$", "keyword", name);
  
  % keywords, type 1
  % URLs
  dfa_define_highlight_rule ("[\t ]*http[s]?://.* ",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("[\t ]*http[s]?://.*$",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("[\t ]*ftp://.*[\n ]*",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("[\t ]*ftp://.*$",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("[\t ]*mailto:.*[\n ]*",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("[\t ]*mailto:.*$",
                             "Qkeyword1", name);
  dfa_define_highlight_rule ("\\[.*\\]", "Qkeyword1", name);

  % centred stuff - not working
  % dfa_define_highlight_rule ("^\t\t+[^\\*]", "Qstring", name);
  
  % lists
  dfa_define_highlight_rule ("^[\t]+\\*", "string", name);
  dfa_define_highlight_rule ("^[\t]+[0-9#]+\.", "string", name);
  dfa_define_highlight_rule ("^[\t]+[0-9#]+\)", "string", name);
  dfa_define_highlight_rule ("^[\t]+\\[.*\\]", "string", name);
  
  % lines
  dfa_define_highlight_rule ("^----(-)*", "keyword", name);
  
  % tables
  dfa_define_highlight_rule ("^[\t]+!.*$", "Qstring", name);
  
  % delimiters
  dfa_define_highlight_rule ("[\t ]*%", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*_ *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*_$", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*\\| *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*\\|$", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*~ *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*~$", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*=\\[ *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*\\]= *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*\\'\\' *", "Qdelimiter", name);
  dfa_define_highlight_rule ("[\t ]*\\'\\'$", "Qdelimiter", name);
  
  dfa_define_highlight_rule (".", "normal", name);
  
  dfa_build_highlight_table (name);
}
dfa_set_init_callback (&setup_dfa_callback, "aft");
%%% DFA_CACHE_END %%%
#endif

%!%+
%\function{aft_mode}
%\synopsis{aft_mode}
%\usage{Void aft_mode ();}
%\description
% This mode is designed to facilitate the task of editing aft files
% (http://www.maplefish.com/todd/aft.html)
% It calls the function \var{aft_mode_hook} if it is defined. In addition,
% if the abbreviation table \var{"aft"} is defined, that table is used.
%!%-
define aft_mode ()
{
  variable mode = "aft";
  (aft_file, aft_file_dir,,) = getbuf_info ();
  aft_buf = whatbuf ();
  set_mode (mode, 1);
  set_buffer_hook ("par_sep", &aft_paragraph_separator);
  use_syntax_table (mode);
  use_keymap (mode);
  set_comment_info ("#--- ", "", 1);
  mode_set_mode_info (mode, "init_mode_menu", &init_menu);
  run_mode_hooks ("aft_mode_hook");
}

% ----- End of file aft.sl
