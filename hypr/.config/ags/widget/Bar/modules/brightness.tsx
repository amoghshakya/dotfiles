import { Gtk } from "ags/gtk4";
import Brightness from "../../../utils/brightness";
import { createBinding } from "gnim";
import { getBrightnessIcon } from "../../../utils/icons";

function BrightnessSlider() {
  const brightness = Brightness.get_default();
  const screen = createBinding(brightness, "screen");

  return (
    <slider
      min={0.01}
      value={screen}
      onChangeValue={(_self, _type, v) => {
        brightness.screen = v;
      }}
      tooltipText={"Test"}
      valuePos={Gtk.PositionType.RIGHT}
      inverted={false}
      hexpand
    />
  );
}

export function BrightnessControl() {
  const brightness = Brightness.get_default();
  const screen = createBinding(brightness, "screen").as((v) =>
    Math.min(3, Math.floor(v * 4)),
  );

  return (
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      class="brightnessControl"
      hexpand
    >
      <image
        file={screen.as((v) => `icons/brightness/${getBrightnessIcon(v)}`)}
      />
      <BrightnessSlider />
    </box>
  );
}
