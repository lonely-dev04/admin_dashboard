import 'package:approval/drawer.dart';
import 'package:approval/styles.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'data.dart';

class AdminVerificationPage extends StatefulWidget {
  final String title;
  const AdminVerificationPage({super.key, required this.title});
  @override
  _AdminVerificationPageState createState() => _AdminVerificationPageState();
}

class _AdminVerificationPageState extends State<AdminVerificationPage> {
  int currentPage = 0;
  final int itemsPerPage = 6;

  List<Map<String, dynamic>> getPaginatedData() {
    final data = widget.title == "Student" ? studentData : staffData;
    final pendingData = data.where((element) => element["status"] == "Pending").toList();

    // Calculate start and end indices for pagination
    final start = currentPage * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, pendingData.length);

    return pendingData.sublist(start, end);
  }

  int getTotalPages() {
    final data = widget.title == "Student" ? studentData : staffData;
    final pendingDataCount = data.where((element) => element["status"] == "Pending").length;
    return (pendingDataCount / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final paginatedData = getPaginatedData();
    final totalPages = getTotalPages();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.title} Verification Panel',
          style: AppTheme.heading,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: CustomDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   height: 50,
          //   child: ElevatedButton(
          //     onPressed: currentPage > 0
          //         ? () {
          //       setState(() {
          //         currentPage--;
          //       });
          //     }
          //         : null,
          //     style: ElevatedButton.styleFrom(
          //       shape: CircleBorder(),
          //       backgroundColor: Colors.blue,
          //       disabledBackgroundColor: Colors.grey,
          //     ),
          //     child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          //   ),
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DataTable(
                  sortAscending: true,
                  dataRowMaxHeight: 100,
                  dataRowMinHeight: 50,
                  headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.blue[50]),
                  columnSpacing: 20.0,
                  border: TableBorder.symmetric(
                    inside: BorderSide(width: 1, color: Colors.grey),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Text(
                        "Name",
                        style: AppTheme.subHeading,
                      ),
                    ),
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Text(
                        "Image",
                        style: AppTheme.subHeading,
                      ),
                    ),
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Text(
                        "Role",
                        style: AppTheme.subHeading,
                      ),
                    ),
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Text(
                        "Status",
                        style: AppTheme.subHeading,
                      ),
                    ),
                  ],
                  rows: paginatedData.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item["name"],style: AppTheme.body),
                            )),
                        DataCell(
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            width: 500,
                                            height: 500,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(item["pictureUrl"]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(item["pictureUrl"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Student",style: AppTheme.body)),
                        )),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StatusWidget(
                              item["status"],
                              item["name"],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 50,
          //   child: ElevatedButton(
          //     onPressed: currentPage < totalPages - 1
          //         ? () {
          //       setState(() {
          //         currentPage++;
          //       });
          //     }
          //         : null,
          //     style: ElevatedButton.styleFrom(
          //       shape: CircleBorder(),
          //       backgroundColor: Colors.blue,
          //       disabledBackgroundColor: Colors.grey,
          //     ),
          //     child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget StatusWidget(String status, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              setState(() {
                final data = widget.title == "Student" ? studentData : staffData;
                data.firstWhere((element) => element["name"] == name)["status"] = "Approved";
              });
            },
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              setState(() {
                final data = widget.title == "Student" ? studentData : staffData;
                data.firstWhere((element) => element["name"] == name)["status"] = "Rejected";
              });
            },
          ),
        ),
      ],
    );
  }
}
