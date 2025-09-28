bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

bool isValidUsername(String username) {
  if (username.isEmpty) return false;
  final regex = RegExp(r'^[a-zA-Z0-9._-]+(?: [a-zA-Z0-9._-]+)*$');
  return regex.hasMatch(username);
}


bool isValidDateOfBirth(String dob) {
  if (dob.isEmpty) return false;
  final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  if (!regex.hasMatch(dob)) return false;
  final parts = dob.split('-');
  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) return false;

  try {
    final date = DateTime(year, month, day);
    if (date.day != day || date.month != month || date.year != year) {
      return false;
    }

    return true;
  } catch (_) {
    return false;
  }
}

bool isValidSkills(String text) {
  if (text.trim().isEmpty) return false;
  final parts = text.split(',');
  final trimmedParts = parts.map((e) => e.trim()).toList();
  if (trimmedParts.any((p) => p.isEmpty)) return false;
  if (trimmedParts.isEmpty) return false;
  return true;
}