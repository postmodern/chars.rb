### 0.3.2 / 2022-12-02

* Ensure all character Strings within the {Chars} character sets are encoded as
  ASCII-8bit. This prevents transcoding issues when calling
  `Chars::ASCII.random_string(length)`.
* Changed {Chars::CharSet#initialize} to encode bytes greater than 256 as UTF-8.
  Otherwise, bytes less than 256 will be encoded as ASCII-8bit.

### 0.3.1 / 2022-12-01

* Removed the space character from {Chars::PUNCTUATION}, as spaces are not
  technically a punctuation character.
* Removed `\f`, `\n`, `\r`, `\t`, and `\v` from {Chars::PRINTABLE}, as other
  whitespace characters besides space (`' '`) are not considered printable
  characters.

### 0.3.0 / 2021-10-23

* Added {Chars::WHITESPACE}.
* Added {Chars::DIGITS}.
* Added {Chars::CharSet#each_substring_with_index}.
* Added {Chars::CharSet#substrings_with_indexes}.
* Added {Chars::CharSet#each_substring}.
* Added {Chars::CharSet#substrings}.
* Added {Chars::CharSet#each_string_of_length}.
* Added {Chars::CharSet#strings_of_length}.
* Added {Chars::StringEnumerator}.

### 0.2.4 / 2021-10-22

* Require [ruby] >= 2.0.0.
* Added {Chars::CharSet#initialize_copy} to prevent leaking characters
  between copied {Chars::CharSet} objects.

### 0.2.3 / 2020-12-25

* Change {Chars::CharSet} to inherit from `Set`, instead of `SortedSet`.

### 0.2.2 / 2012-05-28

* {Chars::CharSet#initialize} now raises a `TypeError` when given arguments
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

* Require `hoe` >= 2.3.3.
* Require `yard` >= 0.2.3.5.
* Require `rspec` >= 1.2.8.
* Added {Chars.visibile} and {Chars::VISIBLE} (thanks flatline).
* Added {Chars::CharSet#random_distinct_bytes},
  {Chars::CharSet#random_distinct_chars}, and {CharSet#random_distinct_string}
  (thanks flatline).
* Use `hoe/signing` for signed RubyGems.
* Moved to YARD based documentation.
* All specs now pass on JRuby 1.3.1.

### 0.1.1 / 2009-04-01

* Renamed {Chars::CharSet#=~} to {Chars::CharSet#===}.
* Added an alias from `Chars::CharSet#=~` to {Chars::CharSet#===}.

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
* Provides convenience methods for testing whether a `String` or `Integer`
  belongs to a certain character set.
* Supports random text generation using specific character sets.

[ruby]: https://www.ruby-lang.org/
