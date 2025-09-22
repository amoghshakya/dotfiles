import { Gtk } from "ags/gtk4";
import AstalPowerProfiles from "gi://AstalPowerProfiles";
import { createBinding, createState } from "gnim";

function titleCase(str: string): string {
  str = str.replace("-", " ");
  const words = str.split(" ");
  for (let i = 0; i < words.length; i++) {
    words[i] = words[i].charAt(0).toUpperCase() + words[i].slice(1);
  }
  return words.join(" ");
}

function ProfilesList() {
  const powerProfiles = AstalPowerProfiles.get_default();
  const availableProfiles = powerProfiles.get_profiles();

  return (
    <box hexpand class="profilesList" orientation={Gtk.Orientation.VERTICAL}>
      {availableProfiles.map((p) => (
        <button
          onClicked={() => {
            console.log(powerProfiles.iconName);
            powerProfiles.set_active_profile(p.profile);
          }}
          hexpand
        >
          <box class="profileItem" hexpand spacing={6} halign={Gtk.Align.FILL}>
            <image iconName={`power-profile-${p.profile}-symbolic`} />

            <label label={titleCase(p.profile)} />
          </box>
        </button>
      ))}
    </box>
  );
}

export function PowerProfilesControl() {
  const [profileListVisible, setProfileListVisible] = createState(false);
  const powerProfiles = AstalPowerProfiles.get_default();

  const activeProfile = createBinding(powerProfiles, "activeProfile").as((p) =>
    titleCase(p),
  );

  return (
    <box orientation={Gtk.Orientation.VERTICAL} class="powerProfilesControl">
      <box orientation={Gtk.Orientation.HORIZONTAL} spacing={6}>
        <button>
          <image
            iconName={createBinding(powerProfiles, "iconName")}
            class="profileIcon"
          />
        </button>
        <box
          orientation={Gtk.Orientation.VERTICAL}
          spacing={0}
          halign={Gtk.Align.START}
          hexpand
        >
          <label
            label="Power Profile"
            hexpand
            xalign={0}
            css="font-weight: bold;"
          />
          <label label={activeProfile} xalign={0} class="powerProfile" />
        </box>
        <button
          onClicked={() => setProfileListVisible((v) => !v)}
          cssClasses={profileListVisible.as((v) => [
            "toggleList",
            v ? "expanded" : "",
          ])}
        >
          <image iconName="go-next-symbolic" />
        </button>
      </box>
      <revealer
        revealChild={profileListVisible}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        halign={Gtk.Align.FILL}
        hexpand
      >
        <ProfilesList />
      </revealer>
    </box>
  );
}
