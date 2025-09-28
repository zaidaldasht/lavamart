import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/enums.dart';
import '../../core/error/failures.dart';
import '../../data/models/products/filter_params_model.dart';
import '../../domain/entities/products/pagination_meta_data.dart';
import '../../domain/usecases/products/get_product_usecase.dart';
import '../../../domain/entities/products/product.dart';


part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase _getProductUseCase;

  ProductBloc(this._getProductUseCase)
      : super(ProductInitial(
      products: const [],
      params: const FilterProductParams(),
      metaData: PaginationMetaData(
        pageSize: 20,
        limit: 0,
        total: 0,
      ))) {
    on<GetProducts>(_onLoadProducts);
    on<GetMoreProducts>(_onLoadMoreProducts);
    on<SortProducts>(_onSortProducts);
  }

  void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading(
        products: const [],
        metaData: state.metaData,
        params: event.params,
      ));
      final result = await _getProductUseCase(event.params);
      result.fold(
            (failure) => emit(ProductError(
          products: state.products,
          metaData: state.metaData,
          failure: failure,
          params: event.params,
        )),
            (productResponse) => emit(ProductLoaded(
          metaData: productResponse.paginationMetaData,
          products: productResponse.products,
          params: event.params,
        )),
      );
    } catch (e) {
      emit(ProductError(
        products: state.products,
        metaData: state.metaData,
        failure: ExceptionFailure(),
        params: event.params,
      ));
    }
  }

  void _onSortProducts(SortProducts event, Emitter<ProductState> emit) {
    // Use the sort order from the event to trigger sorting
    if (event.sortOrder != null) {
      state.products.sort((a, b) {
        switch (event.sortOrder!) {
          case SortOrder.newest:
            return b.Createdate.compareTo(a.Createdate);
          case SortOrder.highToLow:
            return b.Price.compareTo(a.Price);
          case SortOrder.lowToHigh:
            return a.Price.compareTo(b.Price);
          case SortOrder.aToZ:
            return a.ProductName.compareTo(b.ProductName);
          case SortOrder.zToA:
            return b.ProductName.compareTo(a.ProductName);
        }
      });
    } else {
// to be continued later
    }

    emit(ProductLoaded(
      metaData: state.metaData,
      products: state.products,
      params: state.params,
    ));
  }

  void _onLoadMoreProducts(
      GetMoreProducts event, Emitter<ProductState> emit) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedProductsLength = state.products.length;
    // check state and loaded products amount[loadedProductsLength] compare with
    // number of results total[total] results available in server
    if (state is ProductLoaded && (loadedProductsLength < total)) {
      try {
        emit(ProductLoading(
          products: state.products,
          metaData: state.metaData,
          params: state.params,
        ));
        final result =
        await _getProductUseCase(FilterProductParams(limit: limit + 10));
        result.fold(
              (failure) => emit(ProductError(
            products: state.products,
            metaData: state.metaData,
            failure: failure,
            params: state.params,
          )),
              (productResponse) {
            List<ProductEntity> products = state.products;
            products.addAll(productResponse.products);
            emit(ProductLoaded(
              metaData: state.metaData,
              products: products,
              params: state.params,
            ));
          },
        );
      } catch (e) {
        emit(ProductError(
          products: state.products,
          metaData: state.metaData,
          failure: ExceptionFailure(),
          params: state.params,
        ));
      }
    }
  }
}
