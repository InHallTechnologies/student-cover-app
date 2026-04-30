import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class TopUniversities extends StatefulWidget {
  const TopUniversities({super.key});

  @override
  State<TopUniversities> createState() => _TopUniversitiesState();
}

class _TopUniversitiesState extends State<TopUniversities> {
  bool _isLoading = true;
  List<Map<Object?, Object?>> _data = [];
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    updateUi();
  }

  void updateUi() async {
    final dataSnapshot = await _firebaseDatabase.ref("/TOP_UNIVERSITIES").limitToFirst(20).once(DatabaseEventType.value);
    List<Map<Object?, Object?>> universities = [];
    for (final item in dataSnapshot.snapshot.children) {
      universities.add(item.value as Map<Object?, Object?>);
    }
    setState(() {
      _data = universities;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Top Universities", style: kHeadlineStyle.copyWith(color: kPrimaryDark)),
          const SizedBox(height: 16),
          _isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(color: kPrimaryLight),
                  ),
                )
              : SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      Map<Object?, Object?> item = _data[index];
                      return Container(
                        width: 320,
                        margin: const EdgeInsets.only(right: 20, bottom: 8, top: 4),
                        padding: const EdgeInsets.all(20),
                        decoration: kDefaultCardDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: border),
                                    image: DecorationImage(image: NetworkImage(item['collegeLogo'].toString()), fit: BoxFit.contain),
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['collegeName'].toString(),
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textPrimary),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on, color: textSecondary, size: 14),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "${item['city']}, ${item['country']}",
                                              style: const TextStyle(fontSize: 13, color: textSecondary, fontWeight: FontWeight.w500),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: Text(
                                item["collegeBrief"].toString(),
                                style: TextStyle(color: textPrimary.withOpacity(0.8), fontSize: 14, height: 1.5),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Know More",
                                  style: TextStyle(color: kPrimaryLight, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const Icon(Icons.arrow_forward_rounded, color: kPrimaryLight, size: 18),
                              ],
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
