import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_clone/data/app_routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: FilledButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    context.goNamed(AppRoutes.start);
                  });
                },
                child: const Text('Sign out'),
              ),
            )),
        Expanded(
          child: Container(),
        )
      ],
    );
  }
}
