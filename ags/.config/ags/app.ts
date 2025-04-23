import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./src/components/bar";
import OSDWindow from "./src/components/osd";
import ControlCenter from "./src/components/control_center";

App.start({
  css: style,
  instanceName: "astal",
  main() {
    App.get_monitors().forEach((monitor) => {
      Bar(monitor);
      OSDWindow(monitor);
      ControlCenter(monitor);
    });
  },
});
