# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

[En](README.md) | **Ru**

Кастомный плагин анализатора Dart, который проверяет качество сообщений
для `debang()`.

## О пакете Debang

[`debang`](https://github.com/pavluke/debang) — это библиотека для отладки,
предоставляющая расширение `.debang()` для nullable-типов с
сообщениями-утверждениями и исключение `Debang`, которое бросается, если значение равно null.
Этот линтер обеспечивает описательность и осмысленность всех
сообщений-утверждений.

<p align="center">Для лучшего понимания работы перейдите на <a href="https://pavluke.github.io/packages/?pkg=debang_lints">демо</a> страницу</p>

<div align="center">
  <a href="https://pavluke.github.io/packages/?pkg=debang_lints" 
     style="background: #10ac84; color: white; padding: 12px 24px; 
            text-decoration: none; border-radius: 6px; 
            font-weight: bold; display: inline-block;">
    Открыть демо
  </a>
</div>

## Описание

Плагин помогает поддерживать качество кода, гарантируя, что все отладочные
сообщения, переданные в `debang()`, являются описательными и полезными. Короткие
невнятные сообщения вроде `''` (пустая строка) или `'не будет null'` помечаются
как ошибки, а сообщения без имени автора — помечаются отдельно, побуждая
разработчиков писать осмысленный и ответственный отладочный вывод.

## Правила

| Правило | Описание | По умолчанию |
|---|---|---|
| `debang_message_too_short` | Сообщение должно быть не короче заданного количества символов | включено |
| `debang_missing_author` | Сообщение должно начинаться с имени автора `(Имя):` | включено |
| `debang_avoid_bang` | Сообщает об операторе null-assertion `!` | включено |

## Установка

> **Требования:** Плагины анализатора требуют Dart 3.10 или новее. Этот плагин
> проверен на Dart 3.14.

### 1. Добавьте в `analysis_options.yaml`

```yaml
plugins:
  debang_lints: ^2.0.0
```

> **Важно:** Все правила включены по умолчанию и считаются ошибками.

### 2. Перезапустите Analysis Server

Выполните `dart pub get`, затем:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Настройка

Все правила включены по умолчанию и считаются ошибками.

### Отключить правило во всём проекте

```yaml
plugins:
  debang_lints:
    version: ^2.0.0
    diagnostics:
      debang_message_too_short: false
      debang_missing_author: false
      debang_avoid_bang: false
```

После изменения секции `plugins:` перезапустите Analysis Server.

### Отключить правило для строки или файла

```dart
// ignore: debang_lints/debang_avoid_bang
final length = name!.length;

// ignore_for_file: debang_lints/debang_missing_author
```

### Сгенерированный код

Сгенерированные файлы (`*.g.dart`, `*.freezed.dart` и т. д.) анализируются как
любой другой код. Если в шапке файла есть `// ignore_for_file: type=lint`,
правила его тоже пропускают. Одного комментария `GENERATED CODE - DO NOT MODIFY
BY HAND` недостаточно, поэтому файлы без этой строки исключите (тогда они не
анализируются вообще):

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
```

### Уровень (severity)

Уровень правила изменить нельзя: настройка Dart `analyzer: errors:` не
распознаёт диагностики плагинов анализатора.

## Примеры использования

### `debang_message_too_short`

#### ❌ Плохо (вызывает ошибку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Не будет null.');  // Ошибка: сообщение слишком короткое
}
```

#### ✅ Хорошо (проходит проверку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang(
    'Переменная не будет null, поскольку после авторизации значение будет записано в локальное хранилище.'
  );  // OK
}
```

---

### `debang_missing_author`

Сообщение должно начинаться с `(username):` — по аналогии с соглашением `TODO(username):`.
Имя может содержать пробелы и буквы любого алфавита, например `(Иван Петров):`.

#### ❌ Плохо (вызывает ошибку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Не будет null после авторизации');  // Ошибка: отсутствует имя автора
}
```

#### ✅ Хорошо (проходит проверку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('(ivan): Не будет null, значение записывается после авторизации');  // OK
}
```

### `debang_avoid_bang`

Сообщает об операторе null-assertion `!`, чтобы одинокий `!` не проскочил в код
незамеченным (в том числе в код, предложенный нейросетью). Замените его на
`.debang()` с объяснением. Считается ошибкой. Сгенерированные файлы
(например, `*.g.dart`) можно исключить через `analyzer: exclude:` в
`analysis_options.yaml`.

#### ❌ Плохо (вызывает ошибку)

```dart
final length = name!.length;  // Ошибка: избегайте оператора !
```

#### ✅ Хорошо (проходит проверку)

```dart
final length = name
    .debang('(Иван Петров): имя записывается при входе до открытия этого экрана')
    .length;  // OK
```

## Changelog

Список изменений доступен в файле
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md).

## Contributions

Не стесняйтесь вносить свой вклад в этот проект. Если вы обнаружили ошибку или
хотите добавить новую функцию, но не знаете, как её реализовать, пожалуйста,
напишите в [issues](https://github.com/pavluke/debang_lints/issues). Если вы
исправили ошибку или внедрили функцию, сделайте
[pull request](https://github.com/pavluke/debang_lints/pulls).

## Лицензия

MIT License — см. файл LICENSE.
