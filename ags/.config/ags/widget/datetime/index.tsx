import { GLib, Variable } from "astal";

export default function DateTime({ format = "%a, %b %d %I:%M %p" }) {
    const time = Variable<string>("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(format)!,
    );

    return (
        <label
            className="Time"
            onDestroy={() => time.drop()}
            label={time()}
        />
    );
}
