import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/usecase/get_products_usecase.dart';

/// A home product row: a real category and its first shelf of products.
typedef HomeSection = ({ProductCategory category, List<BranchProduct> products});

class HomeCatalogState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final List<ProductCategory> categories;
  final List<HomeSection> sections;

  const HomeCatalogState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.categories = const [],
    this.sections = const [],
  });

  HomeCatalogState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<ProductCategory>? categories,
    List<HomeSection>? sections,
  }) {
    return HomeCatalogState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      sections: sections ?? this.sections,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, categories, sections];
}

/// Feeds the home tab from the real catalog: categories for the grid and the
/// first categories that actually stock products as the two product rows.
class HomeCatalogNotifier extends Notifier<HomeCatalogState> {
  static const int sectionCount = 2;
  static const int productsPerSection = 6;

  @override
  HomeCatalogState build() => const HomeCatalogState();

  Future<void> load() async {
    state = const HomeCatalogState();

    final categoriesResult = await DI().getCategoriesUseCase.execute(null);
    final categories = categoriesResult.fold<List<ProductCategory>?>((
      failure,
    ) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return null;
    }, (list) => list);
    if (categories == null) return;

    final productsResult = await DI().getProductsUseCase.execute(
      ProductsParams(page: 1, pageSize: 50),
    );
    productsResult.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (data) {
        final sections = <HomeSection>[];
        for (final category in categories) {
          if (sections.length == sectionCount) break;
          final products = data.products
              .where((p) => p.categoryId == category.id)
              .take(productsPerSection)
              .toList();
          if (products.isNotEmpty) {
            sections.add((category: category, products: products));
          }
        }
        state = state.copyWith(
          reqState: ReqState.success,
          categories: categories,
          sections: sections,
        );
      },
    );
  }
}

final homeCatalogController =
    NotifierProvider.autoDispose<HomeCatalogNotifier, HomeCatalogState>(
      HomeCatalogNotifier.new,
    );
