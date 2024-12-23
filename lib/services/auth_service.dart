import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinjamuang/ui/dashboart.dart';
import 'package:pinjamuang/ui/home.dart';
import 'package:pinjamuang/ui/login.dart';
// import 'package:mob3_zino_066_login_a2/pages/home/home.dart';
// import 'package:mob3_zino_066_login_a2/pages/login/login.dart';
// import 'package:mob3_zino_066_login_a2/pages/popup/pop_up.dart';
import 'package:pinjamuang/ui/pop_up.dart';

class AuthService {
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
      showSuccessPopup2(context);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'LEMAH';
      } else if (e.code == 'email-already-in-use') {
        message = 'EMAIL SUDAH ADA';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
      showSuccessPopup(context);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'email salah';
      } else if (e.code == 'invalid-credential') {
        message = 'password salah';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

    // Update Password
  Future<void> updatePassword({
    required String newPassword, 
    required BuildContext context
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (newPassword.length >= 6) {
          await user.updatePassword(newPassword);
          Fluttertoast.showToast(
            msg: "Password berhasil diubah!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Password harus lebih dari 6 karakter.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan saat mengubah password.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  // Delete Account
  Future<void> deleteAccount({
    required BuildContext context
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        Fluttertoast.showToast(
          msg: "Akun berhasil dihapus.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Login()
            )
        );
        showSuccessPopup3(context); // Optional: add success popup
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan saat menghapus akun.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

}
