// import 'dart:convert';
// import 'dart:math';
// import 'package:crypto/crypto.dart';


// class FirebaseAuthService {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   // ******************** createUserWithEmailAndPassword ********************
//   Future<User> createUserWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     UserCredential userCredential =
//         await firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user!;
//   }

//   // ******************** singInwithEmailAndPassword ********************
//   Future<User> singInwithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     UserCredential userCredential =
//         await firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user!;
//   }

//   // ******************** singInWithGoogle ********************
//   Future<User> singInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(credential);
//     return userCredential.user!;
//   }

//   // ******************** singInWithFacebook ********************
//   Future<User> singInWithFacebook() async {
//     final LoginResult loginResult = await FacebookAuth.instance.login();

//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(
//       loginResult.accessToken!.tokenString,
//     );
//     UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(facebookAuthCredential);
//     return userCredential.user!;
//   }

//   // ******************** signInWithApple ********************

//   /// Generates a cryptographically secure random nonce, to be included in a
//   /// credential request.
//   String generateNonce([int length = 32]) {
//     const charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

//   /// Returns the sha256 hash of [input] in hex notation.
//   String sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   Future<User> signInWithApple() async {
//     // To prevent replay attacks with the credential returned from Apple, we
//     // include a nonce in the credential request. When signing in with
//     // Firebase, the nonce in the id token returned by Apple, is expected to
//     // match the sha256 hash of `rawNonce`.
//     final rawNonce = generateNonce();
//     final nonce = sha256ofString(rawNonce);

//     // Request credential for the currently signed in Apple account.
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       nonce: nonce,
//     );

//     // Create an `OAuthCredential` from the credential returned by Apple.
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       rawNonce: rawNonce,
//     );

//     // Sign in the user with Firebase. If the nonce we generated earlier does
//     // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//     UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(oauthCredential);
//     return userCredential.user!;
//   }

//   // ******************** createNewPassword ********************
//   Future<void> sendPasswordResetEmail({
//     required String userEmail,
//   }) async {
//     await firebaseAuth.sendPasswordResetEmail(email: userEmail);
//   }

//   // ******************** deleteUser ********************
//   Future<void> deleteUser() async {
//     await firebaseAuth.currentUser!.delete();
//   }

//   Future<void> sendEmailVerification() async {
//     await firebaseAuth.currentUser!.sendEmailVerification();
//   }

//   bool isUserLoggedIn() {
//     return firebaseAuth.currentUser != null;
//   }

//   bool isEmailVerified() {
//     return firebaseAuth.currentUser!.emailVerified;
//   }

//   Future<void> logOut() async {
//     await firebaseAuth.signOut();
//   }
// }
