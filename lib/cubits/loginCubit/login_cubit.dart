import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginuser(BuildContext context,
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMassege: 'User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMassege: 'Wrong password'));
      } else {
        emit(LoginFailure(errorMassege: 'Something went wrong: ${ex.message}'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errorMassege: 'Something went wrong'));
    }
  }
}
