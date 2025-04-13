import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./src/components/bar";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
  },
});
