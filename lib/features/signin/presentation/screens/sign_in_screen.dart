import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            controller.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () =>
                        controller.signIn(emailCtrl.text, passCtrl.text),
                    child: const Text("Sign In"),
                  ),
            if (controller.error != null)
              Text(
                controller.error!,
                style: const TextStyle(color: Colors.red),
              ),
           
          ],
        ),
      ),
    );
  }
}
