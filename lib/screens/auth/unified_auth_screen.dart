import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/home_screen.dart';

/// تسجيل دخول وإنشاء حساب في شاشة واحدة (تبويبان).
class UnifiedAuthScreen extends StatefulWidget {
  /// 0 = تسجيل الدخول، 1 = إنشاء حساب
  final int initialTab;

  const UnifiedAuthScreen({super.key, this.initialTab = 0});

  @override
  State<UnifiedAuthScreen> createState() => _UnifiedAuthScreenState();
}

class _UnifiedAuthScreenState extends State<UnifiedAuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabs;

  final _loginFormKey = GlobalKey<FormState>();
  final _loginEmail = TextEditingController();
  final _loginPassword = TextEditingController();
  bool _loginObscure = true;
  bool _loginLoading = false;
  String? _loginError;

  final _regFormKey = GlobalKey<FormState>();
  final _regName = TextEditingController();
  final _regEmail = TextEditingController();
  final _regPhone = TextEditingController();
  final _regCity = TextEditingController();
  final _regPassword = TextEditingController();
  final _regConfirm = TextEditingController();
  bool _regObscure1 = true;
  bool _regObscure2 = true;
  bool _regLoading = false;
  String? _regError;

  @override
  void initState() {
    super.initState();
    final i = widget.initialTab.clamp(0, 1);
    _tabs = TabController(length: 2, vsync: this, initialIndex: i);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _loginEmail.dispose();
    _loginPassword.dispose();
    _regName.dispose();
    _regEmail.dispose();
    _regPhone.dispose();
    _regCity.dispose();
    _regPassword.dispose();
    _regConfirm.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (_loginLoading) return;
    if (!(_loginFormKey.currentState?.validate() ?? false)) return;
    setState(() {
      _loginError = null;
      _loginLoading = true;
    });
    HapticFeedback.lightImpact();
    final ok = await AuthService().login(
      _loginEmail.text.trim(),
      _loginPassword.text,
    );
    if (!mounted) return;
    setState(() => _loginLoading = false);
    if (ok) {
      Navigator.pushReplacement(context, AppTransitions.fadeScale(const HomeScreen()));
    } else {
      setState(() => _loginError = context.l10n.loginError);
    }
  }

  Future<void> _submitRegister() async {
    if (_regLoading) return;
    if (!(_regFormKey.currentState?.validate() ?? false)) return;
    setState(() {
      _regError = null;
      _regLoading = true;
    });
    HapticFeedback.lightImpact();
    final result = await AuthService().register(
      email: _regEmail.text.trim(),
      password: _regPassword.text,
      name: _regName.text.trim(),
      phone: _regPhone.text.trim().isEmpty ? null : _regPhone.text.trim(),
      city: _regCity.text.trim().isEmpty ? null : _regCity.text.trim(),
    );
    if (!mounted) return;
    setState(() => _regLoading = false);
    if (result['success'] == true) {
      Navigator.pushReplacement(context, AppTransitions.fadeScale(const HomeScreen()));
    } else {
      setState(() => _regError = result['message'] as String? ?? context.l10n.errorOccurred);
    }
  }

  /// أيقونات وحواف أوضح على خلفية الحقول الداكنة
  static const Color _fieldIconOnDark = AppColors.tealBright;

  InputDecoration _inputDecoration(String label, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _fieldIconOnDark),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.darkBlue.withValues(alpha: 0.55),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.tealBright.withValues(alpha: 0.45)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tealBright, width: 1.5),
      ),
      labelStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.92)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: const Color(0xFF000408),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 88,
                          height: 88,
                          color: AppColors.darkBlueMid,
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/images/Logo.jpg',
                            fit: BoxFit.contain,
                            gaplessPlayback: true,
                            filterQuality: FilterQuality.medium,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: AppColors.tealBright,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(l10n.appName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.white)),
                    // نص فرعي أوضح على التدرج (بدل تركواز على تركواز)
                    Text(
                      l10n.appSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        height: 1.2,
                        shadows: [
                          Shadow(color: AppColors.darkBlue.withValues(alpha: 0.65), offset: const Offset(0, 1), blurRadius: 8),
                          Shadow(color: AppColors.darkBlue.withValues(alpha: 0.4), blurRadius: 14),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.authUnifiedSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.white.withValues(alpha: 0.92),
                        height: 1.35,
                        shadows: [
                          Shadow(color: AppColors.darkBlue.withValues(alpha: 0.5), blurRadius: 6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabs,
                // تبويب نشط: أبيض على التدرج | غير نشط: أبيض شفاف (بدل تركواز يختفي على الخلفية)
                indicatorColor: AppColors.white,
                indicatorWeight: 3,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.white.withValues(alpha: 0.68),
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                dividerColor: AppColors.white.withValues(alpha: 0.22),
                tabs: [
                  Tab(text: l10n.login),
                  Tab(text: l10n.registerTitle),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _continueAsGuest,
                      icon: const Icon(Icons.travel_explore, size: 20, color: AppColors.tealBright),
                      label: Text(
                        l10n.continueAsGuest,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        side: BorderSide(color: AppColors.tealBright.withValues(alpha: 0.95), width: 1.5),
                        backgroundColor: AppColors.darkBlue.withValues(alpha: 0.45),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.guestModeNote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.85),
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: [
                    _buildLoginTab(context),
                    _buildRegisterTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _continueAsGuest() async {
    HapticFeedback.lightImpact();
    // ضمان أن الزائر فعلاً غير مسجّل — إلغاء أي جلسة محفوظة سابقة.
    await AuthService().logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      AppTransitions.fadeScale(const HomeScreen()),
      (_) => false,
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _loginFormKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.darkBlueLight.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_loginError != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.rose.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.rose, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_loginError!, style: const TextStyle(color: AppColors.rose, fontSize: 13))),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _loginEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(l10n.email, Icons.email_outlined),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) => v == null || v.trim().isEmpty ? l10n.enterEmail : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _loginPassword,
                obscureText: _loginObscure,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitLogin(),
                decoration: _inputDecoration(
                  l10n.password,
                  Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(_loginObscure ? Icons.visibility_off : Icons.visibility, color: _fieldIconOnDark),
                    onPressed: () => setState(() => _loginObscure = !_loginObscure),
                  ),
                ),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) => v == null || v.isEmpty ? l10n.enterPassword : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _loginLoading ? null : _submitLogin,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    foregroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _loginLoading
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkBlue))
                      : Text(l10n.loginButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterTab(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _regFormKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.darkBlueLight.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_regError != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.rose.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.rose, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_regError!, style: const TextStyle(color: AppColors.rose, fontSize: 13))),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _regName,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(l10n.fullName, Icons.person_outline),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) => v == null || v.trim().isEmpty ? l10n.enterName : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _regEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(l10n.email, Icons.email_outlined),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) => v == null || v.trim().isEmpty ? l10n.enterEmail : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _regPhone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(l10n.phoneOptional, Icons.phone_outlined),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _regCity,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(l10n.cityOptional, Icons.location_city_outlined),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _regPassword,
                obscureText: _regObscure1,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration(
                  l10n.passwordMin,
                  Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(_regObscure1 ? Icons.visibility_off : Icons.visibility, color: _fieldIconOnDark),
                    onPressed: () => setState(() => _regObscure1 = !_regObscure1),
                  ),
                ),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.enterPassword;
                  if (v.length < 6) return l10n.minChars;
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _regConfirm,
                obscureText: _regObscure2,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitRegister(),
                decoration: _inputDecoration(
                  l10n.confirmPassword,
                  Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(_regObscure2 ? Icons.visibility_off : Icons.visibility, color: _fieldIconOnDark),
                    onPressed: () => setState(() => _regObscure2 = !_regObscure2),
                  ),
                ),
                style: AppTheme.arabicTextStyle(color: AppColors.white),
                validator: (v) => v != _regPassword.text ? l10n.passwordMismatch : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _regLoading ? null : _submitRegister,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    foregroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _regLoading
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkBlue))
                      : Text(l10n.registerButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
