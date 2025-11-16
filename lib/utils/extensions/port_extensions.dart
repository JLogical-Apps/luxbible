import 'package:port/port.dart';

extension PortExtensions<T> on Port<T> {
  Future<PortSubmitResult<T>> submitIfNoErrors() async {
    if (portFieldByName.values.any((field) => field.error != null)) {
      return PortSubmitResult(data: null); // Indicates an error in the Port.
    }

    return await submit();
  }
}
