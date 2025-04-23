import { Variable, bind } from "astal";

const showPanel = Variable(false);

export default function Notifications() {
  // just an indicator

  return (
    <button
      cssClasses={["Notifications"]}
      onClicked={() => showPanel.set(!showPanel.get())}
      onFocusLeave={() => showPanel.set(false)}
    >
      <image iconName="preferences-system-notifications-symbolic" />
    </button>
  );
}
