import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clocks"
export default class extends Controller {
  static values = {
    reset: Boolean,
    adjustInterval: Number
  }
  static outlets = ['interval']
  static targets = ["hand"]

  // Turbo Frames用
  connect() {
    if (!this.hasIntervalOutlet) return;
    this.callInterval()
    // 例: すべての針の固定角度を取得する
    this.handTargets.forEach(hand => {
      const fixed = hand.dataset.fixedAngle
      // 必要に応じてここで操作
      // console.log(fixed)
    })
  }

  // 画面初期表示用
  intervalOutletConnected() {
    this.callInterval()
  }

  callInterval() {
    if (this.resetValue) {
      this.intervalOutlet.adjustInterval(this.adjustIntervalValue)
    } else {
      this.intervalOutlet.startInterval()
    }
  }
}
