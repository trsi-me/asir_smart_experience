import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/widgets/booking_sheet.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/l10n/data_translations.dart';

/// شاشة تفاصيل الموقع - أقسام واضحة + ختم + خريطة + تعليقات
class PlaceDetailScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final List<Map<String, dynamic>> _comments = [];
  final List<String> _userPhotos = [];
  bool _hasStamp = false;
  bool _checkingStamp = false;

  @override
  void initState() {
    super.initState();
    _checkExistingStamp();
    _loadUserPhotos();
  }

  Future<void> _loadUserPhotos() async {
    final placeId = widget.place['id'] as String?;
    if (placeId == null) return;
    final photos = await DatabaseHelper.instance.getUserPhotosForPlace(
      AuthService().currentUserId,
      placeId,
    );
    if (mounted) {
      setState(() {
        _userPhotos.clear();
        for (final p in photos) {
          final fp = p['file_path'] as String?;
          if (fp != null && fp.isNotEmpty) _userPhotos.add(fp);
        }
      });
    }
  }

  Future<void> _checkExistingStamp() async {
    final placeId = widget.place['id'] as String?;
    if (placeId == null) return;
    final has = await DatabaseHelper.instance.hasStampForPlace(AuthService().currentUserId, placeId);
    if (mounted) setState(() => _hasStamp = has);
  }

  Future<void> _registerVisit() async {
    final placeId = widget.place['id'] as String?;
    if (placeId == null) return;
    if (_checkingStamp || _hasStamp) return;
    setState(() => _checkingStamp = true);
    final uid = AuthService().currentUserId;
    final placeName = widget.place['name'] as String? ?? '';
    final cat = _getCategory(placeId);
    final added = await DatabaseHelper.instance.addStamp(uid, placeId, placeName, cat);
    if (mounted) {
      setState(() {
        _checkingStamp = false;
        _hasStamp = added || _hasStamp;
      });
      if (added) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.visitRecordedSuccess), backgroundColor: AppColors.green),
        );
      }
    }
  }

  String _getCategory(String id) {
    final p = widget.place;
    final cat = p['category'] ?? p['classification'] ?? 'زيارة';
    return cat is String ? cat : 'زيارة';
  }

  String _getDescription(String id, Map<String, dynamic> place, DataTranslations dataT) {
    final fromT = dataT.placeDescription(id);
    if (fromT.isNotEmpty) return fromT;
    return dataT.isArabic ? (place['description']?.toString() ?? '') : '';
  }

  String _getImportance(String id, Map<String, dynamic> place, DataTranslations dataT) {
    final fromT = dataT.placeImportance(id);
    if (fromT.isNotEmpty) return fromT;
    return dataT.isArabic ? (place['importance']?.toString() ?? '') : '';
  }

  List<String> _getActivities(String id, Map<String, dynamic> place, DataTranslations dataT) {
    final fromT = dataT.placeActivities(id);
    if (fromT.isNotEmpty) return fromT;
    if (!dataT.isArabic) return [];
    final a = place['activities'];
    return a != null ? (a as List).cast<String>() : [];
  }

  List<String> _getTips(String id, Map<String, dynamic> place, DataTranslations dataT) {
    final fromT = dataT.placeTips(id);
    if (fromT.isNotEmpty) return fromT;
    if (!dataT.isArabic) return [];
    final t = place['tips'];
    return t != null ? (t as List).cast<String>() : [];
  }

  Future<void> _openMaps() async {
    final lat = widget.place['lat'] as num? ?? 18.2164;
    final lng = widget.place['lng'] as num? ?? 42.5053;
    final url = Uri.parse('https://www.google.com/maps?q=$lat,$lng');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _showAddComment() {
    final c = TextEditingController();
    final l10n = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBlueLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: c,
              decoration: InputDecoration(hintText: l10n.writeComment),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (c.text.trim().isNotEmpty) {
                    setState(() => _comments.add({'text': c.text.trim(), 'rating': 4}));
                    Navigator.pop(ctx);
                  }
                },
                child: Text(l10n.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddPhoto() async {
    final placeId = widget.place['id'] as String?;
    if (placeId == null) return;
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.darkBlueLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.teal),
                title: Text(context.l10n.pickFromGallery, style: const TextStyle(color: AppColors.white)),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.teal),
                title: Text(context.l10n.takePhoto, style: const TextStyle(color: AppColors.white)),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null || !mounted) return;
    try {
      final xFile = await picker.pickImage(source: source, maxWidth: 1200, imageQuality: 85);
      if (xFile == null || !mounted) return;
      final appDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory(path.join(appDir.path, 'place_photos'));
      if (!await photosDir.exists()) await photosDir.create(recursive: true);
      final name = xFile.name;
      final ext = (name.isNotEmpty && path.extension(name).isNotEmpty) ? path.extension(name) : '.jpg';
      final fileName = '${placeId}_${DateTime.now().millisecondsSinceEpoch}$ext';
      final destPath = path.join(photosDir.path, fileName);
      final bytes = await xFile.readAsBytes();
      await File(destPath).writeAsBytes(bytes);
      await DatabaseHelper.instance.addUserPhoto(AuthService().currentUserId, placeId, destPath);
      if (mounted) {
        setState(() => _userPhotos.insert(0, destPath));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.photoAdded), backgroundColor: AppColors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.photoAddFailed), backgroundColor: AppColors.rose),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final l10n = context.l10n;
    final dataT = context.dataT;
    final placeId = place['id'] as String? ?? '';
    var placeName = dataT.placeName(placeId);
    if (placeName == placeId && placeId.isNotEmpty) placeName = place['name'] as String? ?? '';
    var placeSubtitle = dataT.placeSubtitle(placeId);
    if (placeSubtitle.isEmpty) placeSubtitle = place['subtitle'] as String? ?? '';
    final images = (place['images'] as List<dynamic>?)?.cast<String>() ?? [];
    final mainImage = images.isNotEmpty ? images.first : null;

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.darkBlue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: mainImage != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          proxiedImageUrl(mainImage),
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, p) =>
                              p == null ? child : Container(color: AppColors.surface, child: const Center(child: CircularProgressIndicator(color: AppColors.teal))),
                          errorBuilder: (_, __, ___) => Container(color: AppColors.surface, child: const Icon(Icons.landscape, size: 80, color: AppColors.teal)),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.9)]),
                          ),
                        ),
                      ],
                    )
                  : Container(color: AppColors.surface),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeName,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.white),
                  ),
                  if (placeSubtitle.isNotEmpty || place['subtitle'] != null) ...[
                    const SizedBox(height: 6),
                    Text(placeSubtitle.isNotEmpty ? placeSubtitle : (place['subtitle'] as String? ?? ''), style: TextStyle(fontSize: 15, color: AppColors.teal)),
                  ],
                  if (place['classification'] != null) ...[
                    const SizedBox(height: 12),
                    _buildChip(place['classification'] as String),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _openMaps,
                          icon: const Icon(Icons.map, size: 20),
                          label: Text(l10n.openInMaps),
                          style: FilledButton.styleFrom(backgroundColor: AppColors.teal, foregroundColor: AppColors.darkBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => showBookingSheet(context, '${place['name']}'),
                          icon: const Icon(Icons.book_online, size: 20),
                          label: Text(l10n.bookExperience),
                          style: OutlinedButton.styleFrom(foregroundColor: AppColors.teal, side: const BorderSide(color: AppColors.teal)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: (_hasStamp || _checkingStamp) ? null : _registerVisit,
                      icon: _checkingStamp
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkBlue))
                          : Icon(_hasStamp ? Icons.check_circle : Icons.badge, size: 20),
                      label: Text(_hasStamp ? l10n.visitRegistered : l10n.registerVisit),
                      style: FilledButton.styleFrom(
                        backgroundColor: _hasStamp ? AppColors.green : AppColors.teal,
                        foregroundColor: AppColors.darkBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (images.length > 1) ...[
                    _buildImageGallery(images),
                    const SizedBox(height: 24),
                  ],
                  _buildSection(l10n.descriptionHistory, _getDescription(placeId, place, dataT), short: true),
                  _buildSection(l10n.whyImportant, _getImportance(placeId, place, dataT), short: true),
                  _buildListSection(l10n.activities, _getActivities(placeId, place, dataT)),
                  _buildListSection(l10n.tips, _getTips(placeId, place, dataT)),
                  const SizedBox(height: 20),
                  _buildCommentsSection(context),
                  const SizedBox(height: 20),
                  _buildPhotosSection(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.5)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.teal)),
    );
  }

  Widget _buildImageGallery(List<String> images) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 140,
            child: Image.network(
              proxiedImageUrl(images[i]),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.surface, child: const Icon(Icons.image, color: AppColors.teal)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, {bool short = false}) {
    if (content.isEmpty) return const SizedBox();
    final text = short && content.length > 150 ? '${content.substring(0, 150)}...' : content;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal)),
          const SizedBox(height: 8),
          Text(text, style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.white80)),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal)),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 15, color: AppColors.teal)),
                    Expanded(child: Text(item, style: TextStyle(fontSize: 15, height: 1.5, color: AppColors.white80))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(BuildContext context) {
    final l10n = context.l10n;
    final sampleComments = [
      {'text': l10n.isArabic ? 'مكان رائع، أنصح بزيارته' : 'Great place, highly recommend', 'rating': 5, 'user': l10n.guest},
      {'text': l10n.isArabic ? 'تجربة مميزة مع العائلة' : 'Amazing experience with family', 'rating': 4, 'user': 'Tourist'},
      ..._comments,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.visitorComments, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal)),
            TextButton.icon(
              onPressed: _showAddComment,
              icon: const Icon(Icons.add, size: 18),
              label: Text(l10n.addComment),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...sampleComments.map((c) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.darkBlueLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.teal.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(c['user'] as String, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.teal)),
                      const SizedBox(width: 8),
                      ...List.generate(5, (i) => Icon(Icons.star, size: 14, color: i < (c['rating'] as int) ? AppColors.amber : AppColors.white80.withValues(alpha: 0.3))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(c['text'] as String, style: TextStyle(fontSize: 14, color: AppColors.white80)),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildPhotosSection(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.visitorPhotos, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal)),
            TextButton.icon(
              onPressed: _showAddPhoto,
              icon: const Icon(Icons.add_photo_alternate, size: 18),
              label: Text(l10n.addPhoto),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: _showAddPhoto,
                child: Container(
                  width: 80,
                  margin: const EdgeInsetsDirectional.only(start: 8),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlueLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.teal.withValues(alpha: 0.4), style: BorderStyle.solid),
                  ),
                  child: const Icon(Icons.add_a_photo, color: AppColors.teal, size: 32),
                ),
              ),
              ..._userPhotos.map((filePath) {
                final file = File(filePath);
                return Container(
                  width: 80,
                  margin: const EdgeInsetsDirectional.only(start: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: file.existsSync()
                        ? Image.file(file, fit: BoxFit.cover)
                        : Container(
                            color: AppColors.darkBlueLight,
                            child: const Icon(Icons.broken_image, color: AppColors.teal),
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
