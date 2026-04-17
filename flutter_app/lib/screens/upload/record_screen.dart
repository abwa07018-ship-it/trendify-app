import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/style_filter_provider.dart';
import '../../utils/trendify_theme.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.watch<StyleFilterProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Record', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam, size: 64, color: Colors.white24),
                    SizedBox(height: 16),
                    Text('Camera Preview',
                        style: TextStyle(color: Colors.white38, fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Beta — Camera integration coming soon',
                        style: TextStyle(color: Colors.white24, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterProvider.filters.length,
              itemBuilder: (context, index) {
                final filter = filterProvider.filters[index];
                final isSelected = filterProvider.selectedFilter?.id == filter.id;
                return GestureDetector(
                  onTap: () => filterProvider.selectFilter(filter),
                  child: Container(
                    width: 64,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: Colors.pinkAccent, width: 2)
                          : null,
                      color: Colors.grey[850],
                    ),
                    child: Center(
                      child: Text(
                        filter.displayName,
                        style: TextStyle(
                          color: isSelected ? Colors.pinkAccent : Colors.white54,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: TrendifyBrand.logoGradient,
            ),
            child: const Icon(Icons.fiber_manual_record, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
