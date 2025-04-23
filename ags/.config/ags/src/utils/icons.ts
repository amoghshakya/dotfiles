export function getVolumeIcon(volume: number, muted = false): string {
  if (muted || volume === 0) return "󰝟";

  const icons = ["󰕿", "󰖀", "󰕾"];
  const level = Math.floor(volume * icons.length);
  return icons[level];
}

export function getWifiIcon(strength: number): string {
  if (strength >= 75) return "󰤨"; // strong
  if (strength >= 50) return "󰤥"; // good
  if (strength >= 25) return "󰤢"; // weak
  if (strength >= 1) return "󰤟"; // very weak
  return "󰤯"; // no signal
}

export function getBatteryIcon(
  percent: number,
  charging: boolean = false,
): string {
  const chargingIcons = ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"];
  const dischargingIcons = [
    "󰂎",
    "󰁺",
    "󰁻",
    "󰁼",
    "󰁽",
    "󰁾",
    "󰁿",
    "󰂀",
    "󰂁",
    "󰂂",
    "󰁹",
  ];

  // percent is a value between 0 and 1
  const normalized = Math.max(0, Math.min(1, percent)) * 100;
  const index = Math.min(Math.floor(normalized / 10), 10);

  return charging ? chargingIcons[index] : dischargingIcons[index];
}

export function getBrightnessIcon(brightness: number): string {
  const icons = ["󰃞", "󰃝", "󰃟", "󰃠"];
  // map the brightness value (0-1) to 4 levels
  const level = Math.floor(brightness * icons.length);

  return icons[level];
}
