import { bind } from "astal";
import Network from "gi://AstalNetwork";

export default function WiFi() {
    const { wifi } = Network.get_default();

    return (
        <icon
            tooltipText={bind(wifi, "ssid").as(String)}
            className="Wifi"
            icon={bind(wifi, "iconName")}
        />
    );
}
