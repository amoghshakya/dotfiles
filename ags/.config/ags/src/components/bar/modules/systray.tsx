import Tray from "gi://AstalTray";
import { bind } from "astal";

export default function SysTray() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["SysTray"]}>
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
