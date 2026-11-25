## 1.2.0

- Docs: describe how generated code is handled.
- Docs: describe how to disable rules and suppress diagnostics.
- Update to `analyzer` 14 and `analysis_server_plugin` 0.3.20+ (requires Dart
  3.10 or newer).
- Fix: the author name may now contain spaces and letters of any alphabet, e.g.
  `(John Doe):` or `(Иван Петров):`. Such messages were wrongly reported before.
- Add rule `debang_avoid_bang` (enabled by default, reported as an error)
  that reports the null assertion operator `!`.
- Docs: `debang_message_too_short` and `debang_missing_author` are enabled by
  default; fix the description of `Debang()`.
- Docs: the author rule is named `debang_missing_author` (the 1.1.0 entry
  below mentions a wrong name).

## 1.1.0

- Add `debang_message_missing_author` rule.

## 1.0.0

- Initial release.
- Add rule `debang_message_too_short`.
