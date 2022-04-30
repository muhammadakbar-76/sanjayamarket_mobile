import 'package:intl/intl.dart';

String formatter(num value) {
  return NumberFormat.currency(
    locale: "id_id",
    symbol: "IDR ",
    decimalDigits: 0,
  ).format(value);
}
