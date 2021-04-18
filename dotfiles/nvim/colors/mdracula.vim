" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
" -----------------------------------------------------------------------------
" Initial Source: https://github.com/doums/darcula/blob/master/colors/darcula.vim
" -----------------------------------------------------------------------------

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='mdracula'


" Palette: {{{
" Setup palette dictionary
let s:p = {}

" Expose the palette
let g:ik1614_color_palette = s:p


" fill it with absolute colors
" Choose analogous colors:
"   * https://pinetools.com/lighten-color
"   * https://www.hexcolortool.com
let s:p.null = ['NONE', 'NONE']
let s:p.none = ['NONE', 'NONE']
let s:p.bg  = ['#282c31', 235]
let s:p.bg8 = ['#373c43', 238]
let s:p.fg  = ['#A9B7C6', 145]
let s:p.cursorLine = ['#2c3238', 236]
let s:p.wrapGuide = s:p.cursorLine
let s:p.gutter = s:p.cursorLine
let s:p.cursorLineNr = ['#A4A3A3', 248]
let s:p.muted = ['#606366', 241]
let s:p.lineNumber = s:p.muted

let s:p.cursor = ['#BBBBBB', 250]
let s:p.identifierUnderCaret = ['#344134', 237]
let s:p.identifierUnderCaretWrite = ['#40332B', 58]
let s:p.selection = ['#214283', 24]
let s:p.errorMsg = ['#CC666E', 174]
let s:p.error = ['#BC3F3C', 131]
let s:p.warning = ['#A9B7C6', 145]
let s:p.link = ['#287BDE', 32]
let s:p.stdOutput = ['#BBBBBB', 250]
let s:p.matchBraceFg = ['#FFEF28', 220]
let s:p.matchBraceBg = ['#3B514D', 59]
let s:p.todo = ['#A35F96', 142]
let s:p.search = ['#32593D', 23]
let s:p.incSearch = ['#155221', 22]
let s:p.foldedFg = ['#8C8C8C', 245]
let s:p.foldedBg = ['#3A3A3A', 237]
let s:p.constant = ['#9876AA', 103]
let s:p.keyword = ['#CC7832', 172]
let s:p.comment = ['#808080', 244]
let s:p.docComment = ['#629755', 65]
let s:p.string = ['#A5C261', 101]
let s:p.number = ['#E5C07B', 103]
let s:p.delimiter = ['#CC7832', 172]
let s:p.specialComment = ['#8A653B', 95]
let s:p.function = ['#FFC66D', 216]
let s:p.diffAdd = ['#294436', 23]
let s:p.diffText = ['#385570', 60]
let s:p.diffDelete = ['#484A4A', 239]
let s:p.diffChange = ['#303C47', 23]
let s:p.addStripe = ['#384C38', 66]
let s:p.stripeWhiteSpace = ['#4C4638', 59]
let s:p.changeStripe = ['#374752', 60]
let s:p.deleteStripe = ['#E06C75', 242]
let s:p.typo = ['#659C6B', 72]
let s:p.metaData = ['#BBB529', 142]
let s:p.macroName = ['#908B25', 100]
let s:p.cDataStructure = ['#B5B6E3', 146]
let s:p.cStructField = ['#9373A5', 103]
let s:p.debug = ['#666D75', 102]
let s:p.codeError = ['#532B2E', 52]
let s:p.codeWarning = ['#52503A', 59]
let s:p.errorStripe = ['#9E2927', 124]
let s:p.warnStripe = ['#BE9117', 136]
let s:p.infoStripe = ['#756D56', 101]
let s:p.typeDef = ['#B9BCD1', 146]
let s:p.menu = ['#46484A', 238]
let s:p.menuFg = ['#BBBBBB', 250]
let s:p.menuSel = ['#113A5C', 23]
let s:p.menuSBar = ['#616263', 241]
let s:p.tag = ['#E8BF6A', 180]
let s:p.entity = ['#6D9CBE', 109]
let s:p.htmlAttribute = ['#BABABA', 250]
let s:p.htmlString = ['#A5C261', 143]
let s:p.tsObject = ['#507874', 66]
let s:p.statusLine = ['#3C3F41', 237]
let s:p.statusLineFg = ['#BBBBBB', 250]
let s:p.statusLineNC = ['#787878', 243]
let s:p.tabLineSel = ['#4E5254', 239]
let s:p.shCommand = ['#C57633', 137]
let s:p.templateLanguage = ['#232525', 235]
let s:p.rustMacro = ['#4EADE5', 74]
let s:p.rustLifetime = ['#20999D', 37]
let s:p.duplicateFromServer = ['#5E5339', 59]
let s:p.hintBg = ['#3B3B3B', 237]
let s:p.hintFg = ['#787878', 243]
let s:p.ANSIBlack = ['#FFFFFF', 231]
let s:p.ANSIRed = ['#FF6B68', 210]
let s:p.ANSIGreen = ['#A8C023', 142]
let s:p.ANSIYellow = ['#D6BF55', 179]
let s:p.ANSIBlue = ['#5394EC', 68]
let s:p.ANSIMagenta = ['#AE8ABE', 139]
let s:p.ANSICyan = ['#299999', 37]
let s:p.ANSIGray = ['#999999', 247]
let s:p.ANSIDarkGray = ['#555555', 240]
let s:p.ANSIBrightRed = ['#FF8785', 210]
let s:p.ANSIBrightGreen = ['#A8C023', 142]
let s:p.ANSIBrightYellow = ['#FFFF00', 226]
let s:p.ANSIBrightBlue = ['#7EAEF1', 110]
let s:p.ANSIBrightMagenta = ['#FF99FF', 219]
let s:p.ANSIBrightCyan = ['#6CDADA', 116]
let s:p.ANSIWhite = ['#1F1F1F', 234]
let s:p.UIBlue = ['#3592C4', 67]
let s:p.UIGreen = ['#499C54', 71]
let s:p.UIRed = ['#C75450', 131]
let s:p.UIBrown = ['#93896C', 102]

let s:p.local_blue        = ['#5e94aa',1]
let s:p.local_blue_1      = ['#619AB0',1]
let s:p.local_pink        = ['#94558D',1]
let s:p.local_orange      = ['#CC7832', 172]
let s:p.local_yellow      = ['#BBB529', 142]
let s:p.local_purple      = ['#8888C6',1]
let s:p.local_peach       = ['#E5C07B', 103]
let s:p.local_salmon      = ['#E06C75', 242]
let s:p.local_bright_red  = ['#ff6b6b',1]
let s:p.local_bright_blue = ['#61AFEF',1]
let s:p.local_bright_pink = ['#B200B2',1]
let s:p.local_sky_blue    = ['#56b6c2',1]

let s:p.test_color_fg        = ['#eb4034', 102]
let s:p.test_color_bg        = ['#BBB529', 142]


" }}}
" Helper Hi Groups: {{{

call functions#HL('docComment', s:p.docComment, s:p.null, 'italic')
call functions#HL('NormalFg', s:p.fg)
call functions#HL('GitAddStripe', s:p.addStripe, s:p.addStripe)
call functions#HL('GitChangeStripe', s:p.changeStripe, s:p.changeStripe)
call functions#HL('GitDeleteStripe', s:p.deleteStripe, s:p.gutter)
call functions#HL('CodeError', s:p.null, s:p.codeError)
call functions#HL('CodeWarning', s:p.null, s:p.codeWarning)
call functions#HL('CodeInfo', s:p.null, s:p.infoStripe)
call functions#HL('CodeHint', s:p.hintFg, s:p.hintBg)
call functions#HL('ErrorSign', s:p.errorStripe, s:p.gutter)
call functions#HL('WarningSign', s:p.warnStripe, s:p.gutter)
call functions#HL('InfoSign', s:p.infoStripe, s:p.gutter)
call functions#HL('IdentifierUnderCaret', s:p.null, s:p.identifierUnderCaret)
call functions#HL('IdentifierUnderCaretWrite', s:p.null, s:p.identifierUnderCaretWrite)
call functions#HL('sheBang', s:p.fg, s:p.null, 'bold')
call functions#HL('testColor', s:p.test_color_fg, s:p.test_color_bg)

call functions#HL('LocalBlue', s:p.local_blue)
call functions#HL('LocalBlue1', s:p.local_blue)
call functions#HL('LocalPink', s:p.local_pink)
call functions#HL('LocalOrange', s:p.local_orange)
call functions#HL('LocalYellow', s:p.local_yellow)
call functions#HL('LocalPurple', s:p.local_purple)
call functions#HL('LocalPeach', s:p.local_peach)
call functions#HL('LocalSalmon', s:p.local_salmon)
call functions#HL('LocalBrightRed', s:p.local_bright_red)
call functions#HL('LocalBrightBlue', s:p.local_bright_blue)
call functions#HL('LocalBrightPink', s:p.local_bright_pink)
call functions#HL('LocalSkyBlue', s:p.local_sky_blue)

" }}}

" Vanilla Colorscheme: {{{ ----------------------------------------------------
  " General UI: {{{
  set t_Co=256
  set background=dark

  " Normal text
  call functions#HL('Normal', s:p.fg, s:p.bg)
  " Selection in Visual mode
  call functions#HL('Visual', s:p.null, s:p.selection)
  hi! link VisualNOS Visual
  " Screen line that the cursor is
  call functions#HL('CursorLine',   s:p.none, s:p.cursorLine)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine
  " Highlighted screen columns
  hi! link ColorColumn CursorLine

  if version >= 700
    " Tab pages line filler
    call functions#HL('TabLineFill', s:p.statusLine, s:p.statusLine)
    " Active tab page label
    call functions#HL('TabLineSel', s:p.fg, s:p.tabLineSel)
    " Not active tab page label
    call functions#HL('TabLine', s:p.statusLineFg, s:p.statusLine)
  endif
  " Directory names, special names in listing
  hi! link Directory NormalFg
  " :shrug:
  hi! link QuickFixLine NormalFg

  " }}}
  " General Syntax Highlighting: {{{
  " Special characters, e.g. space, tab, 
  call functions#HL('NonText', s:p.bg8)
  hi! link SpecialKey NonText
  " Comments
  call functions#HL('Comment', s:p.comment)
  call functions#HL('SpecialComment', s:p.specialComment, s:p.null, 'italic')
  " Todo, fixme within a comment line
  call functions#HL('Todo', s:p.todo, s:p.null, 'italic')

  if version >= 700
    " Match paired bracket under the cursor
    call functions#HL('MatchParen', s:p.matchBraceFg, s:p.matchBraceBg, 'bold')
  endif

  " Variable name
  hi! link Identifier NormalFg
  " Function name
  call functions#HL('Function', s:p.function)
  " Generic preprocessor, i.e. when based on previous or following symbol like $, :,
  " For example (for vim) --> " Something:
  call functions#HL('PreProc', s:p.metaData)
  hi! link Special PreProc
  " Generic constant
  call functions#HL('Constant', s:p.constant)
  " String constant: "this is a string"
  call functions#HL('String', s:p.string)
  " Character constant: 'c', '/n'
  hi! link Character String
  " Number constant: 234, 0xff
  call functions#HL('Number', s:p.number)
  " Floating point constant: 2.3e10
  hi! link Float Number
  call functions#HL('Delimiter', s:p.delimiter)
  call functions#HL('Keyword', s:p.keyword)
  " Generic statement
  hi! link Statement Keyword
  hi! link Tag Keyword
  hi! link Type Keyword
  call functions#HL('Typedef', s:p.typeDef)

  " }}}
  " Gutter: {{{
  " Column where signs are displayed
  call functions#HL('SignColumn', s:p.null, s:p.gutter)
  " Line number for :number and :# commands
  call functions#HL('LineNr', s:p.lineNumber, s:p.gutter)
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  " Line number of CursorLine
  call functions#HL('CursorLineNr', s:p.cursorLineNr, s:p.cursorLine)
  " Line used for closed folds
  call functions#HL('Folded', s:p.foldedFg, s:p.foldedBg)
  " Column where folds are displayed
  hi! link FoldColumn Folded

  " }}}
  " Diffs {{{
  call functions#HL('DiffAdd', s:p.null, s:p.diffAdd)
  call functions#HL('DiffChange', s:p.null, s:p.diffChange)
  call functions#HL('DiffDelete', s:p.null, s:p.diffDelete)
  call functions#HL('DiffText', s:p.null, s:p.diffText)

  " }}}
  " Cursor: {{{
  " Character under cursor
  call functions#HL('Cursor', s:p.none, s:p.none)
  " Visual mode cursor, selection
  hi! link vCursor Cursor
  " Input moder cursor
  hi! link iCursor Cursor
  " Language mapping cursor
  hi! link lCursor Cursor
  " call functions#HL('Cursor', s:p.cursor)
  hi! link CursorIM Cursor

  " }}}
  " Prompt: {{{
  call functions#HL('ErrorMsg', s:p.errorMsg)
  " Warning messages
  call functions#HL('WarningMsg', s:p.warning)
  " Current mode message: -- INSERT --
  call functions#HL('ModeMsg', s:p.stdOutput)
  " More prompt: -- More --
  hi! link MoreMsg NormalFg
  " 'Press enter' prompt and yes/no questions
  hi! link Question NormalFg
  " Titles for output from :set all, :autocmd, etc.
  hi! link Title Special

  " }}}
  " Completion Menu: {{{
  if version >= 700
    " NOTE: I think this is specific to VIM
    call functions#HL('Pmenu', s:p.menuFg, s:p.menu)
    call functions#HL('PmenuSel', s:p.menuFg, s:p.menuSel)
    call functions#HL('PmenuSbar', s:p.menu, s:p.menu)
    call functions#HL('PmenuThumb', s:p.menuSBar, s:p.menuSBar)
  endif
  " Current match in wildmenu completion. FIXME: This could break
  hi! link WildMenu PmenuSel

  " }}}
  " Spelling: {{{
  if has("spell")
      " Not recognized word
      call functions#HL('SpellBad', s:p.typo, s:p.null, 'underline')
      " Not capitalised word, or compile warnings
      hi! link SpellCap SpellBad
      " Wrong spelling for selected region
      hi! link SpellLocal SpellBad
      " Rare word
      hi! link SpellRare SpellBad
  endif

  " }}}
  " MISC: {{{
  call functions#HL('Search', s:p.null, s:p.search)
  " TODO: Fix background of current search value
  call functions#HL('IncSearch', s:p.null, s:p.incSearch)
  " The column separating vertically split windows
  call functions#HL('VertSplit', s:p.muted)

  " }}}
  " SHRUG: {{{
  call functions#HL('Conceal', s:p.muted, s:p.bg)
  call functions#HL('Error', s:p.error)
  call functions#HL('Terminal', s:p.stdOutput, s:p.bg)
  call functions#HL('StatusLine', s:p.statusLineFg, s:p.statusLine)
  call functions#HL('StatusLineNC', s:p.statusLineNC, s:p.statusLine)
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  call functions#HL('Underlined', s:p.fg, s:p.null, 'underline')
  call functions#HL('Debug', s:p.debug, s:p.null, 'italic')
  hi! link EndOfBuffer NonText

  " }}}
  " Setup Terminal Colors: (for :terminal) {{{
  let g:terminal_color_0 = s:p.ANSIBlack[0]
  let g:terminal_color_1 = s:p.ANSIRed[0]
  let g:terminal_color_2 = s:p.ANSIGreen[0]
  let g:terminal_color_3 = s:p.ANSIYellow[0]
  let g:terminal_color_4 = s:p.ANSIBlue[0]
  let g:terminal_color_5 = s:p.ANSIMagenta[0]
  let g:terminal_color_6 = s:p.ANSICyan[0]
  let g:terminal_color_7 = s:p.ANSIGray[0]
  let g:terminal_color_8 = s:p.ANSIDarkGray[0]
  let g:terminal_color_9 = s:p.ANSIBrightRed[0]
  let g:terminal_color_10 = s:p.ANSIBrightGreen[0]
  let g:terminal_color_11 = s:p.ANSIBrightYellow[0]
  let g:terminal_color_12 = s:p.ANSIBrightBlue[0]
  let g:terminal_color_13 = s:p.ANSIBrightMagenta[0]
  let g:terminal_color_14 = s:p.ANSIBrightCyan[0]
  let g:terminal_color_15 = s:p.ANSIWhite[0]

  " }}}
  " Neovim Specific: {{{
  " The following code snippet MIGHT fix an issue with CursorLine hi group
  " see https://github.com/neovim/neovim/issues/9019
  " At the same time, it could make everything highlighted
  " if has('termguicolors') && &termguicolors
  "   hi CursorLine ctermfg=white
  " else
  "   hi CursorLine guifg=white
  " endif
  hi! link NormalFloat Pmenu
  hi! link NormalNC NormalFg
  hi! link MsgArea NormalFg
  hi! link MsgSeparator StatusLine
  hi! link QuickFixLine NormalFg
  hi! link Substitute Search
  " TermCursor
  " TermCursorNC
  hi! link Whitespace NonText
  hi! link healthSuccess IncSearch
  call functions#HL('NvimInternalError', s:p.error, s:p.error)
  call functions#HL('RedrawDebugClear', s:p.fg, s:p.duplicateFromServer)
  call functions#HL('RedrawDebugComposed', s:p.fg, s:p.search)
  call functions#HL('RedrawDebugRecompose', s:p.fg, s:p.codeError)

  " }}}
" }}}

" Plugin Specific: {{{ -------------------------------------------------------
" GitGutter: {{{

" Fill sign column with color instead of showing characters, but for deleted
" lines use sign.
hi! link GitGutterAdd           GitAddStripe
hi! link GitGutterDelete        GitDeleteStripe
hi! link GitGutterChange        GitChangeStripe
hi! link GitGutterChangeDelete  GitChangeStripe

" }}}
" NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" }}}

" Filetype Specific Colorscheme: {{{ -----------------------------------------
" Markdown: {{{
call functions#HL('markdownH1', s:p.constant, s:p.null, 'italic')
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownHeadingRule markdownH1
hi! link markdownHeadingDelimiter markdownH1
call functions#HL('markdownAutomaticLink', s:p.link, s:p.null, 'underline')
hi! link markdownBlockquote String
hi! link markdownBoldDelimiter Keyword
hi! link markdownBold NormalFg
hi! link markdownItalicDelimiter Keyword
hi! link markdownItalic NormalFg
hi! link markdownCode Comment
hi! link markdownCodeDelimiter markdownCode
hi! link markdownCodeBlock markdownCode
call functions#HL('markdownLinkText', s:p.link, s:p.null, 'underline')
hi! link markdownLinkTextDelimiter markdownLinkText
hi! link markdownUrlDelimiter markdownLinkText
call functions#HL('markdownUrl', s:p.function, s:p.null, 'italic')
hi! link markdownIdDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownIdDeclaration Keyword
hi! link markdownLinkDelimiter NormalFg
hi! link markdownUrlTitleDelimiter Comment
hi! link markdownRule Comment
" }}}
" YAML: {{{
hi! link yamlDocumentStart NormalFg
hi! link yamlDocumentEnd NormalFg
hi! link yamlBlockMappingKey Keyword
hi! link yamlKeyValueDelimiter NormalFg
hi! link yamlInteger NormalFg
hi! link yamlFloat NormalFg
hi! link yamlBlockCollectionItemStart NormalFg
call functions#HL('yamlAnchor', s:p.tag)
hi! link yamlAlias yamlAnchor
hi! link yamlBool NormalFg
hi! link yamlNodeTag NormalFg
hi! link yamlNull NormalFg
" }}}
" TreeSitter: {{{

hi! link TSPunctDelimiter Normal
hi! link TSPunctBracket   Normal
hi! link TSPunctSpecial   Normal

" Constants
hi! link TSConstant     Normal          " Probably will need to change
hi! link TSConstBuiltin LocalPurple
hi! link TSConstMacro   testColor
hi! link TSString       String
hi! link TSStringRegex  String          " Probably will need to change
hi! link TSStringEscape LocalSkyBluek
hi! link TSCharacter    String
hi! link TSNumber       Number
hi! link TSBoolean      LocalOrange
hi! link TSFloat        Number

" Functions
hi! link TSFunction           LocalBrightBlue
hi! link TSFuncBuiltin        LocalPurple      " Consider making the same as TSFunction
hi! link TSFuncMacro          testColor        " Not sure what this is
hi! link TSParameter          LocalSalmon
hi! link TSParameterReference testColor        " Doesn't look like this is working :cry:
hi! link TSMethod             Normal
hi! link TSField              Normal
hi! link TSProperty           Normal
hi! link TSConstructor        LocalBrightBlue  " Not sure about this one
hi! link TSAnnotation         LocalYellow
hi! link TSAttribute          testColor
hi! link TSNamespace          testColor
hi! link TSSymbol             testColor

"  Keywords
hi! link TSConditional     LocalOrange
hi! link TSRepeat          LocalOrange
hi! link TSLabel           testColor
hi! link TSOperator        Normal
hi! link TSKeyword         LocalOrange
hi! link TSKeywordFunction testColor
hi! link TSKeywordOperator LocalOrange    " E.g. 'for', 'or' 'not' (in Python)
hi! link TSException       testColor

hi! link TSType        LocalPeach "LocalPurple
hi! link TSTypeBuiltin LocalPeach "LocalPurple
hi! link TSInclude     LocalOrange

" Variable
hi! link TSVariable        Normal    " Could use 'LocalSalmon ' if this was appied only to variables passed to a functions
hi! link TSVariableBuiltin LocalPink

" Text
hi! link TSText           testColor
hi! link TSStrong         testColor
hi! link TSEmphasis       testColor
hi! link TSUnderline      testColor
hi! link TSStrike         testColor
hi! link TSMath           testColor
hi! link TSTextReference  testColor
hi! link TSEnviroment     testColor
hi! link TSEnviromentName testColor
hi! link TSTitle          testColor
hi! link TSLiteral        testColor
hi! link TSURI            testColor

hi! link TSNote    Todo      " E.g. 'NOTE' in a comment
hi! link TSWarning Todo      " E.g. 'TODO' in a comment
hi! link TSDanger  Todo      " E.g. fixme in a comment
hi! link TSError   CodeError

" " Tags
hi! link TSTag          LocalPeach  " E.g. HTML tags like div, body
hi! link TSTagDelimiter Normal      " E.g. Brackets for HTML tags
hi! link TSStructure    testColor



" }}}
" }}}

