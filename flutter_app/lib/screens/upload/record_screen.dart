import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/style_filter_provider.dart';
import '../../widgets/style_toggle_carousel.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.watch<StyleFilterProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Center(child: Icon(Icons.camera_alt_outlined, color: Colors.white24, size: 80)),
          Positioned(
            top: 40, left: 16,
            child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: () => Navigator.pop(context)),
          ),
          Positioned(
            bottom: 120, left: 0, right: 0,
            child: StyleToggleCarousel(
              styles: filterProvider.availableStyles,
              activeStyleName: filterProvider.selectedStyle?.name,
              onStyleSelected: (style) => filterProvider.selectStyle(style),
            ),
          ),
          Positioned(
            bottom: 30, left: 0, right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => _isRecording = !_isRecording),
                child: Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4)),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isRecording ? 30 : 60, height: _isRecording ? 30 : 60,
                      decoration: BoxDecoration(color: const Color(0xFFFF2D55), borderRadius: BorderRadius.circular(_isRecording ? 4 : 30)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
