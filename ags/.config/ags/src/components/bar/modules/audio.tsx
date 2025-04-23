import { bind } from "astal";
import { speaker as output, volumeIcon } from "../../../utils/audio";

export default function Audio() {
  return (
    <box cssClasses={["Audio"]}>
      {bind(volumeIcon, "").as((icon) => (
        <label
          cssClasses={["icon"]}
          label={icon}
          tooltipText={output.volume.toFixed(2) * 100 + "%"}
          onScroll={(_self, _dx, dy) => {
            if (dy > 0) {
              output.volume = Math.min(output.volume + 0.05, 1);
            } else if (dy < 0) {
              output.volume = Math.max(output.volume - 0.05, 0);
            }
          }}
        />
      ))}
    </box>
  );
}
