"" vim: ft=vim:fdm=marker
"" Default file: /usr/local/Cellar/neovim/0.4.4/share/nvim/runtime/syntax/sh.vim

"" Filetype Specific Palette And HL Groups: {{{
"let s:p = {}

"let s:p.null = mdracula#palette.null
"let s:p.none = mdracula#palette.null

"" FIXME: provide correct values as the second element. See https://jonasjacek.github.io/colors/
"let s:p.local_blue        = ['#5e94aa',1]
"let s:p.local_blue_1      = ['#619AB0',1]
"let s:p.local_pink        = ['#94558D',1]
"let s:p.local_orange      = ['#CC7832', 172]
"let s:p.local_yellow      = ['#BBB529', 142]
"let s:p.local_purple      = ['#8888C6',1]
"let s:p.local_peach       = ['#E5C07B', 103]
"let s:p.local_salmon      = ['#DF6C75', 242]
"let s:p.local_bright_red  = ['#ff6b6b',1]
"let s:p.local_bright_blue = ['#61AFEF',1]
"let s:p.local_bright_pink = ['#B200B2',1]
"let s:p.local_sky_blue    = ['#61AEEF',1]
"let s:p.local_aqua = ['#8ec07c', 108]

"call mdracula#HL('LocalBlue', s:p.local_blue)
"call mdracula#HL('LocalBlue1', s:p.local_blue)
"call mdracula#HL('LocalPink', s:p.local_pink)
"call mdracula#HL('LocalOrange', s:p.local_orange)
"call mdracula#HL('LocalYellow', s:p.local_yellow)
"call mdracula#HL('LocalPurple', s:p.local_purple)
"call mdracula#HL('LocalPeach', s:p.local_peach)
"call mdracula#HL('LocalSalmon', s:p.local_salmon)
"call mdracula#HL('LocalBrightRed', s:p.local_bright_red)
"call mdracula#HL('LocalBrightBlue', s:p.local_bright_blue)
"call mdracula#HL('LocalBrightPink', s:p.local_bright_pink)
"call mdracula#HL('LocalSkyBlue', s:p.local_sky_blue)
"call mdracula#HL('LocalAqua', s:p.local_aqua)

"" }}}

"" Common commands
"" let commands = [ 'arch', 'awk', 'b2sum', 'base32', 'base64', 'basename', 'basenc', 'bash', 'brew', 'cat', 'chcon', 'chgrp', 'chown', 'chroot', 'cksum', 'comm', 'cp', 'csplit', 'curl', 'cut', 'date', 'dd', 'defaults', 'df', 'dir', 'dircolors', 'dirname', 'ed', 'env', 'expand', 'factor', 'fmt', 'fold', 'git', 'grep', 'groups', 'head', 'hexdump', 'hostid', 'hostname', 'hugo', 'id', 'install', 'join', 'killall', 'link', 'ln', 'logname', 'md5sum', 'mkdir', 'mkfifo', 'mknod', 'mktemp', 'nice', 'nl', 'nohup', 'npm', 'nproc', 'numfmt', 'od', 'open', 'paste', 'pathchk', 'pr', 'printenv', 'printf', 'ptx', 'readlink', 'realpath', 'rg', 'runcon', 'scutil', 'sed', 'seq', 'sha1sum', 'sha2', 'shred', 'shuf', 'split', 'stat', 'stdbuf', 'stty', 'sudo', 'sum', 'sync', 'tac', 'tee', 'terminfo', 'timeout', 'tmux', 'top', 'touch', 'tput', 'tr', 'truncate', 'tsort', 'tty', 'uname', 'unexpand', 'uniq', 'unlink', 'uptime', 'users', 'vdir', 'vim', 'wc', 'who', 'whoami', 'yabai', 'yes' ]

"" for i in commands
""     execute 'syn match shCommand "\v(\w|-)@<!'
""                 \ . i
""                 \ . '(\w|-)@!" containedin=shFunctionOne,shIf,shCmdParenRegion,shCommandSub,zshBrackets'
"" endfor

"syn match shShebang "^#!.*$" containedin=shComment
"" " Match semicolons as Delimiter rather than Operator
"" syn match shSemicolon ';' containedin=shOperator,zshOperator


"" hi! def link shVariable LocalSalmon
"" hi! def link shShellVariables shVariable
"" hi! def link shOption shVariable


"" Command arguments and options
"hi def link shCommandSub       LocalSalmon
"hi def link shCommandSubBQ     shCommandSub

"" Name of a new function
"hi def link shFunction LocalSkyBlue

"" Function keyword
"hi def link shFunctionKey      Statement
"" SHRUG
"hi def link shFunctionName     testColor

"hi def link shTodo     Todo

""
"hi def link shShellVariables       LocalSalmon
"" Special files as Constants
"syn match Constant "\v/dev/\w+"
"            \ containedin=shFunctionOne,shIf,shCmdParenRegion,shCommandSub

"hi def link shArithmetic       testColor
"hi def link shCharClass        Identifier
"hi def link shSnglCase     Statement
"hi def link shComment      Comment
"hi def link shConditional      Conditional
"hi def link shCtrlSeq      Special
"hi def link shExprRegion       Delimiter
"hi def link shOperator     Operator
"hi def link shRepeat       Repeat
"hi def link shSet      Statement
"hi def link shSetList      Identifier
"hi def link shSpecial      Special
"hi def link shSpecialDQ        Special
"hi def link shSpecialSQ        Special
"hi def link shSpecialNoZS      shSpecial
"hi def link shStatement        Statement
"hi def link shAlias        Identifier
"hi def link shHereDoc01        shRedir



"" Highlight: Vanilla HL groups {{{
"hi def link shShebang shebang
"hi def link shQuote String
"hi def link shString       String
"hi def link shNumber       Number
"" hi def link shStatement Statement
"" hi def link shOperator Normal
"" hi def link shFunctionKey Statement
"" hi def link shSemicolon Normal
"" hi def link shVarAssign Normal
"" }}}

"" Highlight: Filetype specific HL groups {{{
"" }}}
