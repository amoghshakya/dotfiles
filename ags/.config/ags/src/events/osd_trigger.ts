import { iconName, showOSD } from "../components/osd/helpers/osd";
import Brightness from "../components/osd/helpers/brightness";
import { getBrightnessIcon } from "../utils/icons";
import { bind } from "astal";
import { volumeIcon, speaker } from "../utils/audio";

export function setupOSDTriggers() {
  const brightness = Brightness.get_default();

  const brightnessIcon = bind(brightness, "screen").as((screen) => {
    return getBrightnessIcon(screen);
  });

  brightness.connect("notify::screen", () => {
    showOSD(brightness.screen, brightnessIcon.get());
  });

  if (speaker) {
    speaker.connect("notify::volume", () =>
      showOSD(speaker.volume, volumeIcon.get()),
    );
    speaker.connect("notify::mute", () => iconName.set(volumeIcon.get()));
  }
}
