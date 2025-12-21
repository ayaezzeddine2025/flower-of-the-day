import 'package:flutter/material.dart';
import 'flower_data.dart';
import 'home.dart';
import 'single_flower_page.dart';

class FlowerDetailsPage extends StatefulWidget {
  const FlowerDetailsPage({super.key});

  @override
  State<FlowerDetailsPage> createState() => _FlowerDetailsPageState();
}

class _FlowerDetailsPageState extends State<FlowerDetailsPage> {
  String? selectedColor;

  void _onMenuSelected(BuildContext context, String value) {
    if (value == 'home') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get unique colors
    List<String> colors = flowers.map((f) => f.color).toSet().toList();

    // Filter flowers by selected color
    List<Flower> filteredFlowers = selectedColor == null
        ? []
        : flowers.where((f) => f.color == selectedColor).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flower Details'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text('Choose a color'),
              value: selectedColor,
              isExpanded: true,
              items: colors.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor = value;
                });
              },
            ),

            const SizedBox(height: 20),

            if (selectedColor != null) ...[
              const Text(
                "Flowers with this color:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredFlowers.length,
                  itemBuilder: (context, index) {
                    final flower = filteredFlowers[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: Image.asset(
                          flower.imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(flower.name),
                        subtitle: Text(flower.color),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SingleFlowerPage(flower: flower),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
