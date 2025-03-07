import 'dart:io' as io; // For mobile file handling
import 'dart:typed_data'; // For web file handling
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:bw_sparsh/Apicaller/ApiCon.dart';
import 'package:bw_sparsh/Logic/Doc.dart';

import '../../custom_app_bar/app_bar.dart';
import 'Display.dart';

void main() {
  runApp(const RetailerRegistrationApp2());
}

class RetailerRegistrationApp2 extends StatelessWidget {
  const RetailerRegistrationApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RetailerRegistrationPage2(),
    );
  }
}

class RetailerRegistrationPage2 extends StatefulWidget {
  const RetailerRegistrationPage2({super.key});

  @override
  State<RetailerRegistrationPage2> createState() =>
      _RetailerRegistrationPageState();
}

class _RetailerRegistrationPageState extends State<RetailerRegistrationPage2> {
  final _formKey = GlobalKey<FormState>();

   String? _selectedOption;

  String? _uploadedFileName;
  String? _uploadedFile;
  Uint8List? _fileBytes; // For web
  String? _filePath; // For mobile


    TextEditingController ProcesTp= TextEditingController();
    TextEditingController retailCat= TextEditingController();
    TextEditingController Area= TextEditingController();
    TextEditingController District= TextEditingController();
    TextEditingController GST= TextEditingController();
    TextEditingController PAN= TextEditingController();
    TextEditingController Mobile= TextEditingController();
    TextEditingController Address= TextEditingController();
    TextEditingController Scheme= TextEditingController();

    ApiService api= ApiService();
    

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true, // Required for web
      withReadStream: false, // Optional for large files
    );

    if (result != null) {
      setState(() {
        _uploadedFileName = result.files.single.name;
        if (kIsWeb) {
          // For web, use bytes
          _fileBytes = result.files.single.bytes;
        } else {
          // For mobile, use file path
          _filePath = result.files.single.path;
        }
      });
    }
  }

  void _viewFile() {
    if (kIsWeb) {
      // Web: Display file from bytes
      if (_fileBytes != null) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: 300,
              height: 400,
              child: _uploadedFileName!.endsWith('.jpg') ||
                      _uploadedFileName!.endsWith('.png') ||
                      _uploadedFileName!.endsWith('.jpeg')
                  ? Image.memory(
                      _fileBytes!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: const Text(
                        'Cannot preview this file type.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
            ),
          ),
        );
      }
    } else {
      // Mobile: file from path
      if (_filePath != null) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: 300,
              height: 400,
              child: _filePath!.endsWith('.jpg') ||
                      _filePath!.endsWith('.png') ||
                      _filePath!.endsWith('.jpeg')
                  ? Image.file(
                      io.File(_filePath!),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: const Text(
                        'Cannot preview this file type.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Retailer Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    constraints.maxWidth > 800
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildBasicDetailsForm()),
                              const SizedBox(width: 16.0),
                              Expanded(child: _buildContactDetailsForm()),
                            ],
                          )
                        : Column(
                            children: [
                              _buildBasicDetailsForm(),
                              const SizedBox(height: 16.0),
                              _buildContactDetailsForm(),
                            ],
                          ),
                    const SizedBox(height: 32.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            String year = (DateTime.now().year % 100).toString();//current year in 2 digits

                            String doc = await generateDocuNumb(year, District.text, retailCat.text);  //generate the doc numb

                            DateTime time=DateTime.now();
                            try{
                              api.sendData(doc,ProcesTp.text,
                              GST.text,time,
                              Mobile.text,Area.text,
                              District.text,retailCat.text,Address.text);

                            }catch(e){
                              print(e);
                            }
                           Navigator.push( context,
                          MaterialPageRoute(
                                  builder: (context) =>  SearchTablePage()),
                           );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          backgroundColor: Colors.blueAccent,
                        ),
                        
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBasicDetailsForm() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 16.0),

        // First Row with Process Type and Retailer Category
        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                label: 'Process Type*',
                items: ['Add', 'Update'],
                value: ProcesTp.text,
                onChanged: (value) {
                  setState(() {
                    ProcesTp.text = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildDropdownField(
                label: 'Retailer Category*',
                items:  ['URB', 'RUR', 'DDR'],
                value: retailCat.text,
                onChanged: (value) {
                  setState(() {
                    retailCat.text = value!;
                  });
                },
              ),
            ),
          ],
        ),

        // Second Row with Area and District
        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                label: 'Area*',
                items: ['Rajistation', 'Maharastra'],
                value: Area.text,
                onChanged: (value) {
                  setState(() {
                    Area.text = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildDropdownField(
                label:'District*',
                items: ['JAI', 'MUM'],
                value: District.text,
                onChanged: (value) {
                  setState(() {
                    District.text = value!;
                  });
                },
              ),
            ),
          ],
        ),

        // Clickable Options for Registration Type
        _buildClickableOptions('Register With PAN/GST*', ['With GST', 'With PAN']),

        // Row for GST Number and PAN Number
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'GST Number*',
                value: GST.text,
                onChanged: (String value) {
                  setState(() {
                    GST.text = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildTextField(
                label: 'PAN Number*',
                value: PAN.text,
                onChanged: (String value) {
                  setState(() {
                    PAN.text = value;
                  });
                },
              ),
            ),
          ],
        ),

        // Firm Name Text Field
        _buildTextField(label: 'Firm Name', value: '', onChanged: (String value) {}),

        // Row for Mobile and Office Telephone
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Mobile*',
                value: Mobile.text,
                inputFormatters: [
      FilteringTextInputFormatter.digitsOnly, // Allow only digits
      LengthLimitingTextInputFormatter(10), // Optional: limit to 10 digits
    ],
                onChanged: (String value) {
                  setState(() {
                    Mobile.text = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildTextField(label:'Office Telephone', value:'', onChanged:(String value) {}),
            ),
          ],
        ),

        // Email Text Field
        _buildTextField(label:'Email', onChanged:(String value) {}, value:''),

        // Address Fields
        _buildTextField(label:'Address 1*', value : Address.text, onChanged:(String value) {
          setState(() {
            Address.text = value;
          });
        }),

        // Row for Address 2 and Address 3
        Row(
          children:[
            Expanded(child:_buildTextField(label:'Address 2', onChanged:(String value){},value:'')),
            const SizedBox(width : 16.0),
            Expanded(child:_buildTextField(label:'Address 3', onChanged:(String value){},value:'')),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildContactDetailsForm() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildPredefinedField('Stockist Code', '4401S711'),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextField(label: 'Tally Retailer Code', onChanged: (String value) {  }, value: ''),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(label: 'Concern Employee', onChanged: (String value) {  }, value: ''),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildUploadField('Retailer Profile Image'),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildUploadField('PAN / GST No Image Upload / View'),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildDropdownField(label: 'Scheme Required', items: ['Yes', 'No'],value:Scheme.text ,
                 onChanged: (String? value) {   setState(() {
                       Scheme.text = value!;}); }),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(label: 'Aadhar Card No', onChanged: (String value) {}, value: ''),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildUploadField('Aadhar Card Upload'),
              ),
            ],
          ),
          _buildTextField(label: 'Proprietor / Partner Name', value: ''),
        ],
      ),
    );
  }

Widget _buildTextField({
  required String label,
  required String? value,
   ValueChanged<String>? onChanged,  List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      const SizedBox(height: 4),
      TextFormField(
        initialValue: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (label.endsWith('*') && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

  Widget _buildDropdownField({
  required String label,
  required List<String> items,
  required String? value,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      const SizedBox(height: 4),
      DropdownButtonFormField<String>(
        value: items.contains(value) ? value : items.first, // Ensure valid initial value
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (selectedValue) {
          if (label.endsWith('*') && selectedValue == null) {
            return 'This field is required';
          }
          return null;
        },
      ),
      const SizedBox(height: 16.0),
    ],
  );
}



  Widget _buildClickableOptions(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: options
              .map((option) => ChoiceChip(
                    label: Text(option),
                    selected: false,
                    onSelected: (selected) {},
                    labelStyle: const TextStyle(color: Colors.blueAccent),
                    backgroundColor: Colors.blue[100],
                    selectedColor: Colors.blueAccent,
                  ))
              .toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

   Widget _buildUploadField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child:
                  const Icon(Icons.upload, color: Colors.white, size: 16),
            ),
            ElevatedButton(
              onPressed: _uploadedFileName != null ? _viewFile : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('View', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        if (_uploadedFileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Uploaded File: ${_uploadedFileName!.split('/').last}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildPredefinedField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
