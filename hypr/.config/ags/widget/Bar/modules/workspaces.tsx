import Hyprland from "gi://AstalHyprland";
import { createBinding, For } from "ags";
import { Gtk } from "ags/gtk4";
import { debounce } from "../../../utils/debouncer";

export function Workspaces() {
  const hypr = Hyprland.get_default();

  const workspaces = createBinding(hypr, "workspaces").as((ws) => {
    return ws.filter((w) => w.id >= 0).sort((a, b) => a.id - b.id);
  });

  const focusedId = createBinding(hypr, "focused_workspace").as((ws) => ws.id);

  const debounceDelay = 100;

  const moveWorkspace = (direction: "left" | "right") => {
    const current = hypr.focusedWorkspace;
    const workspaces = hypr.workspaces
      .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
      .sort((a, b) => a.id - b.id);

    const currentIndex = workspaces.findIndex((ws) => ws.id === current.id);
    if (currentIndex === -1) return;

    const nextIndex =
      direction === "left"
        ? (currentIndex - 1 + workspaces.length) % workspaces.length
        : (currentIndex + 1) % workspaces.length;

    const next = workspaces[nextIndex];
    next.focus();
  };

  const moveWorkspaceDebounced = debounce(
    (direction: "left" | "right") => moveWorkspace(direction),
    debounceDelay,
  );
  const handleScroll = (_c: any, dx: number, dy: number) => {
    if (Math.abs(dy) < 0.4) return false;

    const direction = dy > 0 ? "right" : "left";
    moveWorkspaceDebounced(direction);
  };

  return (
    <box
      class="Workspaces"
      spacing={1}
      $={(self: Gtk.Box) => {
        // Adding a scroll event controller
        const ctrl = Gtk.EventControllerScroll.new(
          Gtk.EventControllerScrollFlags.BOTH_AXES,
        );
        ctrl.connect("scroll", handleScroll);

        self.add_controller(ctrl);
      }}
    >
      <For each={workspaces}>
        {(ws) => {
          const cssClasses = focusedId.as((id) => [
            "workspace",
            id === ws.id ? "focused" : "",
          ]);
          return (
            <button
              onClicked={() => ws.focus()}
              cssClasses={cssClasses}
            ></button>
          );
        }}
      </For>
    </box>
  );
}
