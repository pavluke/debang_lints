import 'package:debang_lints/src/author_pattern.dart';
import 'package:test/test.dart';

void main() {
  group('authorPrefixPattern', () {
    for (final message in [
      '(john): message',
      '(John Doe): message',
      '(john.doe): message',
      '(john_doe-1): message',
      '(Иван Петров): сообщение',
    ]) {
      test('accepts "$message"', () {
        expect(authorPrefixPattern.hasMatch(message), isTrue);
      });
    }

    for (final message in [
      'no author at all',
      '(): message',
      '( ): message',
      '(John Doe) message',
      '(John:Doe): message',
      ' (john): message',
    ]) {
      test('rejects "$message"', () {
        expect(authorPrefixPattern.hasMatch(message), isFalse);
      });
    }
  });
}
