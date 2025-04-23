import { timeout, Variable } from "astal";

export interface NotificationData {
  title: string;
  message: string;
  icon?: string;
}

export const notification = new Variable<NotificationData | null>(null);

export function sendNotification(
  data: NotificationData,
  timeoutMs: number = 4000,
) {
  notification.set(data);

  timeout(timeoutMs, () => {
    notification.set(null);
  });
}
