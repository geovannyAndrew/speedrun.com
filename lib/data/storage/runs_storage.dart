import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/utils/storage.dart' as storage;

abstract class IRunsStorage {
  String get _fileName;
  Future saveRuns(List<Run> runs);
  Future<List<Run>> getRuns();
}

@Injectable(as: IRunsStorage)
class RunsStorageImpl implements IRunsStorage {
  @override
  Future<List<Run>> getRuns() async {
    final runsString = await storage.getContentFromFile(_fileName);
    if (runsString != null && !runsString.isEmpty) {
      final json = jsonDecode(runsString);
      try {
        final jsonData = json as List;
        return jsonData
            .map((model) => Run.fromJson(model as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return List.empty();
      }
    }
    return List.empty();
  }

  @override
  Future saveRuns(List<Run> runs) async {
    final runsString = jsonEncode(runs);
    return await storage.saveInFile(_fileName, runsString);
  }

  @override
  // TODO: implement _fileName
  String get _fileName => "runs";
}
