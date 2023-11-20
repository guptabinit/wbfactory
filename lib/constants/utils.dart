
import 'nanoid.dart';

String generateInvoiceRef([int size = 15]) {
  final id = customAlphabet("abcdefghijklmnopqrstuvwxyz", size);

  return "TK-$id";
}
