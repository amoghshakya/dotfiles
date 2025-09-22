import { timeout, Timer } from "ags/time"

export function debounce<T extends (...args: any[]) => void>(
  fn: T,
  delay: number,
) {
  let timer: Timer | null = null

  return (...args: Parameters<T>) => {
    if (timer) timer.cancel()

    timer = timeout(delay, () => {
      fn(...args)
      timer = null
    })
  }
}

export function throttle<T extends (...args: any[]) => void>(
  fn: T,
  limit: number,
) {
  let inThrottle: boolean = false
  let lastArgs: Parameters<T> | null = null

  return (...args: Parameters<T>) => {
    if (!inThrottle) {
      fn(...args)
      inThrottle = true
      timeout(limit, () => {
        inThrottle = false
        if (lastArgs) {
          fn(...lastArgs)
          lastArgs = null
        }
      })
    } else {
      lastArgs = args
    }
  }
}
