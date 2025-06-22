import 'package:flutter/material.dart';

class SignUpOptionsPage extends StatelessWidget {
  const SignUpOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Back to previous screen
                },
              ),
              const SizedBox(height: 1),

              // Sign up label
              const Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
              const SizedBox(height: 75),

              // Main Heading
              const Text(
                "We’re glad\nyou’re here!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B5320),
                  height: 1.1,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Sign in options
              _buildOptionButton("Sign in with Apple", Icons.apple, context),
              _buildOptionButton("Sign in with Facebook", Icons.facebook, context, iconColor: Colors.blue),
              _buildOptionButton("Sign in with Google", Icons.g_mobiledata, context, iconColor: Colors.red),
              _buildOptionButton("Sign in with Email", Icons.mail_outline, context),
              _buildOptionButton("Sign in with Phone Number", Icons.phone, context, iconColor: Colors.green),

              const Spacer(),

              // Terms and Privacy
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text.rich(
                    TextSpan(
                      text: "Continuing over means you’re agreeing to our\n",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, IconData icon, BuildContext context, {Color iconColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          // Later: Implement specific sign-in logic
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
