# Chars

[![CI](https://github.com/postmodern/chars.rb/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/chars.rb/actions/workflows/ruby.yml)

* [Source](https://github.com/postmodern/chars.rb#readme)
* [Issues](https://github.com/postmodern/chars.rb/issues)
* [Documentation](https://rubydoc.info/gems/chars)

## Description

Chars is a Ruby library for working with various character sets,
recognizing text and generating random text from specific character sets.

## Features

* Provides character sets for:
  * Numeric: `0` - `9`
  * Octal: `0` - `7`
  * Uppercase Hexadecimal: `0` - `9`, `A` - `F`
  * Lowercase Hexadecimal: `0` - `9`, `a` - `f`
  * Hexadecimal: `0` - `9`, `a` - `f`, `A` - `F`
  * Uppercase Alpha: `A` - `Z`
  * Lowercase Alpha: `a` - `z`
  * Alpha: `a` - `z`, `A` - `Z`
  * Alpha-numeric: `0` - `9`, `a` - `z`, `A` - `Z`
  * Punctuation: `' '`, `'`, `"`, `` ` ``, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`
  * Symbols: `' '`, `'`, `"`, `` ` ``, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `_`, `+`, `=`, `|`, `\`, `<`, `>`, `/`
  * Space: `' '`, `\f`, `\n`, `\r`, `\t`, `\v`
  * Visible: `0` - `9`, `a` - `z`, `A` - `Z`, `'`, `"`, `` ` ``, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `_`, `+`, `=`, `|`, `\`, `<`, `>`, `/`
  * Printable: `0` - `9`, `a` - `z`, `A` - `Z`, `' '`, `'`, `"`, `` ` ``, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, <code>*</code>, <code>_</code>, `+`, `=`, `|`, `\`, `<`, `>`, `/`, `\f`, `\n`, `\r`, `\t`, `\v`
  * Control: `\x00` - `\x1f`, `\x7f`
  * Signed ASCII: `\x00` - `\x7f`
  * ASCII: `\x00` - `\xff`

## Examples

Determine whether a byte belongs to a character set:

```ruby
0x41.alpha?
# => true
```

Determine whether a String belongs to a character set:

```ruby
"22e1c0".hex?
# => true
```

Return a random character from the set of all characters:

```ruby
Chars.all.random_char
# => "\x94"
```

Return a random Array of characters from the alpha-numeric character set:

```ruby
Chars.alpha_numeric.random_chars(10)
# => ["Q", "N", "S", "4", "x", "z", "3", "M", "F", "F"]
```

Return a random Array of a random length of unique characters from the
visible character set:

```ruby
Chars.visible.random_distinct_chars(1..10)
# => ["S", "l", "o", "8", "'", "q"]
```

Return a random String from the set of all characters:

```ruby
Chars.all.random_string(10)
# => "\xc2h\xad\xccm7\x1e6J\x13"
```

Return a random String with a random length between 5 and 10, from the
set of space characters:

```ruby
Chars.space.random_string(5..10)
# => "\r\v\n\t\n\f"
```

Find all sub-strings that belong to a character set within a String:

```ruby
ls = File.read('/bin/ls')
Chars.printable.substrings(ls)
# => ["/lib64/ld-linux-x86-64.so.2", "KIq/", "5J~!", "%L~!", ...]
```

## Requirements

* [ruby](https://www.ruby-lang.org/) >= 2.0.0

## Install

    $ gem install chars

### gemspec

```ruby
gem.add_dependency 'chars', '~> 0.2'
```

### Gemfile

```ruby
gem 'chars', '~> 0.2'
```

## Crystal

[chars.cr] is a [Crystal] port of this library.

[chars.cr]: https://github.com/postmodern/chars.cr
[Crystal]: https://crystal-lang.org/

## License

See {file:LICENSE.txt} for license information.

