import 'package:flutter/material.dart';

class ImageThumbnailCard extends StatelessWidget {
  final Map<String, String> imageLinks;

  const ImageThumbnailCard({super.key, required this.imageLinks});

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: imageLinks.entries.map((entry) {
            return Column(
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    if (entry.value != 'None') {
                      _showImageDialog(context, entry.value);
                    }
                  },
                  child: entry.value != 'None'
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(entry.value, width: 80, height: 80, fit: BoxFit.cover),
                  )
                      : Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('None', style: TextStyle(color: Colors.black54)),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
