import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';

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
      expect(address.cityId, 1);
      expect(address.lat, 24.7136);
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

  group('CoverageResult.fromJson', () {
    test('parses the coverage payload', () {
      final coverage = CoverageResult.fromJson(const {
        'is_serviceable': true,
        'city_id': 1,
        'delivery_fee_halalas': 1500,
      });
      expect(coverage.isServiceable, isTrue);
      expect(coverage.cityId, 1);
      expect(coverage.deliveryFeeHalalas, 1500);
    });
  });
}
