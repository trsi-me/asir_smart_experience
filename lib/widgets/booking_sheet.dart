import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/my_bookings_screen.dart';

/// شيت الحجز - اختيار السكن والمواصلات ثم تأكيد الحجز
void showBookingSheet(BuildContext context, String experienceName) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _BookingSheetContent(experienceName: experienceName),
  );
}

class _BookingSheetContent extends StatefulWidget {
  final String experienceName;

  const _BookingSheetContent({required this.experienceName});

  @override
  State<_BookingSheetContent> createState() => _BookingSheetContentState();
}

class _BookingSheetContentState extends State<_BookingSheetContent> {
  int? _selectedAccommodationIndex;
  int? _selectedTransportIndex;
  bool _isSubmitting = false;

  void _confirmBooking() async {
    if (_selectedAccommodationIndex == null || _selectedTransportIndex == null) return;
    final l10n = context.l10n;
    final data = context.localizedData;
    final acc = data.accommodationTypes[_selectedAccommodationIndex!];
    final trans = data.transportOptions[_selectedTransportIndex!];
    final accName = acc['name'] as String;
    final transName = trans['name'] as String;

    setState(() => _isSubmitting = true);
    HapticFeedback.lightImpact();

    await DatabaseHelper.instance.addBooking(
      AuthService().currentUserId,
      widget.experienceName,
      accName,
      transName,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.bookingSuccess),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyBookingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${l10n.booking}: ${widget.experienceName}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.bookingHint,
                style: const TextStyle(fontSize: 14, color: AppColors.white80),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(l10n.suggestedAccommodation, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.teal)),
                    const SizedBox(height: 8),
                    ...List.generate(data.accommodationTypes.length, (i) {
                      final a = data.accommodationTypes[i];
                      final isSelected = _selectedAccommodationIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedAccommodationIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.teal.withValues(alpha: 0.2) : AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.teal : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.check_circle : Icons.circle_outlined,
                                color: isSelected ? AppColors.teal : AppColors.white80,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(a['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white)),
                                    Text('${a['count']} ${l10n.optionsCount}', style: const TextStyle(fontSize: 14, color: AppColors.teal)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Text(l10n.transport, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.teal)),
                    const SizedBox(height: 8),
                    ...List.generate(data.transportOptions.length, (i) {
                      final t = data.transportOptions[i];
                      final isSelected = _selectedTransportIndex == i;
                      final icons = [Icons.directions_car, Icons.tour, Icons.route];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedTransportIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.teal.withValues(alpha: 0.2) : AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.teal : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.check_circle : Icons.circle_outlined,
                                color: isSelected ? AppColors.teal : AppColors.white80,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Icon(icons[i], color: AppColors.teal, size: 28),
                              const SizedBox(width: 16),
                              Expanded(child: Text(t['name'] as String, style: const TextStyle(fontSize: 16, color: AppColors.white))),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: (_selectedAccommodationIndex != null && _selectedTransportIndex != null && !_isSubmitting)
                      ? _confirmBooking
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    disabledBackgroundColor: AppColors.teal.withValues(alpha: 0.3),
                    foregroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkBlue),
                        )
                      : Text(l10n.confirmBooking, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
