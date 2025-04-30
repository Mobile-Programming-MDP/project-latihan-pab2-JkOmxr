import 'dart:convert';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.imageBase64,
    required this.description,
    required this.createdAt,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.heroTag,
  });

  final String imageBase64;
  final String description;
  final DateTime createdAt;
  final String fullName;
  final double latitude;
  final double longitude;
  final String category;
  final String heroTag;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<void> openMap() async {
    final uri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}");
    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!mounted) return;
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak bisa membuka Google Map")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final createdAtFormatted =
        DateFormat('dd MM yyyy, HH:mm').format(widget.createdAt);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Laporan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(tag: widget.heroTag,
                 child: Image.memory(base64Decode(widget.imageBase64),
                 width: double.infinity,
                 height: 250,
                 fit: BoxFit.cover,
                 ),
                 ),
                 Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  onPressed: () (),
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  ),
                  tooltip: 'Lihat Gambar Penuh',
                  style: IconButton.styleFrom(backgroundColor: Colors.black),
                ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
