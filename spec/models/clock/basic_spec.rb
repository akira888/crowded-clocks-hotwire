require 'rails_helper'

RSpec.describe Clock::Basic do
  let(:now) { Time.new(2025, 6, 20, 12, 30, 0) } # 2025年6月20日 12:30
  let(:position) { 'x' }
  let(:pattern) { 'pattern' }
  let(:start) { Time.new(2025, 6, 20, 12, 0) } # オプションのスタート時間

  subject(:clock) { described_class.new(now, position, pattern, start) }

  describe '#big_hand_angle' do
    it '分針の角度を正しく計算する' do
      # 12:31:00 になるので、分針は 31 * 6 = 186° + ベース角度 90° = 276°
      expect(clock.big_hand_angle).to eq('276.0deg')
    end
  end

  describe '#small_hand_angle' do
    it '時針の角度を正しく計算する' do
      # 12:31:00 になるので、時針は (12 % 12) * 30 + 31 * 0.5 = 0 + 15.5 = 15.5° + ベース角度 90° = 105.5°
      expect(clock.small_hand_angle).to eq('105.5deg')
    end
  end

  context '異なる時間の場合' do
    let(:now) { Time.new(2025, 6, 20, 6, 45, 0) } # 2025年6月20日 6:45

    it '分針の角度を正しく計算する' do
      # 6:46:00 になるので、分針は 46 * 6 = 276° + ベース角度 90° = 366° => 6°
      expect(clock.big_hand_angle).to eq('366.0deg')
    end

    it '時針の角度を正しく計算する' do
      # 6:46:00 になるので、時針は (6 % 12) * 30 + 46 * 0.5 = 180 + 23 = 203° + ベース角度 90° = 293°
      expect(clock.small_hand_angle).to eq('293.0deg')
    end
  end
end
