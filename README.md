# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

**En** | [Ru](README_RU.md)

A custom Dart analyzer plugin that enforces quality standards for `debang()` calls.

## About Debang

[`debang`](https://github.com/pavluke/debang) is a debugging package that
provides the `.debang()` extension for nullable types with assertion messages
and the `Debang` exception that is thrown when the value is null. This linter ensures
all assertion messages are descriptive and meaningful.

<p align="center">For better understanding how it works check <a href="https://pavluke.github.io/packages/?pkg=debang_lints">demo</a> page</p>

<div align="center">
  <a href="https://pavluke.github.io/packages/?pkg=debang_lints" 
     style="background: #10ac84; color: white; padding: 12px 24px; 
            text-decoration: none; border-radius: 6px; 
            font-weight: bold; display: inline-block;">
    Open Demo
  </a>
</div>

## Overview

This plugin helps maintain code quality by ensuring that all debug messages
passed to `debang()` are descriptive and useful. Short, cryptic messages like
`''` (empty string) or `'won't be null'` are flagged, and messages without an
author name are reported — encouraging developers to write accountable,
meaningful debug output.

## Rules

| Rule | Description | Default |
|---|---|---|
| `debang_message_too_short` | Message must meet a minimum character length | enabled |
| `debang_missing_author` | Message must start with an author name `(Name):` | enabled |
| `debang_avoid_bang` | Reports the null assertion operator `!` | enabled |

## Installation

### 1. Add to `analysis_options.yaml`

```yaml
plugins:
  debang_lints: ^1.2.0
```

> **Note:** All rules are enabled by default and reported as errors.

### 2. Restart Analysis Server

Run `dart pub get`, then:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Configuration

All rules are enabled by default and reported as errors.

### Disable a rule in the whole project

```yaml
plugins:
  debang_lints:
    version: ^1.2.0
    diagnostics:
      debang_message_too_short: false
      debang_missing_author: false
      debang_avoid_bang: false
```

Restart the Analysis Server after changing the `plugins:` section.

### Suppress a rule for a line or a file

```dart
// ignore: debang_lints/debang_avoid_bang
final length = name!.length;

// ignore_for_file: debang_lints/debang_missing_author
```

### Generated code

Generated files (`*.g.dart`, `*.freezed.dart`, ...) are analyzed like any other
code. If the header of a generated file contains `// ignore_for_file: type=lint`
the rules skip it too. A header comment such as `GENERATED CODE - DO NOT MODIFY
BY HAND` alone is not enough, so exclude generated files that do not have that
line (they are then not analyzed at all):

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
```

### Severity

The severity of a rule cannot be changed: Dart's `analyzer: errors:` setting
does not recognize diagnostics of analyzer plugins.

## Usage Examples

### `debang_message_too_short`

#### ❌ Bad (triggers diagnostic)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("Won't be null");  // Error: assertion message too short
}
```

#### ✅ Good (passes validation)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang(
    "Value won't be null because it is written after authorization into local storage."
  );  // OK
}
```

---

### `debang_missing_author`

Messages must begin with `(username):`, similar to the `TODO(username):` convention.
The name may contain spaces and letters of any alphabet, e.g. `(John Doe):`.

#### ❌ Bad (triggers diagnostic)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("Won't be null after auth");  // Error: missing author name
}
```

#### ✅ Good (passes validation)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("(John Doe): Won't be null after auth flow completes");  // OK
}
```

### `debang_avoid_bang`

Reports the null assertion operator `!`, so a bare `!` cannot slip into the
code unnoticed (including code suggested by AI assistants). Replace it with
`.debang()` and an explanation. Reported as an error. Generated files (for
example `*.g.dart`) can be excluded with `analyzer: exclude:` in your
`analysis_options.yaml`.

#### ❌ Bad (triggers diagnostic)

```dart
final length = name!.length;  // Error: avoid the null assertion operator
```

#### ✅ Good (passes validation)

```dart
final length = name
    .debang('(John Doe): name is set by the login flow before this screen')
    .length;  // OK
```

## Changelog

The list of changes is available in
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md).

## Contributions

Feel free to contribute to this project. If you find a bug or want to add a new
feature but don't know how to fix/implement it, please open an
[issue](https://github.com/pavluke/debang_lints/issues). If you fixed a bug or
implemented a feature, please submit a
[pull request](https://github.com/pavluke/debang_lints/pulls).

## License

MIT License — see the LICENSE file for details.
