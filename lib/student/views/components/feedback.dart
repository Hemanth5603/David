import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  final String lectureTitle;

  FeedbackPage({required this.lectureTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback for $lectureTitle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rate the Lecture:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildStarRating(),
            const SizedBox(height: 20),
            Text(
              "Do you have any doubts?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Mention your doubts here...",
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            Text(
              "Any specific requests?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Mention your requests here...",
              ),
              maxLines: 4,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                Navigator.pop(context);
              },
              child: Text("Submit Feedback"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    int _selectedRating = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _selectedRating ? Icons.star : Icons.star_border,
              ),
              color: Colors.amber,
              onPressed: () {
                setState(() {
                  _selectedRating = index + 1;
                });
              },
            );
          }),
        );
      },
    );
  }
}
