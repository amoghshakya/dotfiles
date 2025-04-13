import Mpris from "gi://AstalMpris";
import { bind } from "astal";
import { Gtk, Gdk } from "astal/gtk4";

export default function Media() {
  const mpris = Mpris.get_default();

  return (
    <box cssClasses={["Media"]}>
      <label label="hello" />
    </box>
  );
}
