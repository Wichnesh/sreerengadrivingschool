import 'package:flutter/material.dart';
import 'package:sree_renga_drivingscl/Model/AttendanceModel.dart';

class AttendanceDetail extends StatefulWidget {
  final ARData data;
  const AttendanceDetail(this.data);

  @override
  State<AttendanceDetail> createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Details'),
      ),
      body: ListView.builder(
          itemCount: widget.data.attendance!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: const Text('Days'),
                  trailing: Text('${widget.data.attendance![index]}'),
                ),
              ),
            );
          }),
    );
  }
}
