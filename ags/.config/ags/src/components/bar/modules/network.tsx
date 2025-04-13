import { bind, derive } from "astal";
import Network from "gi://AstalNetwork";

export default function Connection() {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");
  const wired = bind(network, "wired");

  return (
    <box visible={wifi.as(Boolean)}>
      {wifi.as(
        (wifi) =>
          wifi && (
            <image
              tooltipText={bind(wifi, "ssid")}
              cssClasses={["Wifi"]}
              iconName={bind(wifi, "iconName")}
            />
          ),
      )}
    </box>
  );
}
