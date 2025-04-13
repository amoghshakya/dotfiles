import Hyprland from "gi://AstalHyprland";
import { AstalIO, bind, timeout } from "astal";

export default function Workspaces() {
  const hypr = Hyprland.get_default();

  let scrollDebounce: AstalIO.Time | null = null;
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
    next?.focus();
  };

  let lastDirection: "left" | "right" | null = null;

  const onScroll = (_: any, dy: number) => {
    // helps with touchpad scrolling by ignoring small scrolls
    // prevents overscrolling
    if (Math.abs(dy) < 0.4) return; // noise filter

    const direction = dy > 0 ? "right" : "left";

    // avoid re-triggering debounce for same direction
    if (direction !== lastDirection) {
      lastDirection = direction;

      if (scrollDebounce) scrollDebounce.cancel();
      scrollDebounce = timeout(debounceDelay, () => {
        moveWorkspace(direction);
        lastDirection = null;
        scrollDebounce = null;
      });
    }
  };

  return (
    <box cssClasses={["Workspaces"]} onScroll={(_, dx, dy) => onScroll(_, dy)}>
      {bind(hypr, "workspaces").as((ws) => {
        const valid = ws
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
          .sort((a, b) => a.id - b.id);

        const maxId = Math.max(...valid.map((w) => w.id));

        // gna show empty workspaces as well
        const range = Array.from({ length: maxId }, (_, i) => i + 1); // 1 to max

        // GNOME like workspace indicator (an extra indicator)
        // const range = Array.from(
        //   { length: maxId < 10 ? maxId + 1 : maxId },
        //   (_, i) => i + 1,
        // ); // 1 to max + 1

        return range.map((id) => {
          const ws = valid.find((w) => w.id === id);
          if (id > maxId) return;
          const css = bind(hypr, "focusedWorkspace").as((fw) =>
            fw.id === id ? ["focused"] : [""],
          );
          return (
            <button cssClasses={css} onClicked={() => ws?.focus?.()}>
              {" "}
            </button>
          );
        });
      })}
    </box>
  );
}
