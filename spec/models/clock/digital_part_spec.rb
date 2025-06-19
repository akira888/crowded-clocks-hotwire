require 'rails_helper'

RSpec.describe Clock::DigitalPart do
  let(:now) { Time.new(2025, 6, 20, 12, 30, 0) } # 2025年6月20日 12:30
  let(:position) { '0' } # 16進数の0番目の位置
  let(:pattern) { 'pattern' }
  let(:start) { Time.new(2025, 6, 20, 12, 0) } # オプションのスタート時間
  let(:group) { 0 } # 1番目のグループ (時間の「1」の位置)

  subject(:digital_part) { described_class.new(now, position, pattern, start, group) }

  describe '#initialize' do
    it 'ClockObjectの初期化と追加のグループ属性を設定する' do
      expect(digital_part.now).to eq(now)
      expect(digital_part.position).to eq(position)
      expect(digital_part.pattern).to eq(pattern)
      expect(digital_part.start).to eq(start)
      expect(digital_part.group).to eq(group)
    end
  end

  describe '#big_hand_angle and #small_hand_angle' do
    context 'グループ0が「1」の数字（時：12時31分）を表示する場合' do
      let(:group) { 0 } # 時間の「1」の位
      let(:position) { '0' } # 0番目のセグメント位置

      before do
        allow(DigitalPartsMap).to receive(:by_number).with(1).and_return(
          [:not_parts, :not_parts, :down_down, :not_parts, :not_parts, :down_up,
           :not_parts, :not_parts, :down_up, :not_parts, :not_parts, :down_up,
           :not_parts, :not_parts, :up_up]
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
        allow(DigitalPartsMap).to receive(:by_number).with(2).and_return(
          [:right_right, :left_right, :down_left, :not_parts, :not_parts, :down_up,
           :down_right, :left_right, :up_left, :down_up, :not_parts, :not_parts,
           :up_right, :left_right, :left_left]
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
        allow(digital_part).to receive(:digital_number).and_return(1)
        allow(DigitalPartsMap).to receive(:by_number).with(1).and_return(
          Array.new(15) { |i| i == 4 ? :not_parts : :down_up }
        )
        allow(Angle).to receive(:not_parts?).with('not_parts').and_return(true)
      end

      it 'アナログ時計の角度を返す' do
        allow(digital_part).to receive(:analog_angles).and_return([180, 90])
        expect(digital_part.big_hand_angle).to eq('180deg')
        expect(digital_part.small_hand_angle).to eq('90deg')
      end
    end
  end
end
