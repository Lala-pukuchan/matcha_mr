export function validatePassword(password: string) {
  if (!password) {
    return "Password is required.";
  }
  if (password.length < 4) {
    return "Password length should be more than 4.";
  } else if (!/[A-Z]/.test(password)) {
    return "Password should have at least one capital letter.";
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
    return ""
  } else {
    return "Latitude must be a number between -90 and 90."
  }
}

export function isValidLongitude(lng) {
  if (isFinite(lng) && Math.abs(lng) <= 180) {
    return ""
  } else {
    return "Longitude must be a number between -180 and 180."
  }
}