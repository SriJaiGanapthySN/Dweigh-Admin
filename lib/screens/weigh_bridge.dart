import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dweighadmin/services/complaints/complaint_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeighBridgeInfo extends StatefulWidget {
  const WeighBridgeInfo({super.key, required this.name, required this.number});

  final String name;
  final String number;

  @override
  State<WeighBridgeInfo> createState() => _WeighBridgeInfoState();
}

class _WeighBridgeInfoState extends State<WeighBridgeInfo> {
  final ComplaintService _complaintService = ComplaintService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        title: Text(
          "ADMIN PAGE",
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
      stream: _complaintService.getcomplaints(),
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

        List<DocumentSnapshot> matchingComplaints =
            snapshot.data!.docs.where((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          return data != null &&
              data["name"] == widget.name &&
              data["phonenumber"] == widget.number;
        }).toList();

        // If no complaints match
        if (matchingComplaints.isEmpty) {
          return const Center(child: Text('No complaints available.'));
        }

        return ListView.builder(
          itemCount: matchingComplaints.length,
          itemBuilder: (context, index) {
            return _buildServiceItem(matchingComplaints[index], index + 1);
          },
        );
      },
    );
  }

  Widget _buildServiceItem(DocumentSnapshot doc, int complaintNumber) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      return const SizedBox.shrink();
    }
    Timestamp timestamp = data["timestamp"];
    DateTime complaintDate = timestamp.toDate();

    // Format the date to show only the day and date
    String formattedDate =
        DateFormat('EEEE, MMM d, yyyy').format(complaintDate);

    return Container(
      margin: EdgeInsets.only(top: height * 0.03),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the complaint number

            if (complaintNumber == 1)
              Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Customer Name",
                          style: GoogleFonts.inter(
                            fontSize: 21,
                            color: const Color.fromARGB(255, 5, 83, 142),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Text(data["name"],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 5, 83, 142),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Customer Phone Number",
                          style: GoogleFonts.inter(
                            fontSize: 21,
                            color: const Color.fromARGB(255, 5, 83, 142),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Text(data["phonenumber"],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 5, 83, 142),
                            )),
                      ],
                    ),
                  ),
                ],
              ),

            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Complaint - $complaintNumber",
              style: GoogleFonts.aBeeZee(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF034C8D),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),

            // Always show complaint type, brand, and complaint
            Container(
              height: height * 0.1,
              width: width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Complaint Type",
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      color: const Color.fromARGB(255, 5, 83, 142),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(data["type"],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 5, 83, 142),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              height: height * 0.1,
              width: width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Brand",
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      color: const Color.fromARGB(255, 5, 83, 142),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(data["brand"],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 5, 83, 142),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              height: height * 0.16,
              width: width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Complaint",
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      color: const Color.fromARGB(255, 5, 83, 142),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(
                    data["complaint"],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 5, 83, 142),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              height: height * 0.1,
              width: width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Time of Complaint",
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      color: const Color.fromARGB(255, 5, 83, 142),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(formattedDate,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 5, 83, 142),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
