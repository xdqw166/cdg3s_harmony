import { emitter } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN = 0x0005

export function setWindowSystemBarColor(color: string) {
  hilog.debug(DOMAIN, 'winSys', `Set win sys bar color to ${color}`)
  emitter.emit('changeStatusBar', {
    data: {
      contentColor: color
    }
  })
}

export function showToast(message: string, uiContest: UIContext) {
  try {
    uiContest.getPromptAction().showToast({ message })
  } catch (error) {
    hilog.error(DOMAIN, 'winSys', error)
  }
}