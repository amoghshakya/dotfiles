import { bind, derive } from "astal";
import Wp from "gi://AstalWp";
import { getVolumeIcon } from "../utils/icons";

export const speaker = Wp.get_default()?.get_default_speaker()!;
export const microphone = Wp.get_default()?.get_default_microphone()!;

export const volume = bind(speaker, "volume");
export const mute = bind(speaker, "mute");

export const volumeIcon = derive([volume, mute], (volume, mute) => {
  if (mute) {
    return "󰝟";
  }
  return getVolumeIcon(volume);
});

export const micVolume = bind(microphone, "volume");
export const micMute = bind(microphone, "mute");

export const micIcon = derive([micVolume, micMute], (volume, mute) => {
  if (mute) {
    return "󰍭";
  }
  return "󰍬";
});
