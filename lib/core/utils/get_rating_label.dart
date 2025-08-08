String getRatingLabel(double ratings) {
  if (ratings >= 4.8) return "Exceptional";
  if (ratings >= 4.5) return "Excellent";
  if (ratings >= 4.0) return "Very Good";
  if (ratings >= 3.5) return "Good";
  if (ratings >= 3.0) return "Average";
  return "Weak";
}
