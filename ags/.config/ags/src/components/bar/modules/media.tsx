import Mpris from "gi://AstalMpris";
import { bind } from "astal";
import { Gtk } from "astal/gtk4";

export default function Media() {
  // Playback status
  // 0 = playing
  // 1 = paused
  // 2 = stopped
  const spotify = Mpris.Player.new("spotify");

  return (
    <box
      cssClasses={["Media"]}
      setup={(self) => {
        self.set_size_request(50, -1);
        self.hexpand = false;
        self.halign = Gtk.Align.START;
      }}
    >
      {bind(spotify, "playbackStatus").as((status) =>
        status !== 2 ? (
          <Player player={spotify} icon="spotify" />
        ) : (
          <>
            <FallbackMedia />
          </>
        ),
      )}
    </box>
  );
}

function FallbackMedia() {
  const mpris = Mpris.get_default();
  if (!mpris) return <></>;

  const players = mpris.players;
  if (players.length === 0) return <></>;

  const player = players[0];

  return (
    <box>
      {bind(player, "playbackStatus").as((status) => {
        if (status === 2) {
          return <></>;
        }

        return <Player player={player} truncate />;
      })}
    </box>
  );
}

function Player({
  player,
  icon,
  truncate = false,
}: {
  player: Mpris.Player;
  icon?: string;
  truncate?: boolean;
}) {
  const css = bind(player, "playbackStatus").as((state) => {
    if (state === 0) {
      return ["Toggle", "Playing"];
    } else if (state === 1) {
      return ["Toggle", "Paused"];
    } else {
      return ["Toggle"];
    }
  });

  const iconStatus = bind(player, "playbackStatus").as((state) => {
    if (state === 0) {
      return "media-playback-pause";
    } else if (state === 1) {
      return "media-playback-start";
    } else {
      return "";
    }
  });
  return (
    <button cssClasses={css} onClicked={() => player.play_pause()}>
      <box spacing={5}>
        <image iconName={icon ?? iconStatus} />
        {truncate ? (
          <label
            xalign={0}
            wrap={false}
            ellipsize={3}
            maxWidthChars={25}
            label={bind(player, "metadata").as(() => `${player.title}`)}
          />
        ) : (
          <label
            xalign={0}
            wrap={false}
            ellipsize={3}
            maxWidthChars={25}
            label={bind(player, "metadata").as(
              () => `${player.artist ?? ""} - ${player.title}`,
            )}
          />
        )}
      </box>
    </button>
  );
}
