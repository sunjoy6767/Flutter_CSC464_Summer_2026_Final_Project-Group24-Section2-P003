/// Formats [amount] as Bangladeshi Taka, e.g. `formatBdt(4500)` -> "৳ 4,500".
///
/// Whole amounts are shown with no decimal places; fractional amounts show
/// exactly two. Digits are grouped in standard thousands (not lakh/crore)
/// groups to match the example format.
String formatBdt(num amount) {
  final isWhole = amount == amount.roundToDouble();
  final fixed = amount.toStringAsFixed(isWhole ? 0 : 2);
  final parts = fixed.split('.');

  final negative = parts[0].startsWith('-');
  final digits = negative ? parts[0].substring(1) : parts[0];

  final grouped = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i != 0 && (digits.length - i) % 3 == 0) {
      grouped.write(',');
    }
    grouped.write(digits[i]);
  }

  final wholePart = '${negative ? '-' : ''}$grouped';
  final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
  return '৳ $wholePart$decimalPart';
}
