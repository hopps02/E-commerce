import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// Files that answer to geometry rather than to rhythm: a vendored scrollbar
/// and the collapsing header, whose numbers come from the shapes they draw.
const _notRhythm = ['ui_kit/custom_scrollbar.dart', 'common/home_top_app_bar.dart'];

/// A gap or a padding written as a bare number, anywhere in the app.
final _gap = RegExp(r'(?<![\w.])(\d+(?:\.\d+)?)\.(verticalSpace|horizontalSpace)');
final _inset = RegExp(r'EdgeInsets(?:Directional)?\.(?:all|symmetric|only|fromLTRB|fromSTEB)\(([^;]{0,200}?)\)');
final _number = RegExp(r'(?<![\w.])(\d+(?:\.\d+)?)(?![\d])');

void main() {
  group('the spacing scale', () {
    test('is a 4px grid, in order, with nothing in between', () {
      const scale = [
        SpaceM.s1,
        SpaceM.s2,
        SpaceM.s3,
        SpaceM.s4,
        SpaceM.s5,
        SpaceM.s6,
        SpaceM.s7,
        SpaceM.s8,
        SpaceM.s10,
        SpaceM.s12,
        SpaceM.s16,
      ];

      for (final step in scale) {
        expect(step % 4, 0, reason: '$step is not on the 4px grid');
      }
      for (var index = 1; index < scale.length; index += 1) {
        expect(scale[index], greaterThan(scale[index - 1]));
      }
    });

    test('every name means one of the steps', () {
      for (final named in [
        SpaceM.page,
        SpaceM.section,
        SpaceM.card,
        SpaceM.heading,
        SpaceM.row,
        SpaceM.icon,
        SpaceM.label,
        SpaceM.chip,
        SpaceM.bottomBar,
      ]) {
        expect(named % 4, 0, reason: '$named is not on the scale');
      }
    });

    /// The scale is only a system while the screens actually use it. This
    /// reads the app the way the migration did and fails on anything that
    /// went back to writing gaps by hand.
    test('no screen writes a gap of its own', () {
      final offenders = <String>[];

      for (final file in Directory('lib').listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        if (file.path.endsWith('.g.dart') || file.path.endsWith('.freezed.dart')) continue;

        final path = file.path.replaceAll(r'\', '/');
        if (_notRhythm.any(path.endsWith)) continue;

        final text = file.readAsStringSync();

        for (final match in _gap.allMatches(text)) {
          offenders.add('$path: ${match.group(0)}');
        }

        for (final inset in _inset.allMatches(text)) {
          final inner = inset.group(1) ?? '';
          for (final match in _number.allMatches(inner)) {
            final value = double.parse(match.group(1)!);
            // Zero is zero, and arithmetic is not a gap.
            if (value == 0) continue;
            final before = inner.substring(0, match.start).trimRight();
            final after = inner.substring(match.end).trimLeft();
            if (before.isNotEmpty && '/*+-'.contains(before[before.length - 1])) continue;
            // A number being compared against is an index, not a gap.
            if (before.endsWith('==') || before.endsWith('<') || before.endsWith('>')) continue;
            if (after.isNotEmpty && '/*+-'.contains(after[0])) continue;

            offenders.add('$path: ${inset.group(0)}');
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason: 'These write spacing by hand instead of asking SpaceM:\n${offenders.join('\n')}',
      );
    });
  });
}
