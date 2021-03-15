String numberFormatter(num) {
  if (num == 0.0) {
    return "-";
  } else if (num > 999 && num < 99999) {
    return "\$${(num / 1000).toStringAsFixed(1)} K";
  } else if (num > 99999 && num < 999999) {
    return "\$${(num / 1000).toStringAsFixed(0)} K";
  } else if (num > 999999 && num < 999999999) {
    return "\$${(num / 1000000).toStringAsFixed(2)} M";
  } else if (num > 999999999) {
    return "\$${(num / 1000000000).toStringAsFixed(2)} B";
  } else if (num > 999999999999) {
    return "\$${(num / 1000000000000).toStringAsFixed(2)} T";
  } else {
    return num.toString();
  }
}

String balanceFormatter(num) {
  if(num > 1000) {
    return num.toStringAsFixed(4);
  } else {
    return num.toStringAsFixed(8);
  }
}