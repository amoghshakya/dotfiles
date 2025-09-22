import Battery from "gi://AstalBattery";
import { createBinding } from "gnim";

export function Power() {
  const bat = Battery.get_default();

  const icon = createBinding(bat, "iconName").as((i) => i);

  return (
    <box>
      <image
        iconName={icon}
        tooltipText={createBinding(bat, "percentage").as(
          (p) => (p * 100).toFixed(0) + "%",
        )}
      />
    </box>
  );
}
