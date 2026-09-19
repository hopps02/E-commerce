import 'package:flutter_test/flutter_test.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/views/user/product_details/riverpod/product_details_controller.dart';

void main() {
  const shorts = BranchProduct(id: 28, branchId: 1, nameAr: 'شورت جينز');
  const shirt = BranchProduct(id: 30, branchId: 1, nameAr: 'تيشرت');
  const jeans = BranchProduct(id: 27, branchId: 1, nameAr: 'وايد ليج');

  group('similarTo', () {
    test('offers the rest of the category, never the product itself', () {
      final offered = similarTo(shorts, [shorts, shirt, jeans]);

      expect(offered.map((one) => one.id), [30, 27]);
    });

    test('a category with nothing else in it offers nothing', () {
      expect(similarTo(jeans, [jeans]), isEmpty);
      expect(similarTo(jeans, const []), isEmpty);
    });

    test('stays one swipe long', () {
      final crowded = [
        for (var id = 100; id < 120; id += 1)
          BranchProduct(id: id, branchId: 1, nameAr: 'منتج $id'),
      ];

      expect(similarTo(shorts, crowded).length, 8);
    });
  });
}
