part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}
final class RegisterSuccss extends RegisterState {}
final class RegisterFailure extends RegisterState {
    String errorMassege;
  RegisterFailure({required this.errorMassege});
}
