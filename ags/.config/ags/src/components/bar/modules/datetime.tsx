import { Variable, GLib } from "astal";

export default function DateTime({ format = "%b %e\t %I:%M %p" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <box cssClasses={["Time"]}>
      <label onDestroy={() => time.drop()} label={time()} />
    </box>
  );
}
