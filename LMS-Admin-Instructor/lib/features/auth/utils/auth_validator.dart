String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final email = value.trim();
  if (email.length < 5) {
    return 'Email must be at least 5 characters';
  }
  if (email.length > 50) {
    return 'Email must not exceed 50 characters';
  }
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );
  if (!emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address (e.g., name@example.com)';
  }
  if (email.contains('..')) {
    return 'Email cannot contain consecutive dots';
  }
  if (email.startsWith('.') || email.endsWith('.')) {
    return 'Email cannot start or end with a dot';
  }
  final parts = email.split('@');
  if (parts.length != 2) {
    return 'Email must contain exactly one @ symbol';
  }
  final domain = parts[1];
  if (!domain.contains('.')) {
    return 'Email domain must contain a dot (e.g., .com)';
  }
  if (domain.startsWith('.') || domain.endsWith('.')) {
    return 'Email domain cannot start or end with a dot';
  }
  return null;
}

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'First name is required';
  }
  final firstName = value.trim();
  if (firstName.length < 2) {
    return 'First name must be at least 2 characters';
  }
  if (firstName.length > 30) {
    return 'First name must not exceed 30 characters';
  }
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(firstName)) {
    return 'First name can only contain letters and spaces';
  }
  if (firstName.startsWith(' ') || firstName.endsWith(' ')) {
    return 'First name cannot start or end with a space';
  }
  if (firstName.contains(RegExp(r'\s{2,}'))) {
    return 'First name cannot contain consecutive spaces';
  }
  return null;
}

String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Last name is required';
  }
  final lastName = value.trim();
  if (lastName.length < 2) {
    return 'Last name must be at least 2 characters';
  }
  if (lastName.length > 30) {
    return 'Last name must not exceed 30 characters';
  }
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(lastName)) {
    return 'Last name can only contain letters and spaces';
  }
  if (lastName.startsWith(' ') || lastName.endsWith(' ')) {
    return 'Last name cannot start or end with a space';
  }
  if (lastName.contains(RegExp(r'\s{2,}'))) {
    return 'Last name cannot contain consecutive spaces';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (value.length > 32) {
    return 'Password must not exceed 32 characters';
  }
  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,32}$',
  );
  if (!passwordRegex.hasMatch(value)) {
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }
    return 'Password must be 8-32 characters long';
  }
  return null;
}
