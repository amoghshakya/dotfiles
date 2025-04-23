import { timeout } from "astal/time";
import Variable from "astal/variable";

export const visible = Variable(false);
export const iconName = Variable("");
export const value = Variable(0);

let counter = 0;

export function showOSD(val: number, icon: string, show: boolean = true) {
  visible.set(show);
  iconName.set(icon);
  value.set(val);

  counter++;
  timeout(2000, () => {
    counter--;
    if (counter === 0) visible.set(false);
  });
}
