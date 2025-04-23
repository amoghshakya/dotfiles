import Tray from "gi://AstalTray";
import { bind } from "astal";
import BatteryLevel from "./battery";
import Connection from "./network";
import Audio from "./audio";
import { toggleControlCenter } from "../../control_center";
import { visible } from "../../osd/helpers/osd";

export default function SystemTray() {
  return (
    <button
      onClicked={() => {
        toggleControlCenter();
      }}
    >
      <box hexpand spacing={5} cssClasses={["System"]} setup={(box) => {}}>
        <BatteryLevel />
        <Connection />
        <Audio />
      </box>
    </button>
  );
}

export function AppIndicator() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["AppIndicator"]} spacing={10}>
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <menubutton
            tooltipMarkup={bind(item, "tooltipMarkup")}
            menuModel={bind(item, "menuModel")}
          >
            <image gicon={bind(item, "gicon")} />
          </menubutton>
        )),
      )}
    </box>
  );
}
