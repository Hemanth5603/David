import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarTab> with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  final TextEditingController _eventController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for subtle animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _eventController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Function to add a new reminder
  void _addReminder() {
    if (_eventController.text.isNotEmpty) {
      setState(() {
        _events[_selectedDate] = _events[_selectedDate] ?? [];
        _events[_selectedDate]?.add(_eventController.text);
        _eventController.clear();
        _animationController.forward(from: 0.0);
      });
    }
  }

  // Function to remove a reminder
  void _removeReminder(String event) {
    setState(() {
      _events[_selectedDate]?.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the primary color shade
    const Color primaryColor = Color(0xFF009688); // Teal shade

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Calendar"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 4,
        titleTextStyle: const TextStyle(
          fontFamily: 'man-sb',
          color: Colors.white,
          fontSize: 15,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for the calendar
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'man-l',
                  ),
                  defaultTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'man-r',
                  ),
                  outsideTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'man-l',
                  ),
                  markerDecoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'man-sb',
                    fontSize: 18,
                  ),
                  formatButtonVisible: false,
                  leftChevronIcon: const Icon(Icons.chevron_left, color: primaryColor),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: primaryColor),
                ),
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Selected Date: ${_selectedDate.toLocal()}".split(' ')[0],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontFamily: 'man-b',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _events[_selectedDate] != null && _events[_selectedDate]!.isNotEmpty
                  ? ListView.builder(
                      itemCount: _events[_selectedDate]!.length,
                      itemBuilder: (context, index) {
                        final event = _events[_selectedDate]![index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.event_note, color: primaryColor),
                            title: Text(
                              event,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontFamily: 'man-r',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _removeReminder(event),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No reminders",
                        style: TextStyle(color: Colors.grey, fontFamily: 'man-l', fontSize: 16),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Show a dialog to add a new reminder
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Add Reminder",
                style: TextStyle(fontFamily: 'man-sb'),
              ),
              content: TextField(
                controller: _eventController,
                style: const TextStyle(fontFamily: 'man-r'),
                decoration: const InputDecoration(
                  hintText: "Enter your reminder...",
                  hintStyle: TextStyle(fontFamily: 'man-l', color: Colors.grey),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addReminder();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: primaryColor, fontFamily: 'man-sb'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _eventController.clear();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.redAccent, fontFamily: 'man-sb'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
