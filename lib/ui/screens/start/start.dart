import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keep_clone/data/app_routes.dart';
import 'package:keep_clone/ui/utilities/app_extensions.dart';

///release
// /Users/persolsystems/remotenyame/projects/keystores/keep_clone
// Valid from: Wed May 24 16:03:56 GMT 2023 until: Wed May 06 16:03:56 GMT 2093
// Certificate fingerprints:
// SHA1: 09:B3:FB:28:60:77:07:F2:2C:32:59:80:E8:9B:9F:F8:86:4F:08:84
// SHA256: B0:CA:AA:A5:7E:50:F0:28:02:5A:5F:EA:5A:65:1D:2B:EB:33:C6:CC:A8:5D:71:B4:67:10:AC:35:C5:D9:3F:33
// Signature algorithm name: SHA256withRSA
// Subject Public Key Algorithm: 2048-bit RSA key
// Version: 1

///debug
// Valid from: Thu Nov 18 15:45:59 GMT 2021 until: Sat Nov 11 15:45:59 GMT 2051
// Certificate fingerprints:
// SHA1: 27:80:BD:49:F0:BD:23:32:2D:5C:39:04:14:C1:40:AE:7A:EE:DF:EF
// SHA256: D5:4A:2C:85:45:D4:16:C0:F7:53:3C:0E:34:E8:28:96:41:7F:E7:A4:9E:51:8D:9F:94:83:C5:2E:C2:9E:71:36
// Signature algorithm name: SHA1withRSA (weak)
// Subject Public Key Algorithm: 2048-bit RSA key
// Version: 1

final auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
final db = FirebaseFirestore.instance;

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
              'assets/images/keeps.png',
              fit: BoxFit.cover,
              width: 192,
            ))),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Capture anything',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                32.vSpacer,
                const Text(
                  'Make lists, take photos, speak your mind - whatever works for you, works in Keep.',
                  textAlign: TextAlign.center,
                ),
                32.vSpacer,
                FilledButton(
                  onPressed: () {
                    signInWithGoogle().then((user) {
                      db.collection('users').doc(user.user?.uid).set({
                        'email': user.user?.email,
                        'name': user.user?.displayName,
                        'photoUrl': user.user?.photoURL,
                        'uid': user.user?.uid,
                      }, SetOptions(merge: true)).then((_) {
                        db
                            .collection('users')
                            .doc(user.user?.uid)
                            .get()
                            .then((doc) {
                          if (doc.exists) {
                            context.goNamed(AppRoutes.home);
                          }
                        });
                      });
                    });
                  },
                  child: const Text('Get started'),
                ),
                32.vSpacer,
              ],
            )
          ],
        ),
      ),
    );
  }
}
