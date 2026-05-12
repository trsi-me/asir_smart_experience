import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/guest_policy.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/provider/provider_subscription_screen.dart';

/// نموذج تسجيل أصحاب الأنشطة والمنشآت (وثيقة المنصة).
class ProviderRegistrationScreen extends StatefulWidget {
  const ProviderRegistrationScreen({super.key});

  @override
  State<ProviderRegistrationScreen> createState() =>
      _ProviderRegistrationScreenState();
}

class _ProviderRegistrationScreenState
    extends State<ProviderRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _establishment = TextEditingController();
  final _activityType = TextEditingController();
  final _contactName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _city = TextEditingController();
  final _description = TextEditingController();
  final _mapUrl = TextEditingController();
  final _hours = TextEditingController();
  final _price = TextEditingController();
  final _booking = TextEditingController();
  final _social = TextEditingController();

  String _category = 'مطعم';
  final List<String> _photoPaths = [];

  static const _categories = [
    'مطعم',
    'كافيه',
    'فعالية',
    'أسرة منتجة',
    'منتزه',
    'تخييم',
    'هايكنق',
    'رحلة بحرية',
    'غوص',
    'زيارة جزر',
    'مرشد سياحي',
    'نشاط عائلي',
    'مغامرات',
    'أخرى',
  ];

  bool get _emailLocked => AuthService().isLoggedIn;

  @override
  void initState() {
    super.initState();
    final auth = AuthService();
    if (auth.isLoggedIn && (auth.currentUserEmail ?? '').isNotEmpty) {
      _email.text = auth.currentUserEmail!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!AuthService().isLoggedIn) {
        showProviderAccountRequiredDialog(context);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _establishment.dispose();
    _activityType.dispose();
    _contactName.dispose();
    _phone.dispose();
    _email.dispose();
    _city.dispose();
    _description.dispose();
    _mapUrl.dispose();
    _hours.dispose();
    _price.dispose();
    _booking.dispose();
    _social.dispose();
    super.dispose();
  }

  Future<void> _pickActivityPhoto() async {
    final l10n = context.l10n;
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.activityPhotosHint),
          backgroundColor: AppColors.amber,
        ),
      );
      return;
    }
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.darkBlueLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.teal),
                title: Text(
                  l10n.pickFromGallery,
                  style: const TextStyle(color: AppColors.white),
                ),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.teal),
                title: Text(
                  l10n.takePhoto,
                  style: const TextStyle(color: AppColors.white),
                ),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null || !mounted) return;
    try {
      final xFile = await picker.pickImage(
        source: source,
        maxWidth: 1400,
        imageQuality: 82,
      );
      if (xFile == null || !mounted) return;
      final appDir = await getApplicationDocumentsDirectory();
      final dir = Directory(path.join(appDir.path, 'provider_activity_photos'));
      if (!await dir.exists()) await dir.create(recursive: true);
      final name = xFile.name;
      final ext = (name.isNotEmpty && path.extension(name).isNotEmpty)
          ? path.extension(name)
          : '.jpg';
      final fileName =
          'prov_${DateTime.now().millisecondsSinceEpoch}$ext';
      final destPath = path.join(dir.path, fileName);
      final bytes = await xFile.readAsBytes();
      await File(destPath).writeAsBytes(bytes);
      if (mounted) {
        setState(() => _photoPaths.add(destPath));
        HapticFeedback.lightImpact();
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.photoAddFailed),
            backgroundColor: AppColors.rose,
          ),
        );
      }
    }
  }

  void _next() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final auth = AuthService();
    if (auth.isLoggedIn &&
        auth.currentUserEmail != null &&
        _email.text.trim().toLowerCase() !=
            auth.currentUserEmail!.trim().toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.providerAccountRequiredMessage),
          backgroundColor: AppColors.rose,
        ),
      );
      return;
    }
    HapticFeedback.lightImpact();
    final draft = {
      'establishment_name': _establishment.text.trim(),
      'activity_type': _activityType.text.trim(),
      'contact_name': _contactName.text.trim(),
      'phone': _phone.text.trim(),
      'email': _email.text.trim(),
      'city': _city.text.trim().isEmpty ? '—' : _city.text.trim(),
      'description': _description.text.trim(),
      'category': _category,
      'map_url': _mapUrl.text.trim(),
      'hours': _hours.text.trim(),
      'price_note': _price.text.trim(),
      'booking_link': _booking.text.trim(),
      'social': _social.text.trim(),
      'activity_photos': jsonEncode(_photoPaths),
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProviderSubscriptionScreen(draft: draft),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: Text(l10n.providerFlowTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.providerBasicSection,
              style: const TextStyle(
                color: AppColors.teal,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _field(l10n.establishmentName, _establishment, required: true),
            _field(l10n.activityTypeField, _activityType, required: true),
            _field(l10n.contactPerson, _contactName, required: true),
            _field(l10n.phoneRequired, _phone, required: true, phone: true),
            _field(
              l10n.email,
              _email,
              required: true,
              email: true,
              readOnly: _emailLocked,
            ),
            if (_emailLocked)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  l10n.providerEmailLockedHint,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white80.withValues(alpha: 0.9),
                    height: 1.35,
                  ),
                ),
              ),
            _field(l10n.cityOptional, _city),
            _field(
              l10n.shortDescription,
              _description,
              maxLines: 3,
              required: true,
            ),
            const SizedBox(height: 12),
            Text(l10n.categoryPick, style: const TextStyle(color: AppColors.teal)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _category,
              dropdownColor: AppColors.darkBlueLight,
              style: const TextStyle(color: AppColors.white),
              decoration: _decoration(''),
              items: _categories
                  .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _category = v);
              },
            ),
            const SizedBox(height: 16),
            Text(l10n.mapOrWebsite, style: const TextStyle(color: AppColors.teal)),
            _field('', _mapUrl, hint: 'https://...'),
            _field(l10n.workingHours, _hours),
            _field(l10n.avgPrice, _price),
            _field(l10n.bookingOrPhone, _booking),
            _field(l10n.socialAccounts, _social),
            const SizedBox(height: 16),
            Text(
              l10n.activityPhotosSection,
              style: const TextStyle(
                color: AppColors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.activityPhotosHint,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.white80.withValues(alpha: 0.88),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _pickActivityPhoto,
                  icon: const Icon(Icons.add_photo_alternate_outlined, size: 20),
                  label: Text(l10n.activityPhotosAdd),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.teal,
                    side: const BorderSide(color: AppColors.teal),
                  ),
                ),
                ..._photoPaths.asMap().entries.map(
                  (e) => InputChip(
                    label: Text(
                      '${e.key + 1}',
                      style: const TextStyle(color: AppColors.white),
                    ),
                    deleteIconColor: AppColors.rose,
                    onDeleted: () => setState(() => _photoPaths.removeAt(e.key)),
                    backgroundColor: AppColors.darkBlueLight,
                    side: BorderSide(color: AppColors.teal.withValues(alpha: 0.4)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _next,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.teal,
                foregroundColor: AppColors.darkBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(l10n.nextSubscription),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label.isEmpty ? null : label,
      filled: true,
      fillColor: AppColors.darkBlueLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.teal.withValues(alpha: 0.35)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.teal),
      ),
      labelStyle: AppTheme.arabicTextStyle(color: AppColors.white80),
    );
  }

  Widget _field(
    String label,
    TextEditingController c, {
    bool required = false,
    bool email = false,
    bool phone = false,
    int maxLines = 1,
    String? hint,
    bool readOnly = false,
  }) {
    final req = required;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: email
            ? TextInputType.emailAddress
            : phone
                ? TextInputType.phone
                : TextInputType.text,
        style: AppTheme.arabicTextStyle(
          color: readOnly ? AppColors.white80 : AppColors.white,
        ),
        decoration: _decoration(label).copyWith(
          hintText: hint,
          hintStyle: AppTheme.arabicTextStyle(
            color: AppColors.white80.withValues(alpha: 0.5),
          ),
        ),
        validator: req
            ? (v) =>
                (v == null || v.trim().isEmpty) ? context.l10n.fieldRequired : null
            : null,
      ),
    );
  }
}
