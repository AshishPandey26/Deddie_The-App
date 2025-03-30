import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/auth_state.dart';
import '../controllers/auth_controller.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../../core/theme/frost_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF4D4),
              const Color(0xFFFFE4A3).withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    _buildHeader(),
                    const SizedBox(height: 48),
                    _buildLoginForm(),
                    const SizedBox(height: 24),
                    _buildForgotPassword(),
                    const SizedBox(height: 32),
                    _buildLoginButton(),
                    const SizedBox(height: 24),
                    _buildDivider(),
                    const SizedBox(height: 24),
                    _buildSocialLogin(),
                    const SizedBox(height: 32),
                    _buildSignUpLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_outline_rounded,
            size: 50,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Sign in to continue",
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF2D2D2D).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildInputField(
          controller: _emailController,
          label: "Email",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _buildInputField(
          controller: _passwordController,
          label: "Password",
          icon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: _isPasswordVisible,
          onVisibilityToggle: () {
            setState(() => _isPasswordVisible = !_isPasswordVisible);
          },
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool? isPasswordVisible,
    VoidCallback? onVisibilityToggle,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !(isPasswordVisible ?? false),
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF2D2D2D), fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: const Color(0xFF2D2D2D).withOpacity(0.7),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF2D2D2D).withOpacity(0.7),
          ),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isPasswordVisible ?? false
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF2D2D2D).withOpacity(0.7),
                    ),
                    onPressed: onVisibilityToggle,
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF2D2D2D)),
        child: const Text(
          "Forgot Password?",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authControllerProvider);

        return authState.when(
          initial: () => _buildLoginButtonContent(),
          loading:
              () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF2D2D2D)),
              ),
          authenticated: () => _buildLoginButtonContent(),
          error: (message) => _buildLoginButtonContent(),
        );
      },
    );
  }

  Widget _buildLoginButtonContent() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D2D2D).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ref
                .read(authControllerProvider.notifier)
                .login(_emailController.text, _passwordController.text);
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF2D2D2D).withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Or continue with",
            style: TextStyle(
              color: const Color(0xFF2D2D2D).withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF2D2D2D).withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: 'assets/icons/google.png',
          onTap: () {
            // TODO: Implement Google sign in
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: 'assets/icons/apple.png',
          onTap: () {
            // TODO: Implement Apple sign in
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(child: Image.asset(icon, width: 24, height: 24)),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: const Color(0xFF2D2D2D).withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to sign up page
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF2D2D2D),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
