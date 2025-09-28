import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/event_model.dart';

class EventService {
  final _client = Supabase.instance.client;
  final String _table = 'events'; // or 'events_with_status' if you created the view

  Future<List<EventModel>> fetchAll({int limit = 100, int offset = 0}) async {
    final rows = await _client
        .from(_table)
        .select()
        .order('date', ascending: true)
        .range(offset, offset + limit - 1);

    final data = rows as List<dynamic>;
    return data.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<EventModel>> fetchUpcoming() async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final rows = await _client
        .from(_table)
        .select()
        .gte('date', nowIso)
        .order('date', ascending: true);

    final data = rows as List<dynamic>;
    return data.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<EventModel>> fetchPrevious() async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final rows = await _client
        .from(_table)
        .select()
        .lt('date', nowIso)
        .order('date', ascending: false);

    final data = rows as List<dynamic>;
    return data.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
