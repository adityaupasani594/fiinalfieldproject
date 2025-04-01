import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forensic/custom/mytextfield.dart';
import 'package:forensic/pages/upload.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/drop.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  TextEditingController date = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController OPG = TextEditingController();
  TextEditingController Bitewing = TextEditingController();
  TextEditingController Lateralceph = TextEditingController();
  TextEditingController CBCT = TextEditingController();
  TextEditingController CT = TextEditingController();
  TextEditingController MRI = TextEditingController();
  TextEditingController USG = TextEditingController();
  TextEditingController Any_other = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController reg = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController aadhar = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController complaint = TextEditingController();
  TextEditingController dent_primary = TextEditingController();
  TextEditingController dent_mixed = TextEditingController();
  TextEditingController dent_perm = TextEditingController();
  TextEditingController decayed = TextEditingController();
  TextEditingController amalgam = TextEditingController();
  TextEditingController composite = TextEditingController();
  TextEditingController gold = TextEditingController();
  TextEditingController rct = TextEditingController();
  TextEditingController missing = TextEditingController();
  TextEditingController attrition = TextEditingController();
  TextEditingController abrasion = TextEditingController();
  TextEditingController erosion = TextEditingController();
  TextEditingController abfraction = TextEditingController();
  TextEditingController tooth_size = TextEditingController();
  TextEditingController tooth_shape = TextEditingController();
  TextEditingController tooth_no = TextEditingController();
  TextEditingController tooth_struc = TextEditingController();
  TextEditingController tooth_mal = TextEditingController();
  TextEditingController lip_palates = TextEditingController();
  TextEditingController oral_mucosa = TextEditingController();
  TextEditingController gingiva = TextEditingController();
  TextEditingController jaws = TextEditingController();
  TextEditingController tongue = TextEditingController();
  TextEditingController crown = TextEditingController();
  TextEditingController implant = TextEditingController();
  TextEditingController removable_fixed = TextEditingController();
  TextEditingController partial_complete = TextEditingController();
  TextEditingController maxilla_mandible = TextEditingController();
  TextEditingController other = TextEditingController();
  TextEditingController iopa = TextEditingController();
  TextEditingController study_cast = TextEditingController();
  TextEditingController palatoscopy = TextEditingController();
  TextEditingController lip_print = TextEditingController();
  TextEditingController tongue_print = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String thisDate = '';
  String thisDOB = '';

  Future<void> _selectDate(BuildContext context, TextEditingController controller, Function(String) updateState) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = " : ${picked.day}/${picked.month}/${picked.year}";
        updateState(formattedDate); // Call function to update UI
        controller.text = formattedDate; // Update text controller
      });
    }
  }

  void clearFields() {
    date.clear();
    name.clear();
    OPG.clear();
    Bitewing.clear();
    Lateralceph.clear();
    CBCT.clear();
    CT.clear();
    MRI.clear();
    USG.clear();
    Any_other.clear();
    dob.clear();
    gender.clear();
    reg.clear();
    address.clear();
    aadhar.clear();
    contact.clear();
    complaint.clear();
    dent_primary.clear();
    dent_mixed.clear();
    dent_perm.clear();
    decayed.clear();
    amalgam.clear();
    composite.clear();
    gold.clear();
    rct.clear();
    missing.clear();
    attrition.clear();
    abrasion.clear();
    erosion.clear();
    abfraction.clear();
    tooth_size.clear();
    tooth_shape.clear();
    tooth_no.clear();
    tooth_struc.clear();
    tooth_mal.clear();
    lip_palates.clear();
    oral_mucosa.clear();
    gingiva.clear();
    jaws.clear();
    tongue.clear();
    crown.clear();
    implant.clear();
    removable_fixed.clear();
    partial_complete.clear();
    maxilla_mandible.clear();
    other.clear();
    iopa.clear();
    study_cast.clear();
    palatoscopy.clear();
    lip_print.clear();
    tongue_print.clear();
    diagnosis.clear();

    thisDate = '';
    thisDOB = '';
  }

  static const my = SizedBox(
    height: 10,
  );

  String jetFieldValue(TextEditingController controller) {
    return controller.text.isEmpty ? 'None' : controller.text;
  }

  Future<void> addDataToFirestore() async {
    try {
      await _firestore.collection('patients').add({
        'aadhar':jetFieldValue(aadhar),
        'abfraction':jetFieldValue(abfraction),
        'abrasion':jetFieldValue(abrasion),
        'address':jetFieldValue(address),
        'amalgam':jetFieldValue(amalgam),
        'anyother':jetFieldValue(Any_other),
        'attrition':jetFieldValue(attrition),
        'bw':jetFieldValue(Bitewing),
        'cbct':jetFieldValue(CBCT),
        'complaint':jetFieldValue(complaint),
        'compo':jetFieldValue(composite),
        'contact':jetFieldValue(contact),
        'crown':jetFieldValue(crown),
        'ct':jetFieldValue(CT),
        'date':jetFieldValue(date),
        'decay':jetFieldValue(decayed),
        'di':jetFieldValue(implant),
        'diag':jetFieldValue(diagnosis),
        'dob':jetFieldValue(dob),
        'erosion':jetFieldValue(erosion),
        'g':jetFieldValue(gingiva),
        'gender':jetFieldValue(gender),
        'gold':jetFieldValue(gold),
        'iopa':jetFieldValue(iopa),
        'j':jetFieldValue(jaws),
        'lc':jetFieldValue(Lateralceph),
        'lip':jetFieldValue(lip_palates),
        'lprint':jetFieldValue(lip_print),
        'mal':jetFieldValue(tooth_mal),
        'missing':jetFieldValue(missing),
        'mixed':jetFieldValue(dent_mixed),
        'mm':jetFieldValue(maxilla_mandible),
        'mri':jetFieldValue(MRI),
        'name':jetFieldValue(name),
        'number':jetFieldValue(tooth_no),
        'om':jetFieldValue(oral_mucosa),
        'opg':jetFieldValue(OPG),
        'other':jetFieldValue(other),
        'pala':jetFieldValue(palatoscopy),
        'pc':jetFieldValue(partial_complete),
        'perm':jetFieldValue(dent_perm),
        'photo':'None',
        'prim':jetFieldValue(dent_primary),
        'rct':jetFieldValue(rct),
        'reg':jetFieldValue(reg),
        'rf':jetFieldValue(removable_fixed),
        'sc':jetFieldValue(study_cast),
        'shape':jetFieldValue(tooth_shape),
        'size':jetFieldValue(tooth_size),
        'structure':jetFieldValue(tooth_struc),
        't':jetFieldValue(tongue),
        'tprint':jetFieldValue(tongue_print),
        'usg':jetFieldValue(USG)
      });
      print("Data added successfully");
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  final heading = GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, 'about');}, icon: Icon(Icons.message)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'pro');
          }, icon: Icon(Icons.person))
        ],
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 0, // Remove default shadow
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
        title: Text(
          'Forensodont',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Image.asset(
                "assets/bg2.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        'General Details',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    //general
                    GestureDetector(
                      onTap: () => _selectDate(context, date, (newDate) => thisDate = newDate),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          child: Text(
                            'Date$thisDate', // Reflects the selected date
                            style: TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(hintText: 'Registration Number', controller: reg),
                    //end
                    Text(
                      'Personal Details',
                      style: heading
                    ),
                    //personal details
                    CustomTextField(hintText: 'Name', controller: name),
                    GestureDetector(
                      onTap: () => _selectDate(context, dob, (newDate) => thisDOB = newDate),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          child: Text(
                            'Date of Birth$thisDOB', // Reflects the selected date
                            style: TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    CustomDropdownField(
                      hintText: 'Gender',
                      controller: gender,
                      options: ['Male', 'Female', 'Other'],
                    ),

                    CustomTextField(hintText: 'Address', controller: address),
                    CustomTextField(hintText: 'Aadhar Number', controller: aadhar),
                    CustomTextField(hintText: 'Contact', controller: contact),
                    //end personal
                    CustomTextField(hintText: 'Complaint', controller: complaint),
                    Text(
                      'Dentition',
                      style: heading
                    ),
                    my,
                    ExpandableCheckbox(children: [
                      CustomTextField(hintText: 'Primary', controller: dent_primary),
                      CustomTextField(hintText: 'Mixed', controller: dent_mixed),
                      CustomTextField(hintText: 'Permanent', controller: dent_perm),
                    ]),
                    my,
                    Text(
                      'Dental Charting',
                      style: heading
                    ),
                    my,
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(context, amalgam, gold, rct, composite, decayed, missing);
                      },
                      child: Container(
                        height: 50,
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                              'Add Dental Charting',
                              style: heading
                          ),
                        ),
                      ),
                    ),
                    my,
                    Text(
                      'Regressive Changes',
                      style: heading
                    ),
                    my,
                    ExpandableCheckbox(children: [
                      CustomTextField(hintText: 'Attrition', controller: attrition),
                      CustomTextField(hintText: 'Abrasion', controller: abrasion),
                      CustomTextField(hintText: 'Erosion', controller: erosion),
                      CustomTextField(hintText: 'Abfraction', controller: abfraction),
                    ]),
                    my,
                    //endreg
                    //pathologies
                    //tooth
                    Text(
                      'Pathologies',
                      style: heading
                    ),
                    my,
                    ExpandableCheckbox(children: [
                      CustomTextField(hintText: 'Lip Palates', controller: lip_palates),
                      CustomTextField(hintText: 'Oral Mucosa', controller: oral_mucosa),
                      CustomTextField(hintText: 'Gingiva', controller: gingiva),
                      CustomTextField(hintText: 'Jaws', controller: jaws),
                      CustomTextField(hintText: 'Tongue', controller: tongue),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                  'Tooth',
                                  style: heading
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(hintText: 'Tooth Size', controller: tooth_size),
                              CustomTextField(hintText: 'Tooth Shape', controller: tooth_shape),
                              CustomTextField(hintText: 'Tooth No.', controller: tooth_no),
                              CustomTextField(hintText: 'Tooth Structure', controller: tooth_struc),
                              CustomTextField(hintText: 'Tooth Mal-position', controller: tooth_mal),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    my,
                    //endtooth

                    //end tongue
                    //previous treatment
                    Text(
                      'Previous',
                      style: heading
                    ),
                    my,
                    ExpandableCheckbox(children: [
                      CustomTextField(hintText: 'Other Details', controller: other),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                  'Prothesis',
                                  style: heading
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(hintText: 'Crown', controller: crown),
                              CustomTextField(hintText: 'Implant', controller: implant),
                              CustomTextField(hintText: 'Removable Fixed', controller: removable_fixed),
                              CustomTextField(hintText: 'Partial Complete', controller: partial_complete),
                              CustomTextField(hintText: 'Maxilla Mandible', controller: maxilla_mandible),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    my,
                    Text(
                      'Photos',
                      style: heading
                    ),
                    my,
                    ExpandableCheckbox(children: [
                      UploadButtonWidget(label: 'IOPA', controller: iopa),
                      UploadButtonWidget(label: 'OPG', controller: OPG),
                      UploadButtonWidget(label: 'BiteWing', controller: Bitewing),
                      UploadButtonWidget(label: 'Lateralceph', controller: Lateralceph),
                      UploadButtonWidget(label: 'CBCT', controller: CBCT),
                      UploadButtonWidget(label: 'CT', controller: CT),
                      UploadButtonWidget(label: 'MRI', controller: MRI),
                      UploadButtonWidget(label: 'USG', controller: USG),
                      UploadButtonWidget(label: 'Any other', controller: Any_other),
                      UploadButtonWidget(label: 'Study Cast', controller: study_cast),
                      UploadButtonWidget(label: 'Palatoscopy', controller: palatoscopy),
                      UploadButtonWidget(label: 'Lip Print', controller: lip_print),
                      UploadButtonWidget(label: 'Tongue Print', controller: tongue_print),
                    ]),
                    my,
                    CustomTextField(hintText: 'Diagnosis', controller: diagnosis),
                    my,
                    GestureDetector(
                      onTap: () async {
                        await addDataToFirestore();
                        clearFields();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text('Submitted!',style: TextStyle(color: Colors.white),),
                              duration: Duration(seconds: 2),
                            ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: heading
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomDialog(BuildContext context, TextEditingController amal, TextEditingController gold, TextEditingController rct,
    TextEditingController comp, TextEditingController decay, TextEditingController miss) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: ColorfulGrid(amalgamController: amal,goldController: gold, rctController: rct, compositeController: comp, decayedController: decay, missingController: miss,),
      );
    },
  );
}

class ColorfulGrid extends StatefulWidget {
  final TextEditingController amalgamController;
  final TextEditingController goldController;
  final TextEditingController rctController;
  final TextEditingController compositeController;
  final TextEditingController decayedController;
  final TextEditingController missingController;

  const ColorfulGrid({
    super.key,
    required this.amalgamController,
    required this.goldController,
    required this.rctController,
    required this.compositeController,
    required this.decayedController,
    required this.missingController,
  });

  @override
  _ColorfulGridState createState() => _ColorfulGridState();
}

class _ColorfulGridState extends State<ColorfulGrid> {
  Color selectedColor = Colors.blue;
  late final Map<String, Color> colorMap;
  late final Map<String, TextEditingController> colorControllers;

  final List<List<String>> coordinates = [
    ["5-5", "5-4", "5-3", "5-2", "5-1", "space", "6-1", "6-2", "6-3", "6-4", "6-5"],
    ["1-8", "1-7", "1-6", "1-5", "1-4", "1-3", "1-2", "1-1", "space", "2-1", "2-2", "2-3", "2-4", "2-5", "2-6", "2-7", "2-8"],
    ["4-8", "4-7", "4-6", "4-5", "4-4", "4-3", "4-2", "4-1", "space", "3-1", "3-2", "3-3", "3-4", "3-5", "3-6", "3-7", "3-8"],
    ["8-5", "8-4", "8-3", "8-2", "8-1", "space", "7-1", "7-2", "7-3", "7-4", "7-5"],
  ];

  final Map<String, Color> boxColors = {};

  @override
  void initState() {
    super.initState();

    colorMap = {
      "Filled - Amalgam": Colors.green,
      "Filled - Gold": Colors.yellow.shade700,
      "Filled - RCT": Colors.blue,
      "Filled - Composite": Colors.purple,
      "Decayed": Colors.black,
      "Missing": Colors.red,
    };

    colorControllers = {
      "Filled - Amalgam": widget.amalgamController,
      "Filled - Gold": widget.goldController,
      "Filled - RCT": widget.rctController,
      "Filled - Composite": widget.compositeController,
      "Decayed": widget.decayedController,
      "Missing": widget.missingController,
    };

    for (var row in coordinates) {
      for (var coord in row) {
        if (coord != "space") {
          boxColors[coord] = Colors.grey;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<Color>(
              value: selectedColor,
              items: colorMap.entries.map((entry) {
                return DropdownMenuItem<Color>(
                  value: entry.value,
                  child: Text(entry.key, style: TextStyle(color: entry.value)),
                );
              }).toList(),
              onChanged: (Color? newColor) {
                if (newColor != null) {
                  setState(() {
                    selectedColor = newColor;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                child: Column(
                  children: coordinates.map((row) => buildRow(row)).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...colorControllers.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                controller: entry.value,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: entry.key,
                  border: OutlineInputBorder(),
                ),
              ),
            )),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(List<String> row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: row.map((coord) {
          if (coord == "space") {
            return const SizedBox(width: 20);
          }
          return _buildBox(coord);
        }).toList(),
      ),
    );
  }

  Widget _buildBox(String coord) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (boxColors[coord] == selectedColor) {
            boxColors[coord] = Colors.grey;
          } else {
            boxColors[coord] = selectedColor;
          }

          String colorKey = colorMap.entries.firstWhere((entry) => entry.value == selectedColor).key;
          TextEditingController controller = colorControllers[colorKey]!;

          List<String> coords = controller.text.isEmpty
              ? []
              : controller.text.split(", ");

          if (coords.contains(coord)) {
            coords.remove(coord);
          } else {
            coords.add(coord);
          }
          controller.text = coords.join(", ");
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: boxColors[coord],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}



class ExpandableCheckbox extends StatefulWidget {
  final List<Widget> children;

  const ExpandableCheckbox({super.key, required this.children});

  @override
  _ExpandableCheckboxState createState() => _ExpandableCheckboxState();
}

class _ExpandableCheckboxState extends State<ExpandableCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: CheckboxListTile(
            title: const Text("Show More"),
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isChecked
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}