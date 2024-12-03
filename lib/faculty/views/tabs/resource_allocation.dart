import 'package:flutter/material.dart';

class ResourceAllocationPage extends StatefulWidget {
  @override
  _ResourceAllocationPageState createState() => _ResourceAllocationPageState();
}

class _ResourceAllocationPageState extends State<ResourceAllocationPage> {
  String? selectedResource;
  String? selectedTimeSlot;
  String? sectionName;
  final List<String> resources = ['Projector', 'Lab 1', 'Lab 2', 'Conference Room'];
  final List<String> timeSlots = [
    '9:30 - 10:30',
    '10:30 - 11:30',
    '11:30 - 12:00',
    '1:00 - 2:00',
    '2:00 - 3:00',
    '3:00 - 4:00',
  ];

  final Map<String, Map<String, String>> resourceAllocation = {}; // Tracks allocations

  void allocateResource() {
    if (selectedResource != null && selectedTimeSlot != null && sectionName != null && sectionName!.isNotEmpty) {
      final allocationKey = '$selectedResource - $selectedTimeSlot';

      if (resourceAllocation.containsKey(allocationKey)) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Conflict',
              style: TextStyle(fontFamily: 'man-b'),
            ),
            content: Text(
              'The resource "$selectedResource" is already allocated for the time slot "$selectedTimeSlot" to Section: ${resourceAllocation[allocationKey]!['section']}',
              style: TextStyle(fontFamily: 'man-r'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(fontFamily: 'man-sb'),
                ),
              ),
            ],
          ),
        );
        return;
      }

      setState(() {
        resourceAllocation[allocationKey] = {'section': sectionName!};
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Resource allocated successfully to Section: $sectionName',
          style: TextStyle(fontFamily: 'man-r'),
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please fill all fields before allocation.',
          style: TextStyle(fontFamily: 'man-r'),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 47, 61),
      appBar: AppBar(
        title: Text(
          'Resource Allocation',
          style: TextStyle(fontFamily: 'man-sb', color: const Color.fromARGB(255, 253, 253, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 45, 47, 61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Resource',
              style: TextStyle(
                fontFamily: 'man-sb',
                fontSize: 16,
                color: const Color.fromARGB(255, 233, 228, 228),
              ),
            ),
            DropdownButton<String>(
              value: selectedResource,
              isExpanded: true,
              dropdownColor: Colors.grey[800],
              style: TextStyle(fontFamily: 'man-r', color: Colors.white),
              hint: Text(
                'Choose a resource',
                style: TextStyle(fontFamily: 'man-r', color: const Color.fromARGB(255, 165, 161, 161)),
              ),
              items: resources
                  .map((resource) => DropdownMenuItem(
                        value: resource,
                        child: Text(resource),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedResource = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Select Time Slot',
              style: TextStyle(
                fontFamily: 'man-sb',
                fontSize: 16,
                color: const Color.fromARGB(255, 235, 230, 230),
              ),
            ),
            DropdownButton<String>(
              value: selectedTimeSlot,
              isExpanded: true,
              dropdownColor: Colors.grey[800],
              style: TextStyle(fontFamily: 'man-r', color: Colors.white),
              hint: Text(
                'Choose a time slot',
                style: TextStyle(fontFamily: 'man-r', color: const Color.fromARGB(255, 189, 186, 186)),
              ),
              items: timeSlots
                  .map((slot) => DropdownMenuItem(
                        value: slot,
                        child: Text(slot),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTimeSlot = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Enter Branch Name',
              style: TextStyle(
                fontFamily: 'man-sb',
                fontSize: 16,
                color: const Color.fromARGB(255, 233, 228, 228),
              ),
            ),
            TextField(
              onChanged: (value) {
                sectionName = value;
              },
              style: TextStyle(fontFamily: 'man-r', color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type branch name',
                hintStyle: TextStyle(fontFamily: 'man-r', color: const Color.fromARGB(255, 229, 228, 228)),
                filled: true,
                fillColor: const Color.fromARGB(255, 56, 56, 66),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: allocateResource,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 150, 2),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Allocate Resource',
                  style: TextStyle(fontFamily: 'man-b', fontSize: 16, color: const Color.fromARGB(199, 254, 250, 255)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
