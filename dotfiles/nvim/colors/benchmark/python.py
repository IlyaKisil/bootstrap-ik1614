#! /usr/local/bin/python3
import os
from pathlib import Path

HERE = "bla"

# TODO: one two three.
# NOTE: hello
# HACK:
# WARN:
# PERF: hellow
# INFO(ilya): olga dima
# INFO(Ilya): hahah
# INFO(anna): hahah
# TIP(anna): hahah
# INFO(ilya): hahah
# INFO(ilya): hahah
# FIXME  (ilya): hello
# FIXME: hello
# Todo: one two three.
# todo: one two three.
# NonText:  , space ,
class Foo:
    pass


class Bar(Foo):
    tags: List[str]

    def __init__(self: Foo):
        self.make_sense(whatever="5")
        raw_string = r'Hi\nHello'
        byte_string: bytes = b'newline:\n also newline:\x0a'
        text_string = u"Cyrillic Я is \u042f. Oops: \u042g UniEscapeError"
        hello = "hello"
        multi_line_string = """
            hello
            how is it going?
        """
        format_string = f'{hello} {hello.capitalize()}'
        format_string = f'{x!s:{"^10"}}'
        _int, _float, big_int, scientific = (1, 1.2, 1_000_000, 2e3)

        i += 2

    def __repr__(self):
        return "haha"

    def hello(self, f=5, b="s", b=[], a={}, d=dict(), c=()) -> List[str]:
        pass

    def make_sense(self, parameter: str, whatever: List[str], *arg, **kwargs):
        self.sense = parameter
        self.hello()
        try:
            2python-code-error
        except Exception:
            pass
        finally:
            pass
        if self.sense == 2:
            yield 5


        for i in range():
            print(hello)

        if True or not False:
            print("hello")
            if
            ife


@decorator(param=1)
def bar(x):
    """Syntax Highlighting Demo

    @param x Parameter

    Semantic highlighting:
    Generated spectrum to pick cirestnierniolors for local variables and parameters:

    >>> [factorial(n) for n in range(6)]
    [1, 1, 2, 6, 24, 120]
    """
    # Some comment
    s = (
        {'a': 'b'},
    )
    bar(s[0].lower())


if __name__ == "__main__":
    x = len('abc')
    print(b.__doc__)

    if x > 2:
        pass
