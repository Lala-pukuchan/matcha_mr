export function validatePassword(password: string): string {
  if (!password) {
    return "Password is required.";
  }
  if (password.length < 8) {
    return "Password length should be at least 8 characters.";
  }
  if (!/[A-Z]/.test(password)) {
    return "Password should have at least one uppercase letter.";
  }
  if (!/[a-z]/.test(password)) {
    return "Password should have at least one lowercase letter.";
  }
  if (!/[0-9]/.test(password)) {
    return "Password should have at least one digit.";
  }
  if (!/[^A-Za-z0-9]/.test(password)) {
    return "Password should have at least one special character (e.g., !, @, #, etc.).";
  }
  const commonWords = ["password", "123456", "qwerty", "abc123", "letmein", "motdepasse"];
  if (commonWords.includes(password.toLowerCase())) {
    return "Password should not be a common word.";
  }
  return "";
}

export function validateName(name: string, type: string) {
  if (!name) {
    return type + ":" + name + " is required.";
  }

  const trimmedName = name.trim();

  if (!trimmedName) {
    return type + ":" + name + " is required.";
  }

  if (trimmedName.length > 50) {
    return type + ":" + name + " must be less than 50 characters.";
  }

  if (type !== "username") {
    if (!/^[A-Za-z\s'-]+$/.test(trimmedName)) {
      return type + ":" + name + " contains invalid characters.";
    }
  }

  return "";
}

export function isValidLatitude(lat) {
  if (isFinite(lat) && Math.abs(lat) <= 90) {
    return "";
  } else {
    return "Latitude must be a number between -90 and 90.";
  }
}

export function isValidLongitude(lng) {
  if (isFinite(lng) && Math.abs(lng) <= 180) {
    return "";
  } else {
    return "Longitude must be a number between -180 and 180.";
  }
}
