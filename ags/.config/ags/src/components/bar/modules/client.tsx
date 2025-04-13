import Hyprland from "gi://AstalHyprland";
import { bind, GLib } from "astal";
import Gio from "gi://Gio";

export default function FocusedClient() {
  function getAppName(pid: number) {
    try {
      const [ok, out] = GLib.spawn_command_line_sync(`ps -p ${pid} -o comm=`);
      if (!ok || !out) return "";

      const binary = String.fromCharCode(...out).trim();

      const appInfo = Gio.AppInfo.get_all().find((app) => {
        const appPath = app.get_executable();
        if (!appPath) return false;
        const appBinary = GLib.path_get_basename(appPath);
        return appBinary === binary;
      });

      if (appInfo) {
        if (appInfo.get_display_name()) {
          return appInfo.get_display_name();
        }
        return appInfo.get_name();
      }
    } catch (e) {
      return;
    }
  }
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedClient");

  return (
    <box className="Focused" visible={focused.as(Boolean)}>
      {focused.as(
        (client) => client && <label label={getAppName(client.pid)} />,
      )}
    </box>
  );
}
