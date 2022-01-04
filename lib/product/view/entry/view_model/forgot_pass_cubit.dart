import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class ForgotPassCubit extends Cubit<ForgotpassState> {
  ForgotPassCubit() : super(ForgotpassInitial());
}

@immutable
abstract class ForgotpassState {}

class ForgotpassInitial extends ForgotpassState {}