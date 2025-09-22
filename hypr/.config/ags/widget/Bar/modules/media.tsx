import AstalMpris from "gi://AstalMpris";
import AstalApps from "gi://AstalApps";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { createBinding, createComputed, For, With } from "gnim";
import { Gtk } from "ags/gtk4";
import Pango from "gi://Pango";

export function Mpris() {
  const hypr = AstalHyprland.get_default();
  const mpris = AstalMpris.get_default();
  const apps = new AstalApps.Apps();

  const players = createBinding(mpris, "players");

  const filteredPlayers = createComputed((get) => {
    const all = get(players);
    return all.filter((p) => {
      const playbackStatus = get(createBinding(p, "playbackStatus"));
      const title = get(createBinding(p, "title"));
      return (
        playbackStatus === AstalMpris.PlaybackStatus.PLAYING ||
        playbackStatus === AstalMpris.PlaybackStatus.PAUSED ||
        title.length > 0
      );
    });
  });

  /**
   * We use the `createComputed` here because we want to recompute the active
   * player whenever the playback status or title of any player changes.
   *
   * `createBinding(mpris, "players")` would only update when the `players`
   * array itself changes (i.e., when players are added or removed), but not
   * when properties of the players change.
   *
   * By using `createComputed`, we ensure that the active player is always
   * up-to-date with the current playback status and title of all players.
   *  - `players`: the array itself (when players added/removed)
   *  - `playbackStatus` and `title`: properties of each player (when they
   *    change)
   *
   * This way, `activePlayer` will always resolve to the currently "best"
   * player (prefer playing otherwise fallback to the one with a title).
   *
   * TLDR; `createComputed` lets us derive a "reactive value" that responds to
   * changes in multiple dependencies.
   */
  const activePlayer = createComputed((get) => {
    const all = get(players);

    let p = all.find(
      (p) =>
        get(createBinding(p, "playbackStatus")) ===
        AstalMpris.PlaybackStatus.PLAYING,
    );
    if (p) return p;

    return all.find((p) => get(createBinding(p, "title")).length > 0);
  });

  filteredPlayers.as((p) => {
    if (p.length === 0) {
      return null;
    }
  });

  return (
    <menubutton class="Mpris" visible={filteredPlayers.as((p) => p.length > 0)}>
      <With value={activePlayer}>
        {(p) => {
          if (!p) return null;

          let [app] = apps.exact_query(p.entry);

          if (!app) {
            [app] = apps.exact_query(p.identity);
          }

          const cssClasses = createBinding(p, "playbackStatus").as((s) => [
            "indicator",
            s === AstalMpris.PlaybackStatus.PAUSED ? "paused" : "",
          ]);

          return (
            <box spacing={4} cssClasses={cssClasses}>
              <image iconName={app.iconName || app.wmClass} />
              {p.title ? (
                <label
                  label={createBinding(p, "title")}
                  ellipsize={Pango.EllipsizeMode.END}
                  maxWidthChars={20}
                />
              ) : (
                <label
                  label={createBinding(p, "identity")}
                  ellipsize={Pango.EllipsizeMode.END}
                  maxWidthChars={20}
                />
              )}
            </box>
          );
        }}
      </With>
      <popover class={"mediaPopover"}>
        <box
          orientation={Gtk.Orientation.VERTICAL}
          spacing={6}
          class="playersContainer"
          overflow={Gtk.Overflow.VISIBLE}
        >
          <For each={filteredPlayers}>
            {(player) => {
              let [app] = apps.exact_query(player.identity);

              if (!app) {
                [app] = apps.exact_query(player.entry);
              }

              return (
                <box
                  spacing={0}
                  class="playerEntry"
                  orientation={Gtk.Orientation.VERTICAL}
                >
                  <box orientation={Gtk.Orientation.HORIZONTAL} spacing={6}>
                    <Gtk.Frame
                      class="coverArt"
                      vexpand
                      halign={Gtk.Align.START}
                      valign={Gtk.Align.CENTER}
                    >
                      <image
                        file={createBinding(player, "coverArt")}
                        pixelSize={96}
                      />
                    </Gtk.Frame>
                    <box
                      orientation={Gtk.Orientation.VERTICAL}
                      hexpand
                      class={"playerControls"}
                      spacing={6}
                    >
                      <box
                        spacing={2}
                        orientation={Gtk.Orientation.VERTICAL}
                        halign={Gtk.Align.START}
                        valign={Gtk.Align.START}
                        hexpand
                        vexpand
                        class={"trackInfo"}
                      >
                        {player.title ? (
                          <label
                            xalign={0}
                            label={createBinding(player, "title")}
                            class="trackTitle"
                            css={"font-weight: bold;"}
                            ellipsize={Pango.EllipsizeMode.END}
                            maxWidthChars={24}
                            wrap
                          />
                        ) : (
                          <label
                            xalign={0}
                            label={createBinding(player, "identity")}
                            class="trackTitle"
                            css={"font-weight: bold;"}
                            ellipsize={Pango.EllipsizeMode.END}
                            maxWidthChars={24}
                            wrap
                          />
                        )}
                        <label
                          xalign={0}
                          label={createBinding(player, "artist").as((a) => a ? a : "")}
                          class="trackArtist"
                          ellipsize={Pango.EllipsizeMode.END}
                          maxWidthChars={20}
                          visible={createBinding(player, "artist")(Boolean)}
                        />
                      </box>

                      <box hexpand>
                        <box
                          hexpand
                          halign={Gtk.Align.START}
                          valign={Gtk.Align.START}
                          orientation={Gtk.Orientation.HORIZONTAL}
                          class={"playbackControls"}
                        >
                          {/* Previous */}
                          <button
                            onClicked={() => player.previous()}
                            visible={createBinding(player, "canGoPrevious")}
                          >
                            <image
                              iconName="media-seek-backward-symbolic"
                              pixelSize={24}
                            />
                          </button>

                          {/* Play/Pause*/}
                          <button
                            onClicked={() => player.play_pause()}
                            visible={createBinding(player, "canControl")}
                          >
                            <box>
                              <image
                                iconName="media-playback-start-symbolic"
                                visible={createBinding(
                                  player,
                                  "playbackStatus",
                                )(
                                  (s) =>
                                    s !== AstalMpris.PlaybackStatus.PLAYING,
                                )}
                                pixelSize={24}
                              />
                              <image
                                iconName="media-playback-pause-symbolic"
                                visible={createBinding(
                                  player,
                                  "playbackStatus",
                                )(
                                  (s) =>
                                    s === AstalMpris.PlaybackStatus.PLAYING,
                                )}
                                pixelSize={24}
                              />
                            </box>
                          </button>

                          {/* Next */}
                          <button
                            onClicked={() => player.next()}
                            visible={createBinding(player, "canGoNext")}
                          >
                            <image
                              iconName="media-seek-forward-symbolic"
                              pixelSize={24}
                            />
                          </button>
                        </box>

                        <box valign={Gtk.Align.END} halign={Gtk.Align.END}>
                          <image iconName={app.iconName || app.wmClass} />
                        </box>
                      </box>
                    </box>
                  </box>
                </box>
              );
            }}
          </For>
        </box>
      </popover>
    </menubutton>
  );
}
