import { Gtk } from "ags/gtk4";
import { exec } from "ags/process";

export function PowerButtons() {
  return (
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      spacing={6}
      halign={Gtk.Align.END}
      class="powerButtons"
    >
      <Logout />
      <Restart />
      <PowerOff />
    </box>
  );
}

function PowerOff() {
  return (
    <button
      class="powerOff"
      hexpand
      tooltipText="Power Off"
      onClicked={() => {
        exec("systemctl poweroff");
      }}
    >
      <image iconName="system-shutdown-symbolic" />
    </button>
  );
}

function Restart() {
  return (
    <button
      class="restart"
      hexpand
      tooltipText="Restart"
      onClicked={() => {
        exec("systemctl reboot");
      }}
    >
      <image iconName="system-reboot-symbolic" />
    </button>
  );
}

function Logout() {
  return (
    <button
      class="logout"
      hexpand
      tooltipText="Logout"
      onClicked={() => {
        exec("hyprctl dispatch exit");
      }}
    >
      <image iconName="system-log-out-symbolic" />
    </button>
  );
}
