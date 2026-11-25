import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Analysis rule that reports the null assertion operator `!`.
///
/// Enabled by default and reported as an error.
///
/// Invalid: `name!.length`
/// Valid:   `name.debang('(john): set by the login flow').length`
class DebangAvoidBangRule extends AnalysisRule {
  /// Creates a new instance with the specified [severity].
  DebangAvoidBangRule({
    required this.severity,
  }) : super(
         name: ruleName,
         description: _description,
       );

  /// Diagnostic severity level (ERROR, WARNING, INFO, or HINT).
  final DiagnosticSeverity severity;

  /// The unique name identifier for this rule.
  static const String ruleName = 'debang_avoid_bang';

  static const String _description =
      'Avoid the null assertion operator `!`; use .debang() with an explanation';

  @override
  LintCode get diagnosticCode => LintCode(
    ruleName,
    'Avoid the null assertion operator `!`.',
    uniqueName: 'debang.$ruleName',
    correctionMessage:
        "Use `.debang('(username): why it is never null')` instead.",
    severity: severity,
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addPostfixExpression(this, _Visitor(rule: this, context: context));
  }
}

/// AST visitor that reports postfix `!` expressions.
class _Visitor extends SimpleAstVisitor<void> {
  _Visitor({
    required this.rule,
    required this.context,
  });

  final DebangAvoidBangRule rule;
  final RuleContext context;

  @override
  void visitPostfixExpression(PostfixExpression node) {
    if (node.operator.type != TokenType.BANG) return;

    final unit = context.currentUnit;
    if (unit == null) return;

    unit.diagnosticReporter.atNode(node, rule.diagnosticCode);
  }
}
