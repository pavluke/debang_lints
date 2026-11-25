/// Matches an author prefix such as `(john):`, `(John Doe):` or
/// `(Иван Петров):` at the start of a message.
///
/// The name may contain letters of any alphabet, digits, spaces, dots,
/// underscores and hyphens, and must start with a letter or a digit.
final RegExp authorPrefixPattern = RegExp(
  r'^\([\p{L}\p{N}][\p{L}\p{N} ._-]*\):',
  unicode: true,
);
