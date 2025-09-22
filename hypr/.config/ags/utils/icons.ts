export function getBrightnessIcon(brightness: number): string {
  const icons = ["off", "low", "medium", "high"];

  return `display-brightness-${icons[brightness]}-symbolic.svg`;
}

export function getVolumeIcon(volume: number, isMuted: boolean): string {
  const icons = ["low", "medium", "high"];
  const str = `audio-volume`;
  if (isMuted) return `${str}-muted-symbolic.svg`;

  return `${str}-${icons[volume]}-symbolic.svg`;
}
