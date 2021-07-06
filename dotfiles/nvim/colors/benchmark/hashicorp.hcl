/*
  Here's simple HCL code to show you syntax highlighter.
  Suggestions are welcome
*/
name = value
// Simple single line comment
block with five types and 'name' {
  array = [ 'a', 100, "b", 10.5e-42, true, false ]
  empty_array = []
  empty_object = {}
  # Yet another comment style
  strings = {
    "something" = "\"Quoted Yep!\""
    bad = "Invalid escaping:\c"
    'good' = "Valid escaping:\"\n\"\"
  }
}
block_with_only_one_name {
}
