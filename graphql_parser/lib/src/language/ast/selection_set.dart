import 'package:source_span/source_span.dart';
import '../token.dart';
import 'node.dart';
import 'selection.dart';

class SelectionSetContext extends Node {
  final Token LBRACE, RBRACE;
  final List<SelectionContext> selections = [];

  SelectionSetContext(this.LBRACE, this.RBRACE);

  @override
  FileSpan get span {
    var out =
        selections.fold<FileSpan>(LBRACE.span, (out, s) => out.expand(s.span));
    return out.expand(RBRACE.span);
  }

  @override
  String toSource() {
    var buf = new StringBuffer('{');

    for (int i = 0; i < selections.length; i++) {
      if (i > 0) buf.write(',');
      buf.write(selections[i].toSource());
    }

    return buf.toString() + '}';
  }
}