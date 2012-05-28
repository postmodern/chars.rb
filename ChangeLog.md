### 0.2.2 / 2012-05-27

* {Chars::CharSet#initialize} now raises a TypeError when given arguments
  that were neither a `String`, `Integer` or `Enumerable`.
* Allow {Chars::CharSet#strings_in} to yield results as they are found.
* Improved the performance of {Chars::CharSet#strings_in} when operating on
  small Strings.
* Replaced ore-tasks with
  [rubygems-tasks](https://github.com/postmodern/rubygems-tasks#readme).

### 0.2.1 / 2011-06-22

* Added {Chars::CharSet.[]}
* Added {Chars::CharSet#<<}.
* Added {Chars::CharSet#byte_to_char}.
* Added {Chars::CharSet#char_to_byte}.
* Added a cache of characters of the bytes within {Chars::CharSet}.
* Use `String#each_char` to distinguish Unicode from ASCII.

### 0.2.0 / 2010-10-27

* Make sure all enumerable methods in {Chars::CharSet} return an
  `Enumerator` object if no block is given.

### 0.1.2 / 2009-09-21

* Require Hoe >= 2.3.3.
* Require YARD >= 0.2.3.5.
* Require RSpec >= 1.2.8.
* Added Chars.visibile and Chars::VISIBLE (thanks flatline).
* Added CharSet#random_distinct_bytes, CharSet#random_distinct_chars,
  and CharSet#random_distinct_string (thanks flatline).
* Use 'hoe/signing' for signed RubyGems.
* Moved to YARD based documentation.
* All specs now pass on JRuby 1.3.1.

### 0.1.1 / 2009-04-01

* Renamed CharSet#=~ to CharSet#===.
* Added an alias from CharSet#=~ to CharSet#===.

### 0.1.0 / 2009-03-16

* Initial release.
* Provides character sets for:
  * Numeric
  * Octal
  * Uppercase Hexadecimal
  * Lowercase Hexadecimal
  * Hexadecimal
  * Uppercase Alpha
  * Lowercase Alpha
  * Alpha
  * Alpha-numeric
  * Punctuation
  * Symbols
  * Space
  * Printable
  * Control
  * ASCII
* Provides convenience methods for testing wether a String or Integer
  belongs to a certain character set.
* Supports random text generation using specific character sets.

