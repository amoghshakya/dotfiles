import Wp from "gi://AstalWp";
import { createBinding, createComputed, createState } from "gnim";
import { Gtk } from "ags/gtk4";
import { For } from "gnim";
import { getVolumeIcon } from "../../../utils/icons";
import Pango from "gi://Pango?version=1.0";

const wp = Wp.get_default();

const speaker = wp.default_speaker;

const volume = createBinding(speaker, "volume").as(
  (v) => (v * 100).toFixed(0) + "%",
);
const speakerMuted = createBinding(speaker, "mute").as((i) => i);
const speakerIcon = createComputed((get) => {
  const v = get(createBinding(speaker, "volume"));
  if (get(speakerMuted) || v === 0)
    return `icons/volume/${getVolumeIcon(0, true)}`;

  const vol = Math.min(2, Math.floor(v * 3));
  return `icons/volume/${getVolumeIcon(vol, false)}`;
});

// Audio widget
export function Audio({ button: isButton = false }: { button?: boolean }) {
  return (
    <box>
      {isButton ? (
        <button
          onClicked={() => {
            speaker.set_mute(!speakerMuted.get());
          }}
          cssClasses={createBinding(speaker, "mute").as((m) => [
            "toggleMute",
            m ? "muted" : "",
          ])}
        >
          <image file={speakerIcon} tooltipText={volume} />
        </button>
      ) : (
        <image file={speakerIcon} tooltipText={volume} />
      )}
    </box>
  );
}

export function Microphone({ button: isButton = false }: { button?: boolean }) {
  const microphone = wp.default_microphone;
  const micVolume = createBinding(microphone, "volume").as(
    (v) => (v * 100).toFixed(0) + "%",
  );
  const micIcon = createBinding(microphone, "volumeIcon").as((i) => i);
  const micMuted = createBinding(microphone, "mute").as((i) => i);

  return (
    <box>
      {isButton ? (
        <button
          onClicked={() => {
            microphone.set_mute(!micMuted.get());
          }}
          cssClasses={micMuted.as((m) => ["toggleMute", m ? "muted" : ""])}
        >
          <image iconName={micIcon} tooltipText={micVolume} />
        </button>
      ) : (
        <image iconName={micIcon} tooltipText={micVolume} />
      )}
    </box>
  );
}

export function SpeakerVolumeSlider() {
  const wp = Wp.get_default();
  const speaker = wp.default_speaker;

  const volume = createBinding(speaker, "volume");

  return (
    <slider
      value={volume}
      onChangeValue={(_self, _type, v) => {
        speaker.set_volume(v);
      }}
      tooltipText={createBinding(speaker, "volume").as(
        (v) => (v * 100).toFixed(0) + "%",
      )}
      valuePos={Gtk.PositionType.RIGHT}
      inverted={false}
      hexpand
    />
  );
}

export function MicrophoneVolumeSlider() {
  const wp = Wp.get_default();
  const microphone = wp.default_microphone;

  const volume = createBinding(microphone, "volume");
  const micMuted = createBinding(microphone, "mute").as((i) => i);

  return (
    <slider
      value={volume}
      onChangeValue={(_self, _type, v) => {
        microphone.set_volume(v);
      }}
      tooltipText={createBinding(microphone, "volume").as(
        (v) => (v * 100).toFixed(0) + "%",
      )}
      valuePos={Gtk.PositionType.RIGHT}
      inverted={false}
      hexpand
    />
  );
}

function AudioList({ type }: { type: "input" | "output" }) {
  const get = type === "input" ? "microphones" : "speakers";

  const wp = Wp.get_default();

  const devices = createBinding(wp.audio, get).as((ep) => {
    // filter out easy effects sinks
    return ep.filter((ep) => !ep.description.toLowerCase().includes("effects"));
    // return ep
  });

  const routes = createComputed((get) => {
    return get(devices).flatMap((d) => {
      const rs = get(createBinding(d, "routes"));
      return rs.map((r) => ({ d, route: r }));
    });
  });

  return (
    <box
      orientation={Gtk.Orientation.VERTICAL}
      class="deviceList"
      halign={Gtk.Align.FILL}
      hexpand
    >
      <For each={routes} id={({ d, route }) => d.id + route.index}>
        {({ d, route }) => {
          const cssClasses = createBinding(d, "route").as((r) => [
            "route",
            r === route ? "active" : "",
          ]);
          return (
            <button
              onClicked={() => d.set_route(route)}
              halign={Gtk.Align.FILL}
            >
              <box cssClasses={cssClasses} spacing={6} halign={Gtk.Align.FILL}>
                <image iconName={createBinding(d, "volumeIcon")} />
                <label
                  label={route.description}
                  ellipsize={Pango.EllipsizeMode.END}
                />
              </box>
            </button>
          );
        }}
      </For>
    </box>
  );
}

export function AudioControls() {
  // audio output list
  const [outListVisible, setOutListVisible] = createState(false);
  // audio input list
  const [inListVisible, setInListVisible] = createState(false);

  return (
    <box spacing={6} orientation={Gtk.Orientation.VERTICAL}>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <box class="audioControls">
          <Audio button />
          <SpeakerVolumeSlider />
          <button
            onClicked={() => setOutListVisible((prev) => !prev)}
            cssClasses={outListVisible.as((v) => [
              "toggleList",
              v ? "expanded" : "",
            ])}
          >
            <image iconName="go-next-symbolic" />
          </button>
        </box>

        <revealer
          revealChild={outListVisible}
          transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
          halign={Gtk.Align.FILL}
          hexpand
        >
          <AudioList type="output" />
        </revealer>
      </box>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <box class="audioControls">
          <Microphone button />
          <MicrophoneVolumeSlider />
          <button
            onClicked={() => setInListVisible((prev) => !prev)}
            cssClasses={inListVisible.as((v) => [
              "toggleList",
              v ? "expanded" : "",
            ])}
          >
            <image iconName="go-next-symbolic" />
          </button>
        </box>

        <revealer
          revealChild={inListVisible}
          transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
          halign={Gtk.Align.FILL}
          hexpand
        >
          <AudioList type="input" />
        </revealer>
      </box>
    </box>
  );
}
