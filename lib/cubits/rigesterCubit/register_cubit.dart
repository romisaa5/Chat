import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frist/helper/show_snack_bar.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> signupmethod(BuildContext context,
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      var auth = FirebaseAuth.instance;

      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccss());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
      emit( RegisterFailure(errorMassege:  'The password provided is too weak.'));
      } else if (ex.code == 'email-already-in-use') {
   emit( RegisterFailure(errorMassege:'The account already exists for that email.'));
      }
    } catch (e) {
 
   emit( RegisterFailure(errorMassege:'there was an error ,please try again '));
    }
  }
}
