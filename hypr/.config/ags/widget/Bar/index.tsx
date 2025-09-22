import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { Clock } from "./modules/datetime";
import { Workspaces } from "./modules/workspaces";
import { SysTray } from "./modules/systray";
import { ActiveApp } from "./modules/activeApp";
import { Mpris } from "./modules/media";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox halign={Gtk.Align.FILL}>
        <box halign={Gtk.Align.START} $type="start" spacing={6}>
          {/* Kinda need to put it in a box because re-rendering puts it at the end otherwise */}
          <box>
            <ActiveApp />
          </box>
          <Workspaces />
        </box>
        <box halign={Gtk.Align.CENTER} $type="center">
          <Clock />
        </box>
        <box halign={Gtk.Align.END} $type="end">
          <Mpris />
          <SysTray />
        </box>
      </centerbox>
    </window>
  );
}
