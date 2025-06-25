import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    reset: Boolean,
    resetKey: {type: Number, default: null}
  }
  static targets = ['reloadLink']

  // 他のタイマーが発動していたら何もしない
  startInterval() {
    if (!!this.resetKeyValue) return;
    this.resetKeyValue = setInterval(() => this.reloadLinkTarget.click(), 30000)
  }

  adjustInterval() {
    if (!!this.resetKeyValue) { clearInterval(this.resetKeyValue)}
    this.resetKeyValue = null;
    setTimeout(() => this.reloadLinkTarget.click(), this.adjustTime())
  }

  adjustTime() {
    const now = new Date()
    const milliSeconds = now.getMilliseconds()
    let sec = now.getSeconds()
    if (sec > 30) {
      sec -= 30
    }

    return (30 - sec) * 1000 - milliSeconds
  }
}
