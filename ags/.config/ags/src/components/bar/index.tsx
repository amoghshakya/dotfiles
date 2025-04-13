import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable } from "astal";
import { Workspaces, DateTime, SysTray, Connection, Media } from "./modules";

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
        <box hexpand halign={Gtk.Align.START}>
          <Workspaces />
          <Media />
        </box>
        <box hexpand halign={Gtk.Align.CENTER}>
          <DateTime />
        </box>
        <box hexpand halign={Gtk.Align.END}>
          {/* <SysTray /> */}
          <Connection />
        </box>
      </centerbox>
    </window>
  );
}
