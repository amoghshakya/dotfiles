import { Gtk, Gdk, App, Astal } from "astal/gtk4";
import { Variable, bind, timeout } from "astal";
import VolumeControl from "./modules/volume";

const visible = Variable(false);
let controlCenterWindow: Gtk.Window | null = null;

export function toggleControlCenter() {
  if (!controlCenterWindow) return;

  const newState = !visible.get();

  if (newState) {
    controlCenterWindow!.present();
    visible.set(true);
  } else {
    visible.set(false);
    timeout(250, () => {
      controlCenterWindow!.hide();
    });
  }
}

export default function ControlCenter(monitor: Gdk.Monitor) {
  return (
    <window
      setup={(self) => (controlCenterWindow = self)}
      visible
      focusable
      focusVisible
      focusOnClick
      canFocus
      canTarget
      cssClasses={["ControlCenter"]}
      gdkmonitor={monitor}
      application={App}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.TOP}
      keymode={Astal.Keymode.ON_DEMAND}
      onKeyPressed={(self, keyval, _keycode, _state) => {
        if (keyval === Gdk.KEY_Escape) {
          visible.set(false);
          timeout(250, () => {
            self.hide();
          });
        }
      }}
      onFocusLeave={(self) => {
        visible.set(false);
        timeout(250, () => {
          self.hide();
        });
      }}
    >
      <revealer
        revealChild={bind(visible)}
        transitionType={Gtk.RevealerTransitionType.CROSSFADE}
        transitionDuration={100}
        halign={Gtk.Align.END}
        valign={Gtk.Align.START}
      >
        <box
          cssClasses={["control-center"]}
          orientation={Gtk.Orientation.VERTICAL}
          spacing={5}
        >
          <VolumeControl />
        </box>
      </revealer>
    </window>
  );
}
