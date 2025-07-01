import 'package:flutter/material.dart';

class WasteServicePage extends StatefulWidget {
  const WasteServicePage({super.key});

  @override
  State<WasteServicePage> createState() => _WasteServicePageState();
}

class _WasteServicePageState extends State<WasteServicePage> {
  bool isPickup = true;

  // Dummy selected date
  DateTime selectedDate = DateTime.now();

  // Waste fields
  String selectedCategory = "Plastic Bottle";
  int wasteQuantity = 1;

  // Dummy location
  String userLocation = "Green Haven, 42B, Meadowview";

  // Notes controller
  final TextEditingController _notesController = TextEditingController();

  void _incrementQuantity() => setState(() => wasteQuantity++);
  void _decrementQuantity() {
    if (wasteQuantity > 0) setState(() => wasteQuantity--);
  }

  void _selectService(bool pickup) {
    setState(() {
      isPickup = pickup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildServiceSelector(),
              const Divider(height: 30),
              _buildWasteDetails(),
              const Divider(height: 30),
              isPickup ? _buildPickupDetails() : _buildDropoffDetails(),
              const Divider(height: 30),
              _buildAdditionalNotes(),
              const Divider(height: 30),
              _buildWasteSummary(),
              const SizedBox(height: 20),
              _buildBottomSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.close),
        TextButton(
          onPressed: () {
            // Clear logic
          },
          child: const Text("Clear data"),
        )
      ],
    );
  }

  Widget _buildServiceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text("Please select a type of service"),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPickup ? const Color(0xFF4B5320) : Colors.grey[300],
                  foregroundColor: isPickup ? Colors.white : Colors.black,
                ),
                onPressed: () => _selectService(true),
                child: const Text("Pick up"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isPickup ? const Color(0xFF4B5320) : Colors.grey[300],
                  foregroundColor: !isPickup ? Colors.white : Colors.black,
                ),
                onPressed: () => _selectService(false),
                child: const Text("Drop off"),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildWasteDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Waste Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text(
            "Input details of your waste—select a category and indicate the quantity or the amount of bags."),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ["Plastic Bottle", "Can", "Glass"]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val!),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 60,
              child: TextFormField(
                initialValue: wasteQuantity.toString(),
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            IconButton(onPressed: _decrementQuantity, icon: const Icon(Icons.remove)),
            IconButton(onPressed: _incrementQuantity, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }

  Widget _buildPickupDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pick up Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildCalendarSection(),
        const SizedBox(height: 15),
        const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8),
              Expanded(child: Text(userLocation)),
              TextButton(onPressed: () {}, child: const Text("edit")),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pick up Fee", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Cost"),
          ],
        ),
        const SizedBox(height: 5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Php 50.00 / bag"),
            Text("50.00"),
          ],
        ),
      ],
    );
  }

  Widget _buildDropoffDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Drop Off Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildCalendarSection(),
      ],
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 200,
          color: Colors.grey[100],
          alignment: Alignment.center,
          child: Text("Calendar UI Placeholder\nSelected: ${selectedDate.toLocal()}".split(' ')[0]),
        ),
      ],
    );
  }

  Widget _buildAdditionalNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Additional Notes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text("Leave any additional instructions or preferences."),
        const SizedBox(height: 8),
        TextFormField(
          controller: _notesController,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: "ex. Bags are found at the front of the yard.",
            filled: true,
            fillColor: Color(0xFFF0F0F0),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildWasteSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Waste Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text(
            "Below is a summary of your entered waste information. You can update or edit it above."),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedCategory),
            Text(wasteQuantity.toString()),
          ],
        ),
        if (isPickup)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Address: $userLocation\nPick Up Date: Wed, 25 Jun 2025 at 12:00 P.M."),
          ),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isPickup) ...[
          const Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Php 50.00 (per bag)"),
          const SizedBox(height: 8),
        ],
        ElevatedButton(
          onPressed: () {
            // Future backend logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4B5320),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
              "Schedule",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
