import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

export default function Workspaces() {
    const hypr = Hyprland.get_default();

    return (
        <box className="Workspaces">
            {bind(hypr, "workspaces").as((wss) =>
                wss
                    .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
                    .sort((a, b) => a.id - b.id)
                    .map((ws) => (
                        <button
                            className={bind(hypr, "focusedWorkspace").as((fw) =>
                                ws === fw ? "focused" : ""
                            )}
                            onClicked={() => ws.focus()}
                            valign={Gtk.Align.CENTER}
                        >
                        </button>
                    ))
            )}
        </box>
    );
}
