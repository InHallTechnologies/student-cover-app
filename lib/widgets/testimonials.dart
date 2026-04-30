import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  bool _isLoading = true;
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  List<Map<Object?, Object?>> reviewsList = [];
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final reviews = await _firebaseDatabase.ref("/REVIEWS").once(DatabaseEventType.value);
    List<Map<Object?, Object?>> list = [];
    for (final i in reviews.snapshot.children) {
      list.add(i.value as Map<Object?, Object?>);
    }

    setState(() {
      _isLoading = false;
      reviewsList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text("What our students say?", style: kHeadlineStyle.copyWith(color: kPrimaryDark)),
          // const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: expandedIndex != null ? 360 : 240,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: reviewsList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<Object?, Object?> currentItem = reviewsList[index];
                      String reviewText = currentItem['review']?.toString() ?? "";
                      bool isLongText = reviewText.length > 100;
                      bool isExpanded = expandedIndex == index;

                      return Container(
                        width: 340,
                        margin: const EdgeInsets.only(right: 24, bottom: 8, top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                          border: Border.all(color: border),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(currentItem['image'].toString()),
                                  backgroundColor: kPrimaryLight.withOpacity(0.2),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentItem['name']?.toString() ?? "Rishabh Verma",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textPrimary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber, size: 16),
                                          const Icon(Icons.star, color: Colors.amber, size: 16),
                                          const Icon(Icons.star, color: Colors.amber, size: 16),
                                          const Icon(Icons.star, color: Colors.amber, size: 16),
                                          const Icon(Icons.star, color: Colors.amber, size: 16),
                                          const SizedBox(width: 6),
                                          const Text("Google Review", style: TextStyle(fontSize: 12, color: textSecondary)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.format_quote_rounded, color: kPrimaryLight.withOpacity(0.2), size: 40),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: isExpanded ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviewText,
                                      style: TextStyle(color: textPrimary.withOpacity(0.8), height: 1.5, fontSize: 14),
                                      maxLines: isExpanded ? null : 3,
                                      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                    ),
                                    if (isLongText)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              expandedIndex = isExpanded ? null : index;
                                            });
                                          },
                                          child: Text(
                                            isExpanded ? "Show less" : "Show more",
                                            style: const TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
