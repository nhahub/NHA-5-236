import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class PdfViewerScreen extends StatefulWidget {
  final String url;
  final String title;

  const PdfViewerScreen({super.key, required this.url, required this.title});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.5,
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _isLoading
                ? null
                : () => _pdfViewerController.zoomLevel =
                      (_pdfViewerController.zoomLevel - 0.25).clamp(0.5, 5.0),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _isLoading
                ? null
                : () => _pdfViewerController.zoomLevel =
                      (_pdfViewerController.zoomLevel + 0.25).clamp(0.5, 5.0),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 300.r, vertical: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SfPdfViewer.network(
                widget.url,
                controller: _pdfViewerController,
                enableDoubleTapZooming: true,
                interactionMode: PdfInteractionMode.selection,
                onDocumentLoaded: (details) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                onDocumentLoadFailed: (details) {
                  setState(() {
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${details.description}'),
                      backgroundColor: context.colorScheme.error,
                    ),
                  );
                },
              ),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
