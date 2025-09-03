
import 'package:intl/intl.dart';

String formatDate(String? iso) {
if (iso == null || iso.isEmpty) return '-';
try {
final d = DateTime.parse(iso);
return DateFormat('dd/MM/yyyy').format(d);
} catch (_) {
return iso;
}
}