import 'package:pelatihan_dasar_flutter/model/DetailViewModel.dart';

class VisitQuery {
  static String drop() {
    return "DROP TABLE tbl_visit";
  }

  static String create() {
    return "CREATE TABLE tbl_visit " +
        " (customer_id INTEGER PRIMARY KEY, " +
        " photo TEXT," +
        " is_stay_in_current_base bit," +
        " new_address VARCHAR(500)," +
        " reason VARCHAR(500)," +
        " lat float," +
        " lon float)";
  }

  static String insert(int customerId, DetailViewModel data) {
    return "INSERT INTO tbl_visit " +
        "values ( " +
        "$customerId," +
        "'${data.photo}'," +
        "${data.isStyInCurrentBase == true ? 1 : 0}," +
        "'${data.newAddress}'," +
        "'${data.reason}'," +
        "${data.lat}," +
        "${data.long}" +
        " )";
  }

  static String update(int customerId, DetailViewModel data) {
    return "UPDATE tbl_visit set " +
        "photo = '${data.photo}', " +
        "is_stay_in_current_base = '${data.isStyInCurrentBase == true ? 1 : 0}', " +
        "new_address = '${data.newAddress}', " +
        "reason = '${data.reason}', " +
        "lat = '${data.lat}', " +
        "lon = '${data.long}' " +
        "WHERE customer_id = $customerId";
  }

  static String getByCustomerId(int customerId) {
    return "SELECT * FROM tbl_visit WHERE customer_id = $customerId";
  }

  static String deleteByCustomerId(int customerId) {
    return "DELETE tbl_visit WHERE customer_id = $customerId";
  }
}
