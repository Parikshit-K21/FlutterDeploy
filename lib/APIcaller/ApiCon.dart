import 'dart:convert';
import 'package:http/http.dart' as http;




class ApiService {
  static const String baseUrl = "https://qa.birlawhite.com:55232/api/Control";
  // qa.birlawhite.com:55232/api/Control

  Future<List<dynamic>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }

  



  Future<List> getone(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }

  Future<void> del(String id) async{

    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return  print("DELTED THE DATA");
    } else {
      throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }


   Future<void> sendData(String doc, String processType,
                         String description, DateTime date, 
                          String meetingVenue, String location, 
                          String district, String pincode, String product) async {
  final url=baseUrl;
  final dateString = date.toIso8601String();

  final body = jsonEncode({
    'Doc': doc,
    'Area': pincode,
    'Loc': location,
    'Pro': processType,
    'Act': description,
    'Date': dateString,
    'Met': meetingVenue,
    'Dist': district,
    'Prod': product,
  });

  print(body);

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response.statusCode == 201) {
    // Handle successful response
    print('Data sent successfully');
  } else {
    // Handle error
    print('Error: ${response.statusCode}');
  }
}


  Future<List<String>> getDistinctValues(String columnName) async {
    final response = await http.get(Uri.parse("$baseUrl/distinct/$columnName"));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch distinct values for $columnName");
    }
  }




Future<List<String>> getStates() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getstates'));
      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      }
      throw Exception('Failed to load states');
    } catch(e) {
      print(e);
      throw Exception('Error loading states: $e');
    }
  }


  Future<List<String>> getAreas(String state) async {
    final url = '$baseUrl/getdistricts/$state';
  try {
   
    final response = await http.get(Uri.parse(url));  
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    }
    throw Exception('Failed to load Areas: Status code ${response.statusCode}');
  } catch(e) {
    throw Exception('Error loading Areas: $e');
  }
  }


Future<String> getAreaCode(String area) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/areaCode/$area'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse and validate the response
        final areaCode = response.body;
        if (areaCode.isEmpty) {
          throw Exception('Empty area code received');
        }
        return areaCode;
      } else {
        throw Exception('Failed to get area code. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching area code: $e');
    }
  }


}