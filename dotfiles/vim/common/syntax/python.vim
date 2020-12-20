" vim: ft=vim:fdm=marker
" Source: https://github.com/python-mode/python-mode/blob/develop/syntax/python.vim
" Additional Info: https://github.com/vim-python/python-syntax/blob/master/syntax/python.vim

" DESC: Check variable and set default value if it not exists
fun! SetDefaultSyntaxHL(name, default) "{{{
    if !exists(a:name)
        let {a:name} = a:default
        return 0
    endif
    return 1
endfunction "}}}


" Enable pymode syntax for python files
call SetDefaultSyntaxHL('g:pymode', 1)
call SetDefaultSyntaxHL('g:pymode_syntax', g:pymode)

" DESC: Disable script loading
if !g:pymode || !g:pymode_syntax || SetDefaultSyntaxHL('b:current_syntax', 'pymode')
    finish
endif

" OPTIONS: {{{

" Highlight all by default
call SetDefaultSyntaxHL('g:pymode_syntax_all', 1)

" Highlight 'async/await' keywords
call SetDefaultSyntaxHL("g:pymode_syntax_highlight_async_await", 1)

" Highlight indent's errors
call SetDefaultSyntaxHL('g:pymode_syntax_indent_errors', 1)

" Highlight string formatting
call SetDefaultSyntaxHL('g:pymode_syntax_string_formatting', 1)
call SetDefaultSyntaxHL('g:pymode_syntax_string_format', 1)
call SetDefaultSyntaxHL('g:pymode_syntax_string_templates', 1)
call SetDefaultSyntaxHL('g:pymode_syntax_doctests', 1)

" Support docstrings in syntax highlighting
call SetDefaultSyntaxHL('g:pymode_syntax_docstrings', 1)

" Highlight builtin objects (True, False, ...)
call SetDefaultSyntaxHL('g:pymode_syntax_builtin_objs', 1)

" Highlight builtin types (str, list, ...)
call SetDefaultSyntaxHL('g:pymode_syntax_builtin_types', 1)

" Highlight builtin types (div, eval, ...)
call SetDefaultSyntaxHL('g:pymode_syntax_builtin_funcs', 1)

" Highlight builtin dunder methods (__str__, __repr__, ...)
call SetDefaultSyntaxHL('g:pymode_syntax_builtin_dunder', 1)

" Highlight exceptions (TypeError, ValueError, ...)
call SetDefaultSyntaxHL('g:pymode_syntax_highlight_exceptions', 1)

" More slow synchronizing. Disable on the slow machine, but code in docstrings
" could be broken.
call SetDefaultSyntaxHL('g:pymode_syntax_slow_sync', 1)

" }}}

" For version 5.x: Clear all syntax items
if version < 600
    syntax clear
endif

" Keywords {{{
" ============

    syn keyword pythonStatement break continue del
    syn keyword pythonStatement exec return
    syn keyword pythonStatement pass raise
    syn keyword pythonStatement global nonlocal assert
    syn keyword pythonStatement yield
    syn keyword pythonStatement with as
    syn keyword pythonLambdaExpr lambda

    syn keyword pythonRepeat        for while
    syn keyword pythonConditional   if elif else
    syn keyword pythonInclude       import from
    syn keyword pythonException     try except finally
    syn keyword pythonOperator      and in is not or
    syn keyword pythonSelf self cls


    syn match pythonExtraOperator "\%([~!^&|/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\.\.\.\|\.\.\|::\)"
    syn match pythonExtraOperator "\%(=\)"
    syn match pythonExtraOperator "\%(\*\|\*\*\)"

    syn match pythonExtraPseudoOperator "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"

    syn keyword pythonStatement def nextgroup=pythonFunction,pythonBuiltinDunder skipwhite
    syn match pythonFunction "\%(\%(def\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=pythonVars
    syn region pythonVars start="(" skip=+\(".*"\|'.*'\)+ end=")" contained contains=pythonParameters transparent keepend
    syn match pythonParameters "[^,:(){}\[\]]*" contained contains=pythonExtraOperator,pythonLambdaExpr,pythonBuiltinObj,pythonBuiltinType,pythonConstant,pythonString,pythonNumber,pythonBrackets,pythonSelf,pythonComment skipwhite
    " Doesn't look like it works correctly
    syn match pythonBrackets "{[(|)]}" contained skipwhite
    " TODO: colors for typehints

    syn keyword pythonStatement class nextgroup=pythonClass skipwhite
    syn match pythonClass "\%(\%(class\s\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=pythonClassVars
    syn region pythonClassVars start="(" end=")" contained contains=pythonClassParameters transparent keepend
    syn match pythonClassParameters "[^,()\*]*" contained contains=pythonBuiltin,pythonBuiltinObj,pythonBuiltinType,pythonExtraOperatorpythonStatement,pythonBrackets,pythonString,pythonComment skipwhite

    if g:pymode_syntax_highlight_async_await
        syn keyword pythonStatement async await
        syn match pythonStatement "\<async\s\+def\>" nextgroup=pythonFunction skipwhite
        syn match pythonStatement "\<async\s\+with\>" display
        syn match pythonStatement "\<async\s\+for\>" nextgroup=pythonRepeat skipwhite
    endif

" }}}

" Decorators {{{
" ==============

    syn match   pythonDecorator "@" display nextgroup=pythonDottedName skipwhite
    syn match   pythonDottedName "[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*" display contained

" }}}

" Comments {{{
" ============

    syn match   pythonComment   "#.*$" display contains=pythonTodo,@Spell
    syn match   pythonRun       "\%^#!.*$"
    syn match   pythonCoding    "\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
    syn keyword pythonTodo      TODO FIXME NOTE XXX contained
    syn keyword pythonTodo      todo fixme note contained
    syn keyword pythonTodo      Todo Fixme Note contained

" }}}

" Errors {{{
" ==========

    syn match pythonError       "\<\d\+\D\+\>" display
    syn match pythonError       "[$?]" display
    syn match pythonError       "[&|]\{2,}" display
    syn match pythonError       "[=]\{3,}" display

    " Indent errors (mix space and tabs)
    if g:pymode_syntax_indent_errors
        syn match pythonIndentError "^\s*\( \t\|\t \)\s*\S"me=e-1 display
    endif

" }}}

" Strings {{{
" ===========

    syn region pythonString     start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
    syn region pythonString     start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
    syn region pythonString     start=+[bB]\="""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2,@Spell
    syn region pythonString     start=+[bB]\='''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,@Spell

    syn match  pythonEscape     +\\[abfnrtv'"\\]+ display contained
    syn match  pythonEscape     "\\\o\o\=\o\=" display contained
    syn match  pythonEscapeError    "\\\o\{,2}[89]" display contained
    syn match  pythonEscape     "\\x\x\{2}" display contained
    syn match  pythonEscapeError    "\\x\x\=\X" display contained
    syn match  pythonEscape     "\\$"

    " Unicode
    syn region pythonUniString  start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
    syn region pythonUniString  start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
    syn region pythonUniString  start=+[uU]"""+ end=+"""+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest2,@Spell
    syn region pythonUniString  start=+[uU]'''+ end=+'''+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest,@Spell

    syn match  pythonUniEscape          "\\u\x\{4}" display contained
    syn match  pythonUniEscapeError     "\\u\x\{,3}\X" display contained
    syn match  pythonUniEscape          "\\U\x\{8}" display contained
    syn match  pythonUniEscapeError     "\\U\x\{,7}\X" display contained
    syn match  pythonUniEscape          "\\N{[A-Z ]\+}" display contained
    syn match  pythonUniEscapeError "\\N{[^A-Z ]\+}" display contained

    " Raw strings
    syn region pythonRawString  start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
    syn region pythonRawString  start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
    syn region pythonRawString  start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,@Spell
    syn region pythonRawString  start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,@Spell

    syn match pythonRawEscape           +\\['"]+ display transparent contained

    " Unicode raw strings
    syn region pythonUniRawString   start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
    syn region pythonUniRawString   start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
    syn region pythonUniRawString   start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2,@Spell
    syn region pythonUniRawString   start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest,@Spell

    syn match  pythonUniRawEscape   "\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
    syn match  pythonUniRawEscapeError  "\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

    " String formatting
    if g:pymode_syntax_string_formatting
        syn match pythonStrFormatting   "%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
        syn match pythonStrFormatting   "%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    endif

    " Str.format syntax
    if g:pymode_syntax_string_format
        syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
        syn match pythonStrFormat "{\([a-zA-Z0-9_]*\|\d\+\)\(\.[a-zA-Z_][a-zA-Z0-9_]*\|\[\(\d\+\|[^!:\}]\+\)\]\)*\(![rs]\)\=\(:\({\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)}\|\([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*\(\.\d\+\)\=[bcdeEfFgGnoxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    endif

    " String templates
    if g:pymode_syntax_string_templates
        syn match pythonStrTemplate "\$\$" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
        syn match pythonStrTemplate "\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
        syn match pythonStrTemplate "\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    endif

    " DocTests
    if g:pymode_syntax_doctests
        syn region pythonDocTest    start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
        syn region pythonDocTest2   start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained
    endif

    " DocStrings
    if g:pymode_syntax_docstrings
        syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,
        syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,
    endif


" }}}

" Numbers {{{
" ===========

    syn match   pythonHexError  "\<0[xX][0-9a-fA-F_]*[g-zG-Z][0-9a-fA-F_]*[lL]\=\>" display
    syn match   pythonHexNumber "\<0[xX][0-9a-fA-F_]*[0-9a-fA-F][0-9a-fA-F_]*[lL]\=\>" display
    syn match   pythonOctNumber "\<0[oO][0-7_]*[0-7][0-7_]*[lL]\=\>" display
    syn match   pythonBinNumber "\<0[bB][01_]*[01][01_]*[lL]\=\>" display
    syn match   pythonNumber    "\<[0-9][0-9_]*[lLjJ]\=\>" display
    syn match   pythonFloat "\.[0-9_]*[0-9][0-9_]*\([eE][+-]\=[0-9_]*[0-9][0-9_]*\)\=[jJ]\=\>" display
    syn match   pythonFloat "\<[0-9][0-9_]*[eE][+-]\=[0-9_]\+[jJ]\=\>" display
    syn match   pythonFloat "\<[0-9][0-9_]*\.[0-9_]*\([eE][+-]\=[0-9_]*[0-9][0-9_]*\)\=[jJ]\=" display
    syn match   pythonOctError  "\<0[oO]\=[0-7_]*[8-9][0-9_]*[lL]\=\>" display
    syn match   pythonBinError  "\<0[bB][01_]*[2-9][0-9_]*[lL]\=\>" display

" }}}

" Builtins {{{
" ============

    " Builtin objects and types
    if g:pymode_syntax_builtin_objs
        syn keyword pythonBuiltinObj True False Ellipsis None NotImplemented
    endif

    if g:pymode_syntax_builtin_types
        syn keyword pythonBuiltinType type object
        syn keyword pythonBuiltinType str basestring unicode buffer bytearray bytes chr unichr
        syn keyword pythonBuiltinType dict int long bool float complex set frozenset list tuple
        syn keyword pythonBuiltinType file super
    endif

    " Builtin dunder methods
    if g:pymode_syntax_builtin_dunder
        " item/attribute/method lookup
        syn keyword pythonBuiltinDunder __getattribute__ __getattr__ __delattr__ __delitem__
        syn keyword pythonBuiltinDunder __delslice__ __setattr__ __setitem__ __setslice__
        syn keyword pythonBuiltinDunder __missing__ __getitem__ __getslice__
        " equality and hashing
        syn keyword pythonBuiltinDunder __eq__ __ge__ __gt__ __le__ __ne__ __lt__ __hash__
        " binary operators
        syn keyword pythonBuiltinDunder __add__ __and__ __divmod__ __floordiv__ __lshift__
        syn keyword pythonBuiltinDunder __matmul__ __mod__ __mul__ __or__ __pow__ __rshift__
        syn keyword pythonBuiltinDunder __sub__ __truediv__ __xor__ __radd__ __rand__ __rdiv__
        syn keyword pythonBuiltinDunder __rdivmod__ __rfloordiv__ __rlshift__ __rmatmul__
        syn keyword pythonBuiltinDunder __rmod__ __rmul__ __ror__ __rpow__ __rrshift__
        syn keyword pythonBuiltinDunder __rsub__ __rtruediv__ __rxor__ __iadd__ __iand__
        syn keyword pythonBuiltinDunder __ifloordiv__ __ilshift__ __imatmul__ __imod__ __imul__
        syn keyword pythonBuiltinDunder __ior__ __ipow__ __irshift__ __isub__ __itruediv__ __ixor__
        " unary operators
        syn keyword pythonBuiltinDunder __abs__ __neg__ __pos__ __invert__
        " math
        syn keyword pythonBuiltinDunder __index__ __trunc__ __floor__ __ceil__ __round__
        " iterator
        syn keyword pythonBuiltinDunder __iter__ __len__ __reversed__ __contains__ __next__
        " numeric type casting
        syn keyword pythonBuiltinDunder __int__ __bool__ __nonzero__ __complex__ __float__
        " others
        syn keyword pythonBuiltinDunder __format__ __cmp__
        " context manager
        syn keyword pythonBuiltinDunder __enter__ __exit__
        " descriptor
        syn keyword pythonBuiltinDunder __get__ __set__ __delete__ __set_name__
        " async
        syn keyword pythonBuiltinDunder __aenter__ __aexit__ __aiter__ __anext__ __await__
        " creation and typing
        syn keyword pythonBuiltinDunder __call__ __class__ __dir__ __init__ __init_subclass__
        syn keyword pythonBuiltinDunder __prepare__ __new__ __subclasses__
        " instance / subclass check
        syn keyword pythonBuiltinDunder __instancecheck__ __subclasscheck__
        " generic types
        syn keyword pythonBuiltinDunder __class_getitem__
        " str and repr
        syn keyword pythonBuiltinDunder __str__ __repr__ __doc__
        " modules
        syn keyword pythonBuiltinDunder __import__ __file__ __package__ __name__
        " others
        syn keyword pythonBuiltinDunder __bytes__ __fspath__ __getnewargs__ __reduce__
        syn keyword pythonBuiltinDunder __reduce_ex__ __sizeof__ __length_hint__
        syn keyword pythonBuiltinDunder __debug__
    endif

    " Builtin functions
    if g:pymode_syntax_builtin_funcs
        syn keyword pythonBuiltinFunc   abs all any apply
        syn keyword pythonBuiltinFunc   bin callable classmethod cmp coerce compile
        syn keyword pythonBuiltinFunc   delattr dir divmod enumerate eval execfile filter
        syn keyword pythonBuiltinFunc   format getattr globals locals hasattr hash help hex id
        syn keyword pythonBuiltinFunc   input intern isinstance issubclass iter len map max min
        syn keyword pythonBuiltinFunc   next oct open ord pow property range xrange
        syn keyword pythonBuiltinFunc   raw_input reduce reload repr reversed round setattr
        syn keyword pythonBuiltinFunc   slice sorted staticmethod sum vars zip
        syn keyword pythonBuiltinFunc   print
    endif

    " Builtin exceptions and warnings
    if g:pymode_syntax_highlight_exceptions
        syn keyword pythonExClass   BaseException
        syn keyword pythonExClass   Exception StandardError ArithmeticError
        syn keyword pythonExClass   LookupError EnvironmentError
        syn keyword pythonExClass   AssertionError AttributeError BufferError EOFError
        syn keyword pythonExClass   FloatingPointError GeneratorExit IOError
        syn keyword pythonExClass   ImportError IndexError KeyError
        syn keyword pythonExClass   KeyboardInterrupt MemoryError NameError
        syn keyword pythonExClass   NotImplementedError OSError OverflowError
        syn keyword pythonExClass   ReferenceError RuntimeError StopIteration
        syn keyword pythonExClass   SyntaxError IndentationError TabError
        syn keyword pythonExClass   SystemError SystemExit TypeError
        syn keyword pythonExClass   UnboundLocalError UnicodeError
        syn keyword pythonExClass   UnicodeEncodeError UnicodeDecodeError
        syn keyword pythonExClass   UnicodeTranslateError ValueError VMSError
        syn keyword pythonExClass   BlockingIOError ChildProcessError ConnectionError
        syn keyword pythonExClass   BrokenPipeError ConnectionAbortedError
        syn keyword pythonExClass   ConnectionRefusedError ConnectionResetError
        syn keyword pythonExClass   FileExistsError FileNotFoundError InterruptedError
        syn keyword pythonExClass   IsADirectoryError NotADirectoryError PermissionError
        syn keyword pythonExClass   ProcessLookupError TimeoutError
        syn keyword pythonExClass   WindowsError ZeroDivisionError
        syn keyword pythonExClass   Warning UserWarning BytesWarning DeprecationWarning
        syn keyword pythonExClass   PendingDepricationWarning SyntaxWarning
        syn keyword pythonExClass   RuntimeWarning FutureWarning
        syn keyword pythonExClass   ImportWarning UnicodeWarning
    endif

" }}}

if g:pymode_syntax_slow_sync
    syn sync minlines=2000
else
    " This is fast but code inside triple quoted strings screws it up. It
    " is impossible to fix because the only way to know if you are inside a
    " triple quoted string is to start from the beginning of the file.
    syn sync match pythonSync grouphere NONE "):$"
    syn sync maxlines=200
endif

" Highlight {{{
" =============
" Use vanilla highlighting modes
hi def link  pythonBrackets             Normal
hi def link  pythonClassParameters      Normal
hi def link  pythonExtraOperator        Normal
hi def link  pythonExtraPseudoOperator  Normal

hi def link  pythonComment      Comment
hi def link  pythonTodo         Todo

hi def link  pythonError             CodeError
hi def link  pythonIndentError       CodeError
hi def link  pythonEscapeError       CodeError
hi def link  pythonUniEscapeError    CodeError
hi def link  pythonUniRawEscapeError CodeError
hi def link  pythonOctError          CodeError
hi def link  pythonHexError          CodeError
hi def link  pythonBinError          CodeError

hi def link  pythonString       String
hi def link  pythonUniString    String
hi def link  pythonRawString    String
hi def link  pythonUniRawString String

hi def link  pythonNumber       Number
hi def link  pythonHexNumber    Number
hi def link  pythonOctNumber    Number
hi def link  pythonBinNumber    Number
hi def link  pythonFloat        Number

hi def link  pythonStatement    IlyaOrange
hi def link  pythonLambdaExpr   IlyaOrange
hi def link  pythonInclude      IlyaOrange
hi def link  pythonConditional  IlyaOrange
hi def link  pythonRepeat       IlyaOrange
hi def link  pythonException    IlyaOrange
hi def link  pythonOperator     IlyaOrange
hi def link  pythonBuiltinObj   IlyaOrange

hi def link  pythonExClass      IlyaPurple
hi def link  pythonBuiltinType  IlyaPurple
hi def link  pythonBuiltinFunc  IlyaPurple

hi def link  pythonBuiltinDunder   IlyaBrightPink

hi def link  pythonClass        IlyaPeach

" Parameters within function definition
hi def link  pythonParameters   IlyaSalmon

hi def link  pythonSelf         IlyaPink

hi def link  pythonDocstring    IlyaBlue1

" Function definition
hi def link  pythonFunction     IlyaBrightBlue

hi def link  pythonEscape       IlyaSkyBlue
hi def link  pythonUniEscape    IlyaSkyBlue
hi def link  pythonUniRawEscape IlyaSkyBlue
" Something is a little bit off when using methods within string formatting
hi def link  pythonStrFormatting IlyaSkyBlue
hi def link  pythonStrFormat     IlyaSkyBlue
hi def link  pythonStrTemplate   IlyaSkyBlue

hi def link  pythonDecorator    IlyaYellow
hi def link  pythonDottedName   IlyaYellow

hi def link  pythonRun          IlyaShebang
hi def link  pythonDocTest      docComment
hi def link  pythonDocTest2     docComment

" Unidetified highlight groups
hi def link  pythonCoding       IlyaTest

" }}}
