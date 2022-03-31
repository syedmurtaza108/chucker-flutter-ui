import 'package:chucker_flutter_ui/src/view/json_tree/json_tree.dart';
import 'package:chucker_flutter_ui/src/view/widgets/sizeable_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool _favoritePersonalitiesButton(Element element) {
    return (element.widget as SizeableTextButton).text ==
        'favoritePersonalities';
  }

  String _toText(Element element) {
    return (element.widget as Text).data ?? '';
  }

  String _toKeyFormat(String key) {
    return '$key:';
  }

  testWidgets(
    'JsonTree should be able to parse single json object',
    (WidgetTester tester) async {
      ///⚠️ DON'T CHANGE CONTENT OTHERWISE TEST MAY FAIL
      const json = {
        'id': 1,
        'name': 'Syed Murtaza',
        'weight': 56.8,
        'isInPakistan': true,
        'favoritePersonalities': ['Allama Iqbal', 'Muhammad Ali Jinnah']
      };

      await tester.pumpWidget(const MaterialApp(home: JsonTree(json: json)));

      //favoritePersonalities is expandable therefore it needs to be pressed
      //on to expand
      final personalitiesButton = find
          .byType(SizeableTextButton)
          .evaluate()
          .where(_favoritePersonalitiesButton)
          .first
          .widget;

      //Expanded
      await tester.tap(find.byWidget(personalitiesButton));
      await tester.pumpAndSettle();

      final finder = find.byType(Text);
      final elements = finder.evaluate().toList();

      final keys = json.keys;
      final values = json.values;

      expect(_toText(elements[0]), _toKeyFormat(keys.elementAt(0)));
      expect(_toText(elements[1]), values.elementAt(0).toString());
      expect(_toText(elements[3]), _toKeyFormat(keys.elementAt(1)));
      expect(_toText(elements[4]), '"${values.elementAt(1)}"');
      expect(_toText(elements[6]), _toKeyFormat(keys.elementAt(2)));
      expect(_toText(elements[7]), values.elementAt(2).toString());
      expect(_toText(elements[9]), _toKeyFormat(keys.elementAt(3)));
      expect(_toText(elements[10]), values.elementAt(3).toString());
      expect(_toText(elements[14]), _toKeyFormat('[0]'));
      expect(
        _toText(elements[15]),
        '"${(values.last as List).first}"',
      );
      expect(_toText(elements[17]), _toKeyFormat('[1]'));
      expect(
        _toText(elements[18]),
        '"${(values.last as List).elementAt(1)}"',
      );
    },
  );

  testWidgets(
    'JsonTree should be able to parse json array',
    (WidgetTester tester) async {
      ///⚠️ DON'T CHANGE CONTENT OTHERWISE TEST MAY FAIL
      const json = [
        {
          'id': 1,
          'name': 'Syed Murtaza',
        },
        {
          'id': 2,
          'name': 'Syed Murtaza',
        }
      ];

      await tester.pumpWidget(const MaterialApp(home: JsonTree(json: json)));

      //Need to expand both objects
      final buttons = find.byType(SizeableTextButton).evaluate();

      //Expanded
      await tester.tap(find.byWidget(buttons.first.widget));
      await tester.pumpAndSettle();
      await tester.tap(find.byWidget(buttons.last.widget));
      await tester.pumpAndSettle();

      final finder = find.byType(Text);
      final elements = finder.evaluate().toList();

      //Parsing object 1
      final object1Keys = json[0].keys;
      final object1values = json[0].values;

      expect(_toText(elements[0]), _toKeyFormat('[0]'));
      expect(_toText(elements[2]), _toKeyFormat(object1Keys.elementAt(0)));
      expect(_toText(elements[3]), object1values.elementAt(0).toString());
      expect(_toText(elements[5]), _toKeyFormat(object1Keys.elementAt(1)));
      expect(_toText(elements[6]), '"${object1values.elementAt(1)}"');

      //Parsing object 2
      final object2Keys = json[1].keys;
      final object2values = json[1].values;

      expect(_toText(elements[8]), _toKeyFormat('[1]'));
      expect(_toText(elements[10]), _toKeyFormat(object2Keys.elementAt(0)));
      expect(_toText(elements[11]), object2values.elementAt(0).toString());
      expect(_toText(elements[13]), _toKeyFormat(object2Keys.elementAt(1)));
      expect(_toText(elements[14]), '"${object2values.elementAt(1)}"');
    },
  );
}
