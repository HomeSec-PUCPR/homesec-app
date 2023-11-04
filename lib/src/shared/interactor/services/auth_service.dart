import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../modules/auth/data/error/login_error.dart';
import '../../data/models/app_user_model.dart';

class AuthService {
  late AppUserModel user;
  User? firebaseUser;
  bool isLoggedIn = false;

  AuthService() {
    user = AppUserModel.empty();
  }

  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Either<LoginError, bool>> signIn(
      {required String email, required String password}) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await setUser(credentials.user);
      return Right(isLoggedIn);
    } on FirebaseAuthException {
      LoginError error = LoginError('O usuário ou a senha estã incorretos!');
      return Left(error);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    user = AppUserModel.empty();
  }

  Future<void> setUser(User? firebaseUser) async {
    this.firebaseUser = firebaseUser;
    isLoggedIn = this.firebaseUser != null;
    if (isLoggedIn) {
      await getUserData();
    } else {
      signOut();
    }
  }

  Future<void> getUserData() async {
    final ref = _firebaseDb.collection("Users").doc(firebaseUser!.uid);
    final result = await ref.get();
    if (result.exists) {
      user = AppUserModel.fromJson(result.data());
    }
  }
}
