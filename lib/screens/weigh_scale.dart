import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dweighadmin/screens/weigh_scaleinfo.dart';
import 'package:dweighadmin/services/complaints/complaint_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeighScale extends StatefulWidget {
  const WeighScale({super.key});

  @override
  State<WeighScale> createState() => _WeighScaleState();
}

class _WeighScaleState extends State<WeighScale> {
  final ComplaintService _complaintService = ComplaintService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        title: Text(
          "Service-log",
          style: GoogleFonts.emblemaOne(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF034C8D),
          ),
          maxLines: 2,
        ),
        backgroundColor: const Color(0xFFAAD7E2),
      ),
      backgroundColor: const Color(0xFFD0F8F5),
      body: serviceUserList(),
    );
  }

  Widget serviceUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _complaintService.getcomplaints1(),
      builder: (context, snapshot) {
        // Handle errors
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        // Show a loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if the snapshot has data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No complaints available.'));
        }

        // If data exists, build the list
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildServiceItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildServiceItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeighScaleinfo(
                          name: data["name"],
                          number: data["phonenumber"],
                        )));
          },
          child: ListTile(
            leading: const Icon(
              Icons.person,
              color: Color(0xFF034C8D),
            ),
            title: Text(
              data["name"] ?? "No name",
              style: GoogleFonts.aclonica(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF034C8D),
              ),
            ),
            subtitle: Text(
              data["brand"] ?? "No brand",
              style: GoogleFonts.aclonica(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF034C8D),
              ),
            ),
            trailing: Text(
              data["phonenumber"] ?? "No brand",
              style: GoogleFonts.aclonica(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF034C8D),
              ),
            ),
          ),
        ),
        const Divider(), // Add a divider for clarity
      ],
    );
  }
}
