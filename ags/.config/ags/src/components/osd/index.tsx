import { Gtk, Gdk, App, Astal } from "astal/gtk4";
import { visible, iconName, value } from "./helpers/osd";
import { setupOSDTriggers } from "../../events/osd_trigger";
import { bind } from "astal";

export default function OSDWindow(monitor: Gdk.Monitor) {
  setupOSDTriggers();
  return (
    <window
      visible={visible()}
      cssClasses={["OSDWindow"]}
      gdkmonitor={monitor}
      application={App}
      anchor={Astal.WindowAnchor.BOTTOM}
      layer={Astal.Layer.OVERLAY}
      name="osd-window"
      focusable={false}
    >
      <revealer
        revealChild={visible()}
        onLegacy={(self, _) => {
          if ((self.revealChild = false)) {
            self.parent.visible = false;
          }
        }}
        transitionType={Gtk.RevealerTransitionType.CROSSFADE}
      >
        <box cssClasses={["OSD"]} spacing={10} valign={Gtk.Align.CENTER}>
          <label cssClasses={["icon"]} label={bind(iconName)} />
          <levelbar
            widthRequest={140}
            value={bind(value)}
            valign={Gtk.Align.CENTER}
          />
        </box>
      </revealer>
    </window>
  );
}
