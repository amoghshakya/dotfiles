import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import Workspaces from "./hyprland/workspaces";
import DateTime from "./datetime";
import WiFi from "./network";
import AudioSlider from "./audio";
import BatteryLevel from "./battery";
import FocusedClient from "./hyprland/activeClient";

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return (
        <window
            className="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT}
            application={App}
        >
            <centerbox>
                <box hexpand halign={Gtk.Align.START} spacing={10}>
                    <FocusedClient />
                    <Workspaces />
                </box>

                <box>
                    <DateTime />
                </box>
                <box hexpand halign={Gtk.Align.END} spacing={10}>
                    <WiFi />
                    <AudioSlider />
                    <BatteryLevel />
                    </box>
            </centerbox>
        </window>
    );
}
