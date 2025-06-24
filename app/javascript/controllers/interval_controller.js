import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    reset: Boolean,
    intervalMsec: Number,
    resetKey: {type: Number, default: null}
  }
  static targets = ['reloadLink', 'debugTool']

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
}
