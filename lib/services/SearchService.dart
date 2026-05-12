List<String> smartSearch(List<String> items, String query) {
  query = query.toLowerCase().trim();

  final results = <Map<String, dynamic>>[];

  for (final item in items) {
    final lower = item.toLowerCase();

    int score = 0;

    // Exact start of sentence
    if (lower.startsWith(query)) {
      score += 1000;
    }

    final words = lower.split(RegExp(r'\s+'));

    // Word starts with query
    for (final word in words) {
      if (word.startsWith(query)) {
        score += 200;
      }
    }

    // Contains query
    if (lower.contains(query)) {
      score += 50;
    }

    // Earlier appearance = better
    final index = lower.indexOf(query);

    if (index != -1) {
      score += (100 - index);
    }

    // Fewer words preferred
    score -= words.length * 5;

    // Shorter strings slightly preferred
    score -= lower.length ~/ 10;

    if (score > 0) {
      results.add({'item': item, 'score': score});
    }
  }

  results.sort((a, b) => b['score'].compareTo(a['score']));

  return results.map((e) => e['item'] as String).toList();
}
