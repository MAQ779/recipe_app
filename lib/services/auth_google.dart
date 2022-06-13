import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentification {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async{
    final signIn = GoogleSignIn();
   final user =  await signIn.signOut();
   if(user != null){
      final googleAuth = await user.authentication;
      if(googleAuth.idToken != null){
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential( idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
          return userCredential.user;
      }

   }
   else{
     throw FirebaseAuthException(
        message: 'sigh in aborded by user',
         code: 'ERROR_ABORDER_BY_USER');

   }
   return null;
  }

  Future<void> signOut() async{
    final signOut = GoogleSignIn();
    await signOut.signOut();
    await _firebaseAuth.signOut();
  }

}