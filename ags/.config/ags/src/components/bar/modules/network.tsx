import { bind, derive } from "astal";
import Network from "gi://AstalNetwork";
import { getWifiIcon } from "../../../utils/icons";

export default function Connection() {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");
  const wired = bind(network, "wired");

  const connection = derive([wifi, wired], (wifi, wired) => {
    if (wired?.state === 100) {
      return { icon: "󰈀", tooltip: `Connected via ethernet` };
    } else if (wifi?.state === 100) {
      return { icon: getWifiIcon(wifi.strength), tooltip: `${wifi.ssid}` };
    } else {
      return { icon: "", tooltip: "No connection" };
    }
  });

  return (
    <box>
      {bind(connection, "").as((conn) => (
        <label label={conn.icon} tooltipText={conn.tooltip} />
      ))}
    </box>
  );
}
