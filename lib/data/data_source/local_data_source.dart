import 'package:mausam/main.dart';

abstract class LocationStorage {
  String getLocation();
  Future<bool> setLocation(String location);
  Future<bool> removeLocation();
}

class LocationStorageImpl extends LocationStorage {
  @override
  String getLocation() {
    String location = "error";
    if (sharedPreferences.containsKey("location")) {
      location = sharedPreferences.get("location") as String;
    }
    return location;
  }

  @override
  Future<bool> removeLocation() async {
    bool isRemoved = await sharedPreferences.remove("location");
    return isRemoved;
  }

  @override
  Future<bool> setLocation(String location) async {
    bool isSaved = await sharedPreferences.setString("location", location);
    return isSaved;
  }
}
