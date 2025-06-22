import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    reset: Boolean,
    intervalMsec: Number,
    resetKey: {type: Number, default: null}
  }
  static targets = ['reloadLink', 'debugTool']

  connect() {
    const url = new URL(location.href)
    if (url.searchParams.get('debug')) {
      this.debugToolTargets.forEach((el) => {el.className = 'inline'})
    }
  }

  // 他のタイマーが発動していたら何もしない
  startInterval() {
    if (!!this.resetKeyValue) return;
    this.resetKeyValue = setInterval(() => this.reloadLinkTarget.click(), this.intervalMsecValue)
  }

  adjustInterval(adjustMilliseconds) {
    if (!!this.resetKeyValue) { clearInterval(this.resetKeyValue)}
    this.resetKeyValue = null;
    setTimeout(() => this.reloadLinkTarget.click(), adjustMilliseconds)
  }

  toggleStartStop() {
    if (this.resetKeyValue) {
      clearInterval(this.resetKeyValue)
      this.resetKeyValue = null;
    } else {
      this.resetKeyValue = setInterval(() => this.reloadLinkTarget.click(), this.intervalMsecValue)
    }
  }
}
