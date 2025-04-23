import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Workspaces, DateTime, SysTray, Media, Notifications } from "./modules";
import VolumeControl from "../control_center/modules/volume";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <box halign={Gtk.Align.START}>
          <Workspaces />
        </box>
        <box hexpand halign={Gtk.Align.CENTER}>
          <Media />
        </box>
        <box halign={Gtk.Align.END} spacing={0}>
          <SysTray />
          <DateTime />
          <Notifications />
        </box>
      </centerbox>
    </window>
  );
}
