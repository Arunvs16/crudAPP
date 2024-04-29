import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatelessWidget {
  const UpdateDonor({super.key});

  @override
  Widget build(BuildContext context) {
    final bloodgroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    String? selectedGroup;

    final CollectionReference donor =
        FirebaseFirestore.instance.collection('donor');

    //controllers
    TextEditingController donorName = TextEditingController();
    TextEditingController donorPhone = TextEditingController();

    //update fuction

    void updateDonorDetail(docId) {
      final data = {
        'name': donorName.text,
        'phone': donorPhone.text,
        'group': selectedGroup,
      };
      donor.doc(docId).update(data).then((value) => Navigator.pop(context));
    }

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    donorName.text = args['name'];
    donorPhone.text = args['phone'].toString();
    selectedGroup = args['group'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Donors'),
        backgroundColor: const Color.fromARGB(255, 184, 209, 230),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: donorName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Donor Name'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: donorPhone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                value: selectedGroup,
                decoration:
                    const InputDecoration(label: Text('Select Blood Group')),
                items: bloodgroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedGroup = val as String;
                }),
          ),
          ElevatedButton(
            onPressed: () {
              updateDonorDetail(docId);
            },
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 184, 209, 230))),
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
