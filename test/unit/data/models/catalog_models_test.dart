import 'package:flutter_test/flutter_test.dart';
import 'package:store/data/response/customer/catalog_response.dart';

void main() {
  group('BranchProduct.fromJson', () {
    test('parses the products payload and computes display fields', () {
      final product = BranchProduct.fromJson(const {
        'id': 11,
        'branch_id': 1,
        'category_id': 4,
        'name_ar': 'بيض بلدي - طبق',
        'name_en': 'Eggs Tray',
        'image_url': 'https://cdn.4u.test/eggs.png',
        'price_halalas': 1500,
        'discount_halalas': 200,
        'available': 18,
        'stock_status': 'in_stock',
      });

      expect(product.name(true), 'بيض بلدي - طبق');
      expect(product.name(false), 'Eggs Tray');
      expect(product.hasDiscount, isTrue);
      expect(product.effectivePriceHalalas, 1300);
      expect(product.inStock, isTrue);
    });

    test('no discount and zero stock', () {
      final product = BranchProduct.fromJson(const {
        'id': 6,
        'branch_id': 1,
        'name_ar': 'موز - كجم',
        'price_halalas': 700,
        'discount_halalas': 0,
        'available': 0,
      });

      expect(product.hasDiscount, isFalse);
      expect(product.effectivePriceHalalas, 700);
      expect(product.inStock, isFalse);
      // Missing name_en falls back to the Arabic name.
      expect(product.name(false), 'موز - كجم');
    });
  });

  group('CartLine', () {
    const product = BranchProduct(
      id: 6,
      branchId: 1,
      nameAr: 'موز - كجم',
      priceHalalas: 700,
      discountHalalas: 100,
      available: 3,
    );

    test('line totals multiply by quantity', () {
      const line = CartLine(branchItemId: 6, quantity: 2, product: product);
      expect(line.lineSubtotalHalalas, 1400);
      expect(line.lineDiscountHalalas, 200);
    });

    test('wire shape carries only id and quantity', () {
      const line = CartLine(branchItemId: 6, quantity: 2, product: product);
      expect(line.toJson(), {'branch_item_id': 6, 'quantity': 2});
    });
  });

  group('CartValidationResult.fromJson', () {
    test('parses the validate payload', () {
      final result = CartValidationResult.fromJson(const {
        'branch_id': 1,
        'all_available': false,
        'lines': [
          {
            'branch_item_id': 6,
            'quantity': 5,
            'available': false,
            'reason': 'insufficient_stock',
            'unit_price_halalas': 700,
            'discount_halalas': 0,
            'available_quantity': 3,
          },
        ],
      });

      expect(result.branchId, 1);
      expect(result.allAvailable, isFalse);
      expect(result.lines.single.reason, 'insufficient_stock');
      expect(result.lines.single.availableQuantity, 3);
    });
  });

  group('CheckoutQuote.fromJson', () {
    test('parses backend-authoritative totals', () {
      final quote = CheckoutQuote.fromJson(const {
        'branch_id': 1,
        'all_available': true,
        'totals': {
          'subtotal_halalas': 2900,
          'delivery_fee_halalas': 1500,
          'discount_halalas': 200,
          'vat_halalas': 0,
          'total_halalas': 4200,
        },
      });

      expect(quote.totals.subtotalHalalas, 2900);
      expect(quote.totals.deliveryFeeHalalas, 1500);
      expect(quote.totals.totalHalalas, 4200);
      expect(quote.allAvailable, isTrue);
    });
  });

  group('DeliveryAddress.fromJson', () {
    test('parses the addresses payload', () {
      final address = DeliveryAddress.fromJson(const {
        'id': 5,
        'label': 'home',
        'label_text': 'المنزل',
        'display_address': 'حي العليا، شارع التحلية، الرياض',
        'street': 'شارع التحلية',
        'building_number': '12',
        'floor': '2',
        'apartment': '4',
        'landmark': 'بجوار حديقة العليا',
        'delivery_instructions': 'الرجاء الاتصال عند الوصول',
        'city_id': 1,
        'lat': 24.7136,
        'lng': 46.6753,
        'is_default': true,
      });

      expect(address.id, 5);
      expect(address.displayAddress, 'حي العليا، شارع التحلية، الرياض');
      expect(address.isDefault, isTrue);
      expect(address.detailsLine, 'شارع التحلية، 12، 2، 4');
    });

    test('detailsLine skips blank parts', () {
      const address = DeliveryAddress(
        id: 6,
        displayAddress: 'الرياض',
        street: 'طريق الملك عبدالعزيز',
        buildingNumber: '',
      );
      expect(address.detailsLine, 'طريق الملك عبدالعزيز');
    });
  });

  group('variants', () {
    final shirt = BranchProduct.fromJson(const {
      'id': 30,
      'branch_id': 1,
      'name_ar': 'تيشرت',
      'price_halalas': 12400,
      'available': 94,
      'variant_label': 'M',
      'attributes': {'material': 'قطن'},
      'variants': [
        {
          'id': 30,
          'label': 'M',
          'attributes': {'size': 'M'},
          'price_halalas': 12400,
          'discount_halalas': 0,
          'available': 94,
        },
        {
          'id': 32,
          'label': 'L',
          'attributes': {'size': 'L'},
          'price_halalas': 13900,
          'discount_halalas': 900,
          'available': 0,
        },
      ],
    });

    test('parses every size with its own price and count', () {
      expect(shirt.hasVariants, isTrue);
      expect(shirt.variantLabel, 'M');
      expect(shirt.variants.map((one) => one.name), ['M', 'L']);
      expect(shirt.variants.last.effectivePriceHalalas, 13000);
      expect(shirt.variants.last.inStock, isFalse);
    });

    test('picking a size swaps the shelf row and keeps the product', () {
      final large = shirt.withVariant(32);

      expect(large.id, 32);
      expect(large.priceHalalas, 13900);
      expect(large.discountHalalas, 900);
      expect(large.available, 0);
      expect(large.inStock, isFalse);
      expect(large.variantLabel, 'L');
      // The name and the specs belong to the product, not to the size.
      expect(large.nameAr, 'تيشرت');
      expect(large.attributes['material'], 'قطن');
      expect(large.attributes['size'], 'L');
      // Still offers every size, so the shopper can switch back.
      expect(large.variants.length, 2);
    });

    test('an id that is not one of the sizes changes nothing', () {
      expect(shirt.withVariant(999), same(shirt));
    });

    test('a plain product has no sizes to pick', () {
      const banana = BranchProduct(id: 6, branchId: 1, priceHalalas: 700);

      expect(banana.hasVariants, isFalse);
      expect(banana.withVariant(6), same(banana));
    });
  });

  group('specs', () {
    test('an empty map from PHP arrives as an empty list, and is no specs', () {
      final product = BranchProduct.fromJson(const {
        'id': 27,
        'branch_id': 1,
        'name_ar': 'وايد ليج',
        'price_halalas': 1400,
        'attributes': <dynamic>[],
      });

      expect(product.attributes, isEmpty);
    });

    test('values that are not text are printed as text', () {
      final product = BranchProduct.fromJson(const {
        'id': 27,
        'branch_id': 1,
        'attributes': {'weight': 1.5, 'origin': 'مصر'},
      });

      expect(product.attributes['weight'], '1.5');
      expect(product.attributes['origin'], 'مصر');
    });
  });
}
