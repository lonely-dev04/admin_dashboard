import 'package:approval/data.dart';
import 'package:approval/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class AdminReportPage extends StatefulWidget {
  final String title;
  const AdminReportPage({super.key, required this.title});
  @override
  State<AdminReportPage> createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> {
  int currentPage = 0;
  final int itemsPerPage = 6;

  List<Map<String, dynamic>> getPaginatedData() {
    final data = widget.title == "Student" ? studentData : staffData;
    final start = currentPage * itemsPerPage;
    final end = start + itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      case "Pending":
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final paginatedData = getPaginatedData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title} Report Panel",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: CustomDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: currentPage > 0
                  ? () {
                setState(() {
                  currentPage--;
                });
              }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.grey,
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ),
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
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _getStatusColor(item["status"]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item["status"],
                                style: TextStyle(color: Colors.white),
                              ),
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
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: currentPage < (widget.title == "Student" ? studentData.length : staffData.length) ~/ itemsPerPage
                  ? () {
                setState(() {
                  currentPage++;
                });
              }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.grey,
              ),
              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
