export function validatePassword(password: string) {
  if (password.length < 4) {
    return "Password length should be more than 4.";
  } else if (!/[A-Z]/.test(password)) {
    return "Password should have at least one capital letter.";
  }
  return "";
}

export function validateFirstName(firstName) {
  const trimmedName = firstName.trim();

  if (!trimmedName) {
    return "First name is required.";
  }

  if (trimmedName.length > 50) {
    return "First name must be less than 50 characters.";
  }

  if (!/^[A-Za-z\s'-]+$/.test(trimmedName)) {
    return "First name contains invalid characters.";
  }

  return "";
}
