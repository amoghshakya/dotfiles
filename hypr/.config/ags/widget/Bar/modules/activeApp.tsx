import Hyprland from "gi://AstalHyprland";
import AstalApps from "gi://AstalApps";
import { Gtk } from "ags/gtk4";
import { createBinding, With } from "gnim";

export function ActiveApp() {
  const hypr = Hyprland.get_default();
  const apps = new AstalApps.Apps();
  const client = createBinding(hypr, "focused_client");

  return (
    <With value={client}>
      {(c) => {
        if (!c) {
          return <image class="ActiveApp" file="icons/arch.svg" />;
        }

        const [app] = apps.exact_query(c.class);

        return <image iconName={app?.iconName || c.class} class="ActiveApp" />;
      }}
    </With>
  );
}
