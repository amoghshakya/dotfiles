import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget/Bar";
import { WifiPasswordPrompt } from "./widget/Bar/modules/network";

app.start({
  css: style,
  main() {
    WifiPasswordPrompt();
    app.get_monitors().map(Bar);
  },
});
