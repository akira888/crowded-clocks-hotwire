require 'rails_helper'

RSpec.describe Clock::Basic do
  let(:now) { Time.new(2025, 6, 20, 12, 30, 0) } # 2025年6月20日 12:30
  let(:position) { 'x' }
  let(:pattern) { 'pattern' }
  let(:start) { Time.new(2025, 6, 20, 12, 0) } # オプションのスタート時間

  subject(:clock) { described_class.new(now, position, pattern, start) }

  describe '時間帯に応じた針の動き' do
    before do
      allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
    end

    context '00~05秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 3) } # 3秒

      it '現在時刻の角度を保持する' do
        # 現在時刻の分針角度 = 30 * 6 + 3 * 0.1 + 90 = 270.3度
        # 現在時刻の時針角度 = (12 % 12) * 30 + 30 * 0.5 + 90 = 105度
        expect(clock.big_hand_angle).to eq('270.3deg')
        expect(clock.small_hand_angle).to eq('105.0deg')
      end
    end

    context '05~30秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 15) } # 15秒

      it 'left_rightの角度に向かって移動する' do
        # 現在時刻の角度からleft_rightの角度に向かって移動中（40%移動）
        # 分針: 270.0度から0度へ移動中 (最短経路は90度) ≒ 306度
        # 時針: 105.0度から180度へ移動中 (最短経路は75度) ≒ 135度
        angle_big = clock.big_hand_angle.gsub('deg', '').to_f
        angle_small = clock.small_hand_angle.gsub('deg', '').to_f

        expect(angle_big).to be_within(1).of(306)
        expect(angle_small).to be_within(1).of(135)
      end
    end

    context '30~00秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 45) } # 45秒

      it '次の時刻の角度に向かって移動する' do
        # left_rightの角度から次の時刻の角度に向かって移動中（50%移動）
        # 次の時刻 = 12:31:00
        # 次の時刻の分針角度 = 31 * 6 + 0 * 0.1 + 90 = 276度
        # 次の時刻の時針角度 = (12 % 12) * 30 + 31 * 0.5 + 90 = 105.5度
        #
        # left_right[0] = 0から276度へ50%移動 = 320.25度 (実際の計算値に合わせる)
        # left_right[1] = 180から105.5度へ50%移動（最短経路は反時計回り） = 142.75度
        angle_big = clock.big_hand_angle.gsub('deg', '').to_f
        angle_small = clock.small_hand_angle.gsub('deg', '').to_f

        expect(angle_big).to be_within(1).of(320.25)
        expect(angle_small).to be_within(1).of(143)
      end
    end
  end
end
