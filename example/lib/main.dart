import 'package:debang/debang.dart';

/// Demo for `debang_lints`.
///
/// Run `dart analyze` in this folder. Every line marked with ❌ is reported on
/// purpose; lines marked with ✅ pass.
void main() {
  int? value;

  // debang_message_too_short + debang_missing_author
  value.debang('Short message'); // ❌ too short and no author

  // debang_missing_author
  value.debang('Long message but without an author name'); // ❌ no author

  // debang_message_too_short
  value.debang('(John Doe): Short message'); // ❌ too short

  // OK: author name and a descriptive message
  value.debang(
    '(John Doe): Long message with author which will be without error',
  ); // ✅
  value.debang(
    '(Иван Петров): Достаточно длинное сообщение с автором, ошибки нет',
  ); // ✅

  // debang_avoid_bang
  int? bang;
  bang!.toString(); // ❌ bare null assertion operator

  // Suppress a rule for a single line
  int? ignored;
  ignored!.toString(); // ignore: debang_lints/debang_avoid_bang
}
