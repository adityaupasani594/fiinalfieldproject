import 'dart:ui';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, TextEditingController> _searchControllers = {};
  bool _filtersExpanded = false;
  List<QueryDocumentSnapshot> filteredDocs = [];

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Stack(
          children: [
            Image.network(imageUrl),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(String? imageUrl) {
    if (imageUrl == null || imageUrl == 'None') {
      return const Text('None');
    }
    return GestureDetector(
      onTap: () => _showImageDialog(imageUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Future<void> generatePDF() async {
    if (filteredDocs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data to export')),
      );
      return;
    }

    final pdf = pw.Document();

    // Create a list of data rows
    final data = filteredDocs.map((doc) {
      return columnOrder.map((field) => doc[field]?.toString() ?? '-').toList();
    }).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Table.fromTextArray(
              headers: columnOrder.map((field) => fieldMap[field] ?? '-').toList(),
              data: data,
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF1976D2) ),
              cellStyle: const pw.TextStyle(fontSize: 10),
              columnWidths: {
                for (var i = 0; i < columnOrder.length; i++)
                  i: const pw.FlexColumnWidth(1)
              },
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  List<String> selectedFields = [];
  Map<String, String> fieldMap = {
    'aadhar': 'Aadhar Number',
    'abfraction': 'Abfraction',
    'abrasion': 'Abrasion',
    'address': 'Address',
    'amalgam': 'Amalgam',
    'anyother': 'Any Other',
    'attrition': 'Attrition',
    'bw': 'Bitewing',
    'cbct': 'CBCT',
    'complaint': 'Complaint',
    'compo': 'Composite',
    'contact': 'Contact',
    'crown': 'Crown',
    'ct': 'CT',
    'date': 'Date',
    'decay': 'Decay',
    'di': 'Dental Implant',
    'diag': 'Diagnosis',
    'dob': 'Date of Birth',
    'erosion': 'Erosion',
    'g': 'Gingiva',
    'gender': 'Gender',
    'gold': 'Gold',
    'iopa': 'IOPA',
    'j': 'Jaws',
    'lc': 'Lateral Cephalogram',
    'lip': 'Lip & Palates',
    'lprint': 'Lip Print',
    'mal': 'Tooth Malposition',
    'missing': 'Missing Teeth',
    'mixed': 'Mixed Dentition',
    'mm': 'Maxilla & Mandible',
    'mri': 'MRI',
    'name': 'Patient Name',
    'number': 'Tooth Number',
    'om': 'Oral Mucosa',
    'opg': 'OPG',
    'other': 'Other',
    'pala': 'Palatoscopy',
    'pc': 'Partial/Complete Prosthesis',
    'perm': 'Permanent Dentition',
    'photo': 'Photo',
    'prim': 'Primary Dentition',
    'rct': 'Root Canal Treatment',
    'reg': 'Registration Number',
    'rf': 'Removable/Fixed Prosthesis',
    'sc': 'Study Cast',
    'shape': 'Tooth Shape',
    'size': 'Tooth Size',
    'structure': 'Tooth Structure',
    't': 'Tongue',
    'tprint': 'Tongue Print',
    'usg': 'Ultrasound (USG)'
  };

  List<String> columnOrder = [
    'date', 'name', 'dob', 'gender', 'reg', 'address', 'aadhar', 'contact', 'complaint',
    'prim', 'mixed', 'perm', 'decay', 'amalgam', 'compo', 'gold', 'rct', 'missing',
    'attrition', 'abrasion', 'erosion', 'abfraction', 'size', 'shape', 'number',
    'structure', 'mal', 'lip', 'om', 'g', 'j', 't', 'crown', 'di', 'rf', 'pc', 'mm',
    'anyother', 'iopa', 'opg', 'bw', 'lc', 'cbct', 'ct', 'mri', 'usg', 'other', 'sc',
    'pala', 'lprint', 'tprint', 'diag'
  ];

  @override
  void dispose() {
    _searchControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'pro');
            },
            icon: const Icon(Icons.person),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Forensodont',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        onPressed: () {
          generatePDF();
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Image.asset(
                "assets/bg.jpg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    elevation: 4,
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      title: const Text(
                        'Search Filters',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(_filtersExpanded
                          ? Icons.expand_less
                          : Icons.expand_more),
                      onExpansionChanged: (expanded) {
                        setState(() => _filtersExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Wrap(
                            spacing: 8.0,
                            children: fieldMap.keys.map((field) {
                              return ChoiceChip(
                                label: Text(fieldMap[field]!),
                                selected: selectedFields.contains(field),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedFields.add(field);
                                      _searchControllers[field] =
                                          TextEditingController();
                                    } else {
                                      selectedFields.remove(field);
                                      _searchControllers.remove(field);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ...selectedFields.map((field) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16.0),
                          child: TextField(
                            controller: _searchControllers[field],
                            decoration: InputDecoration(
                              labelText: 'Enter ${fieldMap[field]}',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(8.0)),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        )),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Search applied!'),
                                      duration: Duration(seconds: 2)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text('Search',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              onPressed: () {
                                setState(() {
                                  selectedFields.clear();
                                  _searchControllers.clear();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Filters cleared!'),
                                      duration: Duration(seconds: 2)),
                                );
                              },
                              child: const Text('Clear',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('patients').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No patient data found.'));
                      }

                      filteredDocs = snapshot.data!.docs.where((doc) {
                        if (selectedFields.isEmpty) return true;
                        return selectedFields.every((field) {
                          String searchValue = _searchControllers[field]
                              ?.text
                              .trim()
                              .toLowerCase() ??
                              '';
                          return searchValue.isEmpty ||
                              (doc[field]
                                  ?.toString()
                                  .toLowerCase()
                                  .contains(searchValue) ??
                                  false);
                              });
                      }).toList();

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: DataTable(
                            columnSpacing: 16,
                            headingRowColor:
                            MaterialStateColor.resolveWith((states) =>
                            Colors.blue.shade800),
                            dataRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                            border: TableBorder(
                                horizontalInside: BorderSide(
                                    color: Colors.white, width: 0.5),
                                verticalInside: BorderSide(
                                    color: Colors.white, width: 0.5)),
                            columns: columnOrder
                                .map((field) => DataColumn(
                                label: Text(
                                  fieldMap[field] ?? '-',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                )))
                                .toList(),
                            rows: filteredDocs.map((doc) {
                              return DataRow(
                                color: MaterialStateProperty.resolveWith<
                                    Color?>((states) => states.contains(
                                    MaterialState.selected)
                                    ? Colors.purple.shade100
                                    : null),
                                cells: columnOrder.map((field) {
                                  if ([
                                    'opg',
                                    'bw',
                                    'lc',
                                    'cbct',
                                    'ct',
                                    'mri',
                                    'usg',
                                    'anyother',
                                    'sc',
                                    'pala',
                                    'lprint',
                                    'tprint'
                                  ].contains(field)) {
                                    return DataCell(_buildImageThumbnail(
                                        doc[field]?.toString()));
                                  }
                                  return DataCell(Text(
                                      doc[field]?.toString() ?? '-',
                                      style: const TextStyle(fontSize: 14)));
                                }).toList(),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}