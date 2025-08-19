import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:snt_app/Models/event_model.dart';

class EventService {

  Future<List<EventModel>> fetchEvents() async {

    await Future.delayed(const Duration(seconds: 2));
    
    final String response = await rootBundle.loadString('lib/Assets/Data/events.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => EventModel.fromJson(e)).toList();

  }

}