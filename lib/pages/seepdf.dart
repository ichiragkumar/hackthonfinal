

import 'package:flutter/material.dart';

class PDFView extends StatelessWidget {
  final String filePath;

  const PDFView({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume'),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
