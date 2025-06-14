import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    reset: Boolean,
    intervalMsec: { type: Number, default: 0 },
    resetKey: {type: Number, default: null}
  }
  static targets = ['reloadLink']

  startInterval() {
    if (!!this.resetKeyValue) { clearInterval(this.resetKeyValue)}
    this.resetKeyValue = setInterval(() => this.reloadLinkTarget.click(), this.intervalMsecValue)
  }
}
