import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clocks"
export default class extends Controller {
  static values = {
    reset: Boolean,
    adjustInterval: Number,
    animateStarter: {type: Number, default: null}
  }
  static outlets = ['interval']
  static targets = ["hand"]

  // Turbo Frames用
  connect() {
    if (this.hasIntervalOutlet) {
      this.callInterval()
    }

    this.startHandAnimationTimer()
  }

  // 画面初期表示用
  intervalOutletConnected() {
    this.callInterval()
  }

  startHandAnimationTimer() {
    if (this.animateStarterValue) this.stopHandAnimationTimer()

    this.animateStarterValue = setInterval(() => this.animateHands(), 1000)
  }

  stopHandAnimationTimer() {
    clearInterval(this.animateStarterValue)
    this.animateStarterValue = null
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
      // 実行開始したらトリガーを止める
      this.stopHandAnimationTimer()

      this.handTargets.forEach(hand => {
        const to = hand.dataset.fixedAngle // ex. 180deg
        if (!to) return
        // 現在の角度
        const from = hand.style.rotate || "0deg"
        // 残り秒数
        let remain = 0
        if (sec >= 3 && sec < 30) {
          remain = 30 - sec
        } else if (sec >= 33) {
          remain = 60 - sec
        }
        hand.animate([
          { rotate: from },
          { rotate: to }
        ], {
          duration: remain * 1000,
          fill: "forwards"
        })
      })
    }
  }

  disconnect() {
    if (this.animateStarterValue) this.stopHandAnimationTimer()
  }
}
