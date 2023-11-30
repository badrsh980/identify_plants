import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:identify_plants/model/plant.dart'; // Import your model
import 'package:url_launcher/url_launcher.dart';

class PlantDetailPage extends StatefulWidget {
  final PlantIdentificationResponse response; // Variable to hold the response

  const PlantDetailPage({Key? key, required this.response}) : super(key: key);

  @override
  _PlantDetailPageState createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Extracting data from the response
    final suggestion =
        widget.response.result?.classification?.suggestions?.first;

    final imageUrl =
        suggestion?.details?.image?.value ?? 'assets/fallback_image.png';
    final plantName = suggestion?.name ?? 'Unknown Plant';
    final description =
        suggestion?.details?.description?.value ?? 'No description available';
    final wikipediaUrl = suggestion?.details?.url ?? 'No URL available';

    final taxonomy = suggestion?.details?.taxonomy != null
        ? 'Class: ${suggestion!.details!.taxonomy!.plantClass}\n'
            'Genus: ${suggestion.details?.taxonomy!.genus}\n'
            'Order: ${suggestion.details?.taxonomy!.order}\n'
            'Family: ${suggestion.details?.taxonomy!.family}\n'
            'Phylum: ${suggestion.details?.taxonomy!.phylum}\n'
            'Kingdom: ${suggestion.details?.taxonomy!.kingdom}'
        : 'Taxonomy information not available';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 26),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 103, 134, 74),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.arrow_back, color: Colors.white)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: SizedBox(
              width: 400,
              height: 400,
              child: Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/fallback_image.png');
                },
                fit: BoxFit.cover,
              ),
            )),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                plantName, // Display the plant's name
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                description, // Display the plant's description
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Taxonomy:\n$taxonomy',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: "To learn more form",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  text: " Wikipedia Click here ",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      var url = wikipediaUrl;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
            ])),
            const SizedBox(height: 250),
          ],
        ),
      ),
      bottomSheet: bottomSheetContent(),
    );
  }

  Widget bottomSheetContent() {
    // Example bottom sheet content
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 103, 134, 74),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        // Changed from Wrap to Row
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          attributeColumn(Icons.height, "60 - 80 cm", "Height"),
          attributeColumn(Icons.thermostat, "18° - 25°", "Temperature"),
          attributeColumn(Icons.local_florist, "Ceramic", "Pot"),
        ],
      ),
    );
  }

  Widget attributeColumn(IconData icon, String text, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 20),
      ],
    );
  }
}
