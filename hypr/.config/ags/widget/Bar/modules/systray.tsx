import { Gtk } from "ags/gtk4";
import { Audio, Tray, Network, Power } from ".";
import { ControlCenter } from "./controlCenter";
import { Bluetooth } from "./bluetooth";

export function SysTray() {
  return (
    <box spacing={6} halign={Gtk.Align.FILL} hexpand class="SysTray">
      <Tray />
      <menubutton class="systemItems">
        <box spacing={8} halign={Gtk.Align.FILL}>
          <Bluetooth />
          <Network />
          <Audio />
          <Power />
        </box>
        <popover halign={Gtk.Align.END}>
          <ControlCenter />
        </popover>
      </menubutton>
    </box>
  );
}
