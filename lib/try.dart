import 'package:bw_sparsh/Apicaller/ApiCon.dart';
import 'package:flutter/material.dart';

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  List<String> _states = [];
  List<String> _areas = [];
  String? _selectedState;
  String? _selectedArea;
  ApiService api=ApiService();

 Future<void> _loadArea(String state) async {
    try {
      print(state);
            print(state.runtimeType);

      final data = await api.getAreas(state);
      print(data);
      setState(() {
        _areas = data;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }
  Future<void> _loadStates() async {
    try {
      final data = await api.getStates();
            print(data);
      setState(() {
        _states = data;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }
  
  

  @override
  void initState() {
    super.initState();
    _loadStates();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dependent Dropdowns'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text('Select State'),
              value: _selectedState,
              items: _states.map((state) {
                return DropdownMenuItem(
                  child: Text(state),
                  value: state,
                );
              }).toList(),
              onChanged: (String? newState) {
                setState(() {
                  _selectedState = newState;
                  _selectedArea = null;
                  _loadArea(newState!);
                });
              },
            ),
            DropdownButton(
              hint: Text('Select Area'),
              value: _selectedArea,
              items: _areas.map((area) {
                return DropdownMenuItem(
                  child: Text(area),
                  value: area,
                );
              }).toList(),
              onChanged: (String? newArea) {
                setState(() {
                  _selectedArea = newArea;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
