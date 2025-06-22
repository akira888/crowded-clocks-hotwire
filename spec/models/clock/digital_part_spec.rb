require 'rails_helper'

RSpec.describe Clock::DigitalPart do
  let(:now) { Time.new(2025, 6, 20, 12, 30, 3) } # 00~05秒の範囲に修正
  let(:position) { '0' } # 16進数の0番目の位置
  let(:pattern) { 'flat' }
  let(:start) { Time.new(2025, 6, 20, 12, 0) } # オプションのスタート時間
  let(:group) { 0 } # 1番目のグループ (時間の「1」の位置)

  subject(:digital_part) { described_class.new(now, position, pattern, group, start) }

  describe '#initialize' do
    it 'ClockObjectの初期化と追加のグループ属性を設定する' do
      expect(digital_part.now).to eq(now)
      expect(digital_part.position).to eq(position)
      expect(digital_part.pattern).to eq(pattern)
      expect(digital_part.start).to eq(start)
      expect(digital_part.group).to eq(group)
    end
  end

  describe '時間帯に応じた針の動き' do
    before do
      allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
    end

    context '00~05秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 3) } # 3秒

      before do
        # 現在時刻のデジタル表示の角度をモック
        allow(digital_part).to receive(:current_angles).and_return([ 90, 270 ])
      end

      it '現在時刻のデジタル表示の角度を保持する' do
        expect(digital_part.big_hand_angle).to eq('90.0deg')
        expect(digital_part.small_hand_angle).to eq('270.0deg')
      end
    end

    context '05~30秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 15) } # 15秒

      before do
        # 現在時刻のデジタル表示の角度をモック
        allow(digital_part).to receive(:current_angles).and_return([ 90, 270 ])
        # 次の時刻のデジタル表示の角度をモック（使わないが念のため）
        allow(digital_part).to receive(:next_angles).and_return([ 270, 90 ])
      end

      it 'left_rightの角度に向かって移動する' do
        angle_big = digital_part.big_hand_angle.gsub('deg', '').to_f
        angle_small = digital_part.small_hand_angle.gsub('deg', '').to_f
        expect(angle_big).to be_within(1).of(50.0)
        expect(angle_small).to be_within(1).of(230.0)
      end
    end

    context '30~00秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 45) } # 45秒

      before do
        # 次の時刻のデジタル表示の角度をモック
        allow(digital_part).to receive(:next_angles).and_return([ 270, 90 ])
      end

      it '次の時刻のデジタル表示の角度に向かって移動する' do
        angle_big = digital_part.big_hand_angle.gsub('deg', '').to_f
        angle_small = digital_part.small_hand_angle.gsub('deg', '').to_f
        expect(angle_big).to be_within(5).of(320.0)
        expect(angle_small).to be_within(5).of(135.0)
      end
    end
  end

  describe '#big_hand_angle and #small_hand_angle' do
    context 'グループ0が「1」の数字（時：12時31分）を表示する場合' do
      let(:group) { 0 } # 時間の「1」の位
      let(:position) { '0' } # 0番目のセグメント位置

      before do
        # 00~05秒の範囲に固定してテストするため、モックを設定
        allow(digital_part).to receive(:hand_angles).and_return([ 90, 270 ])

        allow(DigitalPartsMap).to receive(:by_number).with(1).and_return(
          [ :not_parts, :not_parts, :down_down, :not_parts, :not_parts, :down_up,
           :not_parts, :not_parts, :down_up, :not_parts, :not_parts, :down_up,
           :not_parts, :not_parts, :up_up ]
        )
      end

      it 'DigitalPartsMapから適切な角度キーワードを取得する' do
        expect(digital_part.big_hand_angle).to eq('90deg')  # :down_down の最初の角度
        expect(digital_part.small_hand_angle).to eq('270deg') # :down_down の2番目の角度
      end
    end

    context 'グループ1が「2」の数字（時：12時31分）を表示する場合' do
      let(:group) { 1 } # 時間の「2」の位
      let(:position) { '1' } # 1番目のセグメント位置

      before do
        # 00~05秒の範囲に固定してテストするため、モックを設定
        allow(digital_part).to receive(:hand_angles).and_return([ 180, 0 ])

        allow(DigitalPartsMap).to receive(:by_number).with(2).and_return(
          [ :right_right, :left_right, :down_left, :not_parts, :not_parts, :down_up,
           :down_right, :left_right, :up_left, :down_up, :not_parts, :not_parts,
           :up_right, :left_right, :left_left ]
        )
      end

      it 'DigitalPartsMapから適切な角度キーワードを取得する' do
        expect(digital_part.big_hand_angle).to eq('180deg')  # :left_right の最初の角度
        expect(digital_part.small_hand_angle).to eq('0deg')  # :left_right の2番目の角度
      end
    end

    context 'not_partsの場合（セグメントを表示しない）' do
      let(:group) { 3 } # 分の「1」の位
      let(:position) { '4' } # 4番目のセグメント位置

      before do
        # 00~05秒の範囲に固定してテストするため、モックを設定
        allow(digital_part).to receive(:hand_angles).and_return([ 180, 90 ])

        # 追加のモックを設定（current_digital_number）
        next_time = now.advance(minutes: 1)
        allow(digital_part).to receive(:digital_number).with(now).and_return(1)
        allow(digital_part).to receive(:digital_number).with(next_time).and_return(1)
        allow(DigitalPartsMap).to receive(:by_number).with(1).and_return(
          Array.new(15) { |i| i == 4 ? :not_parts : :down_up }
        )
        allow(Angle).to receive(:not_parts?).with('not_parts').and_return(true)
      end

      it 'アナログ時計の角度を返す' do
        allow(digital_part).to receive(:next_analog_angles).and_return([ 180, 90 ])
        expect(digital_part.big_hand_angle).to eq('180deg')
        expect(digital_part.small_hand_angle).to eq('90deg')
      end
    end
  end

  describe '#big_hand_destination_angle, #small_hand_destination_angle' do
    before do
      allow(Angle).to receive(:fixed_angles).with('left+right').and_return([ 0, 180 ])
    end

    context '00~29秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 10) } # 10秒
      before do
        allow_any_instance_of(described_class).to receive(:destination_angles).and_return([ 123, 234 ])
      end
      it '30秒の角度を返す' do
        expect(digital_part.big_hand_destination_angle).to eq('123deg')
        expect(digital_part.small_hand_destination_angle).to eq('234deg')
      end
    end

    context '30~59秒の場合' do
      let(:now) { Time.new(2025, 6, 20, 12, 30, 40) } # 40秒
      before do
        allow_any_instance_of(described_class).to receive(:destination_angles).and_return([ 345, 456 ])
      end
      it '00秒の角度を返す' do
        expect(digital_part.big_hand_destination_angle).to eq('345deg')
        expect(digital_part.small_hand_destination_angle).to eq('456deg')
      end
    end
  end
end
