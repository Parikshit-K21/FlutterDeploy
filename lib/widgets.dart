import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildTextField({ required String label, Color? color , double? height, double? width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     SizedBox(
    width: width ?? double.infinity, // Default to full width if not provided
    child:  TextFormField(
          style: const TextStyle(fontSize: 14),
          maxLines: height != null ? (height ~/ 20) : 1, // Approximate lines based on height
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            labelText: label, // Label inside the field
            alignLabelWithHint: true,
            labelStyle:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, // Moves label above when typing
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8, // Adjusts padding based on height
            ),
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
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

Widget buildNumberField(String label,Color? art) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 40, // Ensuring proper height
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: label, // Label inside the field
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:art,
            ),
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, // Moves label above when typing
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
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
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

// Widget buildDateField(String label) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 40,
//         child: TextFormField(
//           readOnly: true,
//           controller: TextEditingController(
//             text:
//                 _selectedDate != null
//                     ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
//                     : '',
//           ),
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );
//             if (pickedDate != null) {
//               setState(() {
//                 _selectedDate = pickedDate;
//               });
//             }
//           },
//           style: const TextStyle(fontSize: 14),
//           decoration: InputDecoration(
//             labelText: label, // Floating label
//             labelStyle: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//             floatingLabelBehavior:
//                 FloatingLabelBehavior.auto, // Moves label above when filled
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               size: 18,
//             ), // Calendar icon
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 8,
//               vertical: 4,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           validator: (value) {
//             if (label.endsWith('*') && (value == null || value.isEmpty)) {
//               return 'This field is required';
//             }
//             return null;
//           },
//         ),
//       ),
//       const SizedBox(height: 16.0),
//     ],
//   );
// }

Widget buildDropdownField(String label, List<String> items,Color? color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 40,
        child: DropdownButtonFormField<String>(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          dropdownColor: Colors.white,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    ),
                  )
                  .toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: label, // Floating label
            labelStyle:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:color,
            ),
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, // Moves label above when selected
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          validator: (value) {
            if (label.endsWith('*') && value == null) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

Widget ElevatedButtonWidget(String text, Color color) {
  return SizedBox(
    width: 90,
    height: 30,
    child: ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}