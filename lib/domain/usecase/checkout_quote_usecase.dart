import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CheckoutQuoteParams {
  final int addressId;
  final List<CartLine> lines;

  const CheckoutQuoteParams({required this.addressId, required this.lines});
}

class CheckoutQuoteUseCase implements Base<CheckoutQuoteParams, CheckoutQuote> {
  final Repository _repository;

  CheckoutQuoteUseCase(this._repository);

  @override
  Future<Either<Failure, CheckoutQuote>> execute(CheckoutQuoteParams params) =>
      _repository.checkoutQuote(addressId: params.addressId, lines: params.lines);
}
