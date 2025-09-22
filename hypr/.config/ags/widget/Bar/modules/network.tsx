import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { execAsync } from "ags/process";
import AstalNetwork from "gi://AstalNetwork";
import { createBinding, createComputed, createState, For, With } from "gnim";

const network = AstalNetwork.get_default();
const wifi = createBinding(network, "wifi");
const wired = createBinding(network, "wired");
// priority to show wired connection if available
const activeNetwork = createComputed((get) => {
  const w = get(wired);
  if (w && w.state !== AstalNetwork.DeviceState.UNAVAILABLE) return w;

  const wi = get(wifi);
  return wi;
});

const [selectedAp, setSelectedAp] =
  createState<AstalNetwork.AccessPoint | null>(null);

export function Network({ button: isButton = false }: { button?: boolean }) {
  return (
    <box visible={activeNetwork(Boolean)}>
      <With value={activeNetwork}>
        {(net) => {
          if (net) {
            if (activeNetwork instanceof AstalNetwork.Wired && isButton) {
              <image
                iconName={createBinding(net, "iconName")}
                tooltipText={createBinding(net, "state").as((s) =>
                  s === AstalNetwork.DeviceState.ACTIVATED
                    ? "Ethernet connected"
                    : "Ethernet disconnected",
                )}
              />;
            }

            if (isButton) {
              return (
                <button
                  onClicked={() => {
                    if (net instanceof AstalNetwork.Wifi) {
                      net.set_enabled(!net.enabled);
                    }
                  }}
                  cssClasses={createBinding(network.wifi, "enabled").as((e) => [
                    "toggleWifi",
                    e ? "" : "disabled",
                  ])}
                >
                  <image
                    iconName={createBinding(net, "iconName")}
                    tooltipText={
                      net instanceof AstalNetwork.Wifi
                        ? createBinding(net, "ssid")
                        : "Ethernet connected"
                    }
                  />
                </button>
              );
            }
            return (
              <image
                iconName={createBinding(net, "iconName")}
                tooltipText={
                  net instanceof AstalNetwork.Wifi
                    ? createBinding(net, "ssid")
                    : ""
                }
              />
            );
          }
        }}
      </With>
    </box>
  );
}

export function WifiPasswordPrompt() {
  const [password, setPassword] = createState("");

  return (
    <With value={selectedAp}>
      {(ap) =>
        ap && (
          <window
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            keymode={Astal.Keymode.EXCLUSIVE}
            title={`Connect to ${ap.ssid}`}
            application={app}
            name="PasswordPrompt"
            class="PasswordPrompt"
            defaultWidth={320}
            defaultHeight={150}
            modal
            focusable
            focusVisible
            onCloseRequest={(self) => self.close()}
            $={(self) => app.add_window(self)}
          >
            <box
              orientation={Gtk.Orientation.VERTICAL}
              spacing={12}
              halign={Gtk.Align.FILL}
              valign={Gtk.Align.CENTER}
              class="passwordPrompt"
            >
              <label
                label={`Connect to ${ap.ssid}`}
                css="font-weight: bold; font-size: 1rem;"
              />
              <label
                label="Enter the Wi-Fi password:"
                halign={Gtk.Align.START}
              />
              <entry
                placeholderText="Password"
                visibility={false}
                hexpand
                $={(self) => self.grab_focus()}
                onNotifyText={({ text }) => setPassword(text)}
              />
              <box
                orientation={Gtk.Orientation.HORIZONTAL}
                spacing={6}
                halign={Gtk.Align.FILL}
              >
                <button
                  onClicked={(_self) => app.toggle_window("PasswordPrompt")}
                  class="cancel"
                  focusable
                  hexpand
                >
                  Cancel
                </button>
                <button
                  onClicked={(_self) => {
                    try {
                      ap.activate(password.get(), null);
                      app.toggle_window("PasswordPrompt");
                      network.wifi.scan();
                    } catch (e) {
                      console.error("Failed to connect to Wi-Fi:", e);
                    }
                  }}
                  class="connect"
                  focusable
                  hexpand
                >
                  Connect
                </button>
              </box>
            </box>
          </window>
        )
      }
    </With>
  );
}

function WifiList() {
  const accessPoints = createBinding(network.wifi, "accessPoints").as((ap) =>
    // actually hide hidden networks and sort by strength
    ap.filter((ap) => ap.ssid).sort((a, b) => b.strength - a.strength),
  );

  const uniqueAPs = createComputed((get) => {
    const aps = get(accessPoints);
    const map: Record<string, (typeof aps)[0]> = {};

    for (const ap of aps) {
      if (!map[ap.ssid] || ap.strength > map[ap.ssid].strength) {
        map[ap.ssid] = ap;
      }
    }

    return Object.values(map);
  });

  return (
    <scrolledwindow
      maxContentHeight={800}
      vexpand
      hexpand
      vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
      heightRequest={200}
    >
      <box hexpand class="wifiList" orientation={Gtk.Orientation.VERTICAL}>
        <For each={uniqueAPs}>
          {(ap) => {
            return (
              <button
                onClicked={async () => {
                  if (ap.requiresPassword) {
                    const savedConnection = ap
                      .get_connections()
                      .find((conn) => conn.get_id() === ap.ssid);
                    if (savedConnection && !savedConnection.unsaved) {
                      await execAsync(`nmcli device wifi connect "${ap.ssid}"`)
                        .then()
                        .catch((err) => {
                          // TODO: Notify the user
                          console.error(err);
                          setSelectedAp(ap);
                          app.toggle_window("PasswordPrompt");
                        });
                    } else {
                      console.log("Prompting for password for", ap.ssid);
                      setSelectedAp(ap);
                      app.toggle_window("PasswordPrompt");
                    }
                  } else {
                    // open networks
                    await execAsync(`nmcli device wifi connect "${ap.ssid}"`)
                      .then()
                      .catch((err) => {
                        // TODO: Replace with some notification system
                        console.error(err);
                      });
                  }
                }}
                halign={Gtk.Align.FILL}
              >
                <box class="accessPoint" spacing={6} halign={Gtk.Align.FILL}>
                  <image iconName={createBinding(ap, "iconName")} />
                  <label label={ap.ssid} hexpand xalign={0} />
                  <image
                    iconName="system-lock-screen-symbolic"
                    visible={ap.requiresPassword}
                    pixelSize={10}
                  />
                </box>
              </button>
            );
          }}
        </For>
      </box>
    </scrolledwindow>
  );
}

export function WifiControls() {
  const [wifiListVisible, setListVisible] = createState(false);

  return (
    <box orientation={Gtk.Orientation.VERTICAL} class="wifiControls">
      <box orientation={Gtk.Orientation.HORIZONTAL} spacing={6}>
        <Network button />
        <box
          orientation={Gtk.Orientation.VERTICAL}
          spacing={0}
          halign={Gtk.Align.START}
          hexpand
        >
          <label label="Wi-Fi" hexpand xalign={0} css="font-weight: bold;" />
          <label
            label={createBinding(network.wifi, "ssid")}
            xalign={0}
            class="ssid"
          />
        </box>
        <button
          onClicked={() => {
            network.wifi.scan();
            setListVisible((prev) => !prev);
          }}
          cssClasses={wifiListVisible.as((v) => [
            "toggleList",
            v ? "expanded" : "",
          ])}
        >
          <image iconName="go-next-symbolic" />
        </button>
      </box>
      <revealer
        revealChild={wifiListVisible}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        halign={Gtk.Align.FILL}
        hexpand
      >
        <WifiList />
      </revealer>
    </box>
  );
}
