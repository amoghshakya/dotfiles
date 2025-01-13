import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";
import GLib from "gi://GLib";

export default function FocusedClient() {
    const hypr = Hyprland.get_default();
    const focused = bind(hypr, "focusedClient");

    return (
        <box
            className="Focused"
            visible={focused.as(Boolean)}
        >
            {focused.as((client) => (
                client && <icon icon={client.class.toLowerCase()} />
            ))}
        </box>
    );
}
