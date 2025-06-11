import 'dart:convert';

import 'package:covid/Model/world_states_model.dart';
import 'package:covid/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.worldStateApi));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      } else {
        throw Exception('Failed to Load Data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to Load Data');
    }
  }
}
