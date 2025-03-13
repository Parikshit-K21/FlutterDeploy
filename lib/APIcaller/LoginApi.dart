import 'dart:convert';
import 'package:http/http.dart' as http;


import 'Modals/LoginM.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}




class LoginService {
  final String baseUrl;
  final http.Client client;

  LoginService({
    this.baseUrl = 'http://localhost:5071',
    http.Client? client,
  }) : client = client ?? http.Client();

  // Dispose to prevent memory leaks
  void dispose() {
    client.close();
  }

  // Login with email and password
  Future<UserLogin> loginWithEmailAndPassword({
    required String email,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (email.isEmpty) {
      throw ApiException('Email cannot be empty');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }
    
    // Basic email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw ApiException('Invalid email format');
    }

    final uri = Uri.parse('$baseUrl/api/UserLogin/authenticate');
    
    try {
      final response = await client.post(
        uri,
        headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(timeout, onTimeout: () {
        throw NetworkException('Request timed out');
      });

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> data = json.decode(response.body);
          return UserLogin.fromJson(data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 401:
          throw ApiException('Invalid credentials OR InActive Account', statusCode: 401);
        case 500:
          throw ApiException('Server error', statusCode: 500);
        default:
          throw ApiException('Unexpected error: ${response.reasonPhrase}', 
              statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  // Login with mobile number and password
  Future<UserLogin> loginWithMobileAndPassword({
    required String mobileNumber,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (mobileNumber.isEmpty) {
      throw ApiException('Mobile number cannot be empty');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }
    
    // Basic mobile number format validation
    // Adjust regex according to your country's mobile number format
    final mobileRegex = RegExp(r'^\d{10}$');
    if (!mobileRegex.hasMatch(mobileNumber)) {
      throw ApiException('Invalid mobile number format (must be 10 digits)');
    }

    try {
      // First, get the user details by mobile number
      final userInfo = await getUserByMobileNumber(mobileNumber, timeout: timeout);
      
      if (userInfo == null) {
        throw ApiException('User not found with this mobile number', statusCode: 404);
      }
      
      // Then authenticate with the retrieved email and provided password
      if (userInfo.emailAddress == null || userInfo.emailAddress!.isEmpty) {
        throw ApiException('User account has no email associated', statusCode: 400);
      }
      
      return await loginWithEmailAndPassword(
        email: userInfo.emailAddress!,
        password: password,
        timeout: timeout,
      );
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error during mobile login: $e');
    }
  }

  // Get user by mobile number
  Future<UserLogin?> getUserByMobileNumber(
    String mobileNumber, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (mobileNumber.isEmpty) {
      throw ApiException('Mobile number cannot be empty');
    }

    final uri = Uri.parse('$baseUrl/api/UserLogin/mobile/$mobileNumber');
    
    try {
      final response = await client.get(uri).timeout(timeout, onTimeout: () {
        throw NetworkException('Request timed out');
      });

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> data = json.decode(response.body);
          return UserLogin.fromJson(data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 404:
          return null; // User not found
        case 500:
          throw ApiException('Server error', statusCode: 500);
        default:
          throw ApiException('Unexpected error: ${response.reasonPhrase}', 
              statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  // Login with user ID and password
  Future<UserLogin> loginWithUserIdAndPassword({
    required String userId,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (userId.isEmpty) {
      throw ApiException('Invalid user ID');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }

    try {
      // First, get the user details by ID
      final userInfo = await getUserById(userId, timeout: timeout);
      
      if (userInfo == null) {
        throw ApiException('User not found with this ID', statusCode: 404);
      }
      
      // Then authenticate with the retrieved email and provided password
      if (userInfo.emailAddress == null || userInfo.emailAddress!.isEmpty) {
        throw ApiException('User account has no email associated', statusCode: 400);
      }
      
      return await loginWithEmailAndPassword(
        email: userInfo.emailAddress!,
        password: password,
        timeout: timeout,
      );
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error during user ID login: $e');
    }
  }

  // Get user by ID
  Future<UserLogin?> getUserById(
    String userId, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (userId.isEmpty) {
      throw ApiException('Invalid user ID');
    }

    final uri = Uri.parse('$baseUrl/api/UserLogin/$userId');
    
    try {
      final response = await client.get(uri).timeout(timeout, onTimeout: () {
        throw NetworkException('Request timed out');
      });

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> data = json.decode(response.body);
          return UserLogin.fromJson(data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 404:
          return null; // User not found
        case 500:
          throw ApiException('Server error', statusCode: 500);
        default:
          throw ApiException('Unexpected error: ${response.reasonPhrase}', 
              statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }
}