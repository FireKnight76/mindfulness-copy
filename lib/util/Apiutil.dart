import 'dart:convert';
import 'package:http/http.dart' as http;

void updateUserActivity(String token, int activityType, int activityId, bool activityStatus) async {
  // Base URL for your API
  final String baseUrl = 'https://mindful_api.sven.lol'; // Change this to your actual base URL

  // The full URL for the PATCH request
  final Uri url = Uri.parse('$baseUrl/api/user/activity');

  // Create the payload (the body data)
  final Map<String, dynamic> body = {
    'token': token,
    'activityType': activityType,
    'activityId': activityId,
    'activityStatus': activityStatus,
  };

  try {
    final String jsonBody = jsonEncode(body); //Converts map to JSON string

    //makes request to url
    final response = await http.patch(
      Uri.parse(url.toString()), // toString = url as string not as Uri object
      headers: { "Content-Type": "application/json"},
      body: jsonBody
    );

    //checks if request was a succes or not
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("Succes: ${response.body}"); //succes
    } else {
      print("Failed to update the database"); //failure
    }
  }catch(e){
    print("Error: $e");
  }
  print("the function has been used"); // function usage test
}
