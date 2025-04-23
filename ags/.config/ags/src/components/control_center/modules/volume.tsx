import { bind, derive } from "astal";
import { Gtk } from "astal/gtk4";
import {
  volumeIcon,
  volume,
  mute,
  speaker,
  microphone,
  micMute,
  micIcon,
  micVolume,
} from "../../../utils/audio";

export default function VolumeControl() {
  return (
    <box
      vexpand
      hexpand
      orientation={Gtk.Orientation.VERTICAL}
      spacing={0}
      cssClasses={["volume-control", "section"]}
    >
      <box orientation={Gtk.Orientation.HORIZONTAL} spacing={0}>
        <button onClicked={() => (speaker.mute = !mute.get())}>
          <label cssClasses={["icon"]} label={bind(volumeIcon)} />
        </button>
        <box hexpand>
          <slider
            hexpand
            widthRequest={250}
            value={volume}
            onChangeValue={({ value }) => speaker.set_volume(value)}
            onScroll={(_self, _dx, dy) => {
              if (dy > 0) {
                speaker.volume = Math.min(speaker.volume + 0.05, 1);
              } else if (dy < 0) {
                speaker.volume = Math.max(speaker.volume - 0.05, 0);
              }
            }}
          />
        </box>
      </box>
      <box orientation={Gtk.Orientation.HORIZONTAL}>
        <button onClicked={() => (microphone.mute = !micMute.get())}>
          <label cssClasses={["icon"]} label={bind(micIcon)} />
        </button>
        <slider
          hexpand
          value={micVolume}
          stepper={true}
          onChangeValue={({ value }) => microphone.set_volume(value)}
        />
      </box>
    </box>
  );
}
