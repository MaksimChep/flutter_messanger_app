import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messenger_app/data/services/shared_preferences_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SharedPreferencesService _sharedPreferencesService;

  AuthService(this._sharedPreferencesService);

  String verificationId = "";
  Future<void> createUserWithPhoneNumber(String phoneNumber) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: (String verId) {
          //Starts the phone number verification process for the given phone number.
          //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
          verificationId = verId;
        },
        codeSent: (String verId, int? forceCodeResend) {
          verificationId = verId;
        },
        timeout: const Duration(
          seconds: 120,
        ),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          print(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          throw exception;
        });
  }

  Future<void> verifyOTP(String otp) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    print(verificationId);
    final UserCredential user =
        await _firebaseAuth.signInWithCredential(credential);
    final User currentUser = _firebaseAuth.currentUser!;
    print(user);

    if (currentUser.uid != "") {
      print(currentUser.uid);
      await _sharedPreferencesService.setUid(currentUser.uid);
    }
  }
}
