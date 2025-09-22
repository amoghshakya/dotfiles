import AstalBluetooth from "gi://AstalBluetooth";
import { createBinding } from "gnim";

export function Bluetooth({ button: isButton = false }: { button?: boolean }) {
  const bt = AstalBluetooth.get_default();
  const powered = createBinding(bt, "isPowered");

  return (
    <box visible={powered}>
      {isButton ? (
        <button onClicked={() => bt.adapter.set_powered(!powered.get())}>
          <image iconName="bluetooth-active-symbolic" />
        </button>
      ) : (
        <image iconName="bluetooth-active-symbolic" />
      )}
    </box>
  );
}
