import Battery from "gi://AstalBattery";
import { bind, derive } from "astal";
import { getBatteryIcon } from "../../../utils/icons";

export default function BatteryLevel() {
  const bat = Battery.get_default();

  const percent = bind(bat, "percentage");
  const charging = bind(bat, "charging");

  const icon = derive([percent, charging], (percent, charging) => {
    if (!bat.isPresent) return "";
    if (charging) return getBatteryIcon(percent, true);
    return getBatteryIcon(percent, false);
  });

  return (
    <box cssClasses={["Battery"]} visible={bind(bat, "isPresent")}>
      {bind(bat, "percentage").as((percent) => (
        <label
          cssClasses={["icon", percent < 0.2 ? "low-battery" : ""]}
          label={icon.get()}
          tooltipText={`${bat.charging ? "Charging" : "Discharging"} - ${percent * 100}%`}
        />
      ))}
    </box>
  );
}
