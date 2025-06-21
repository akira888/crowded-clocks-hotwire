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
    this.animateHands()
  }

  // 画面初期表示用
  intervalOutletConnected() {
    this.callInterval()
    this.animateHands()
  }

  callInterval() {
    if (this.resetValue) {
      this.intervalOutlet.adjustInterval(this.adjustIntervalValue)
    } else {
      this.intervalOutlet.startInterval()
    }
  }

  animateHands() {
    const now = new Date()
    const sec = now.getSeconds()
    // 03秒以降または33秒以降ならアニメーション
    if ((sec >= 3 && sec < 30) || (sec >= 33)) {
      this.handTargets.forEach(hand => {
        const target = hand.dataset.fixedAngle
        if (!target) return
        // 目的角度
        const to = `${target}deg`
        // 現在の角度
        const from = hand.style.rotate || "0deg"
        // 残り秒数
        let remain = 0
        if (sec >= 3 && sec < 30) {
          remain = 30 - sec
        } else if (sec >= 33) {
          remain = 60 - sec
        }
        // アニメーションduration（ms）
        const duration = remain * 1000
        hand.animate([
          { rotate: from },
          { rotate: to }
        ], {
          duration: duration,
          fill: "forwards"
        })
        // style属性も更新
        hand.style.rotate = to
      })
    }
  }
}
