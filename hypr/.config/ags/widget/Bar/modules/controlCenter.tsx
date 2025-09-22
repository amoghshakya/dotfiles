import { Gtk } from "ags/gtk4";
import { AudioControls } from "./audio";
import { BrightnessControl } from "./brightness";
import { WifiControls } from "./network";
import { PowerProfilesControl } from "./powerprofiles";
import AstalPowerProfiles from "gi://AstalPowerProfiles";
import { PowerButtons } from "./powerbuttons";

const profile = AstalPowerProfiles.get_default();

export function ControlCenter() {
  return (
    <box
      orientation={Gtk.Orientation.VERTICAL}
      class="controlCenter"
      widthRequest={300}
      spacing={12}
    >
      <box class="section">
        <AudioControls />
      </box>
      <box class="section">
        <BrightnessControl />
      </box>
      <box class="section">
        <WifiControls />
      </box>
      <box class="section" visible={profile && !!profile.active_profile}>
        <PowerProfilesControl />
      </box>

      <PowerButtons />
    </box>
  );
}
