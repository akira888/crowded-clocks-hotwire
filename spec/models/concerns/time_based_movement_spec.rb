require 'rails_helper'

class TestClass
  include TimeBasedMovement
  attr_reader :now

  def initialize(now)
    @now = now
  end
end

RSpec.describe TimeBasedMovement do
  describe '#time_based_angles' do
    let(:test_instance) { TestClass.new(current_time) }
    let(:current_angles) { [ 90, 180 ] }
    let(:next_angles) { [ 270, 0 ] }
    let(:pattern) { 'flat' }

    context '00~03秒の場合' do
      let(:current_time) { Time.new(2025, 6, 20, 12, 30, 2) }

      it '現在の角度をそのまま返す' do
        expect(test_instance.time_based_angles(current_time.sec, current_angles, next_angles, pattern)).to eq(current_angles)
      end
    end

    context '03~30秒の場合' do
      let(:current_time) { Time.new(2025, 6, 20, 12, 30, 15) }

      before do
        allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
      end

      it 'left_rightの角度に向かって移動する' do
        # 15秒目 = 3秒経過から12秒経過 (27秒中) = 約44.4%移動
        result = test_instance.time_based_angles(current_time.sec, current_angles, next_angles, pattern)
        expect(result[0]).to be_within(0.1).of(50)  # 90度から0度へ44.4%移動
        expect(result[1]).to be_within(0.1).of(180) # 変化なし
      end
    end

    context '30~33秒の場合' do
      let(:current_time) { Time.new(2025, 6, 20, 12, 30, 31) }

      before do
        allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
      end

      it 'パターン角度で固定される' do
        expect(test_instance.time_based_angles(current_time.sec, current_angles, next_angles, pattern)).to eq([ 0, 180 ])
      end
    end

    context '33~00秒の場合' do
      let(:current_time) { Time.new(2025, 6, 20, 12, 30, 45) }

      before do
        allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
      end

      it '次の時刻の角度に向かって移動する' do
        # 45秒目 = 33秒経過から12秒経過 (27秒中) = 約44.4%移動
        result = test_instance.time_based_angles(current_time.sec, current_angles, next_angles, pattern)
        # 270度から0度へ44.4%移動 = 270 + (0-270) * 12/27 ≒ 120度減少 → 320度
        expect(result[0]).to be_within(0.1).of(320.0)
        # 180度から0度へ44.4%移動 = 180 + (0-180) * 12/27 ≒ 100度
        expect(result[1]).to be_within(0.1).of(260.0)
      end
    end
  end

  describe '#calculate_transition_angles' do
    let(:test_instance) { TestClass.new(Time.new(2025, 6, 20, 12, 30, 0)) }

    it '両方の角度が有効な場合、経過時間に応じた角度を計算する' do
      result = test_instance.send(:calculate_transition_angles, [ 90, 180 ], [ 270, 0 ], 10, 20)
      expect(result[0]).to be_within(0.1).of(180) # 90度から270度へ50%移動
      expect(result[1]).to be_within(0.1).of(270) # 180度から0度へ50%移動
    end

    it 'start_anglesがnilの場合はnilを返す' do
      expect(test_instance.send(:calculate_transition_angles, nil, [ 90, 180 ], 10, 20)).to be_nil
    end

    it 'target_anglesがnilの場合はstart_anglesを返す' do
      expect(test_instance.send(:calculate_transition_angles, [ 90, 180 ], nil, 10, 20)).to eq([ 90, 180 ])
    end
  end

  describe '#calculate_angle_transition' do
    let(:test_instance) { TestClass.new(Time.new(2025, 6, 20, 12, 30, 0)) }

    it '時計回りの最短経路で角度を計算する' do
      result = test_instance.send(:calculate_angle_transition, 90, 180, 5, 20)
      expect(result).to be_within(0.1).of(112.5) # 90度から180度へ25%移動
    end

    it '反時計回りの最短経路で角度を計算する' do
      result = test_instance.send(:calculate_angle_transition, 180, 90, 5, 20)
      expect(result).to be_within(0.1).of(157.5) # 180度から90度へ25%移動
    end

    it '360度を考慮した最短経路で角度を計算する' do
      result = test_instance.send(:calculate_angle_transition, 350, 10, 5, 20)
      expect(result).to be_within(0.1).of(355) # 350度から10度へ25%移動
    end
  end
end
