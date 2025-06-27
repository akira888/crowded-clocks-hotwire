require 'rails_helper'

RSpec.describe Angle do
  describe '.fixed_angles' do
    context '有効なキーワードが渡された場合' do
      it { expect(Angle.fixed_angles('up')).to eq([ 0 ]) }
      it { expect(Angle.fixed_angles('down')).to eq([ 180 ]) }
      it { expect(Angle.fixed_angles('left')).to eq([ 270 ]) }
      it { expect(Angle.fixed_angles('right')).to eq([ 90 ]) }
      it { expect(Angle.fixed_angles('up_right')).to eq([ 45 ]) }
      it { expect(Angle.fixed_angles('up_left')).to eq([ 315 ]) }
      it { expect(Angle.fixed_angles('down_right')).to eq([ 135 ]) }
      it { expect(Angle.fixed_angles('down_left')).to eq([ 225 ]) }
      it { expect(Angle.fixed_angles('up+right')).to eq([ 0, 90 ]) }
      it { expect(Angle.fixed_angles('left+down')).to eq([ 270, 180 ]) }
      it { expect(Angle.fixed_angles('up_left+down_right')).to eq([ 315, 135 ]) }
      it { expect(Angle.fixed_angles('up_right+down_left')).to eq([ 45, 225 ]) }
    end

    context '無効なキーワードが渡された場合' do
      it '未定義のキーワードではnilを返す' do
        expect(Angle.fixed_angles('invalid')).to be_nil
      end

      it '部分的に有効なキーワードでも無効な部分があればnilを返す' do
        expect(Angle.fixed_angles('up_invalid')).to be_nil
      end
    end
  end

  describe '.not_parts?' do
    it '"not_parts"キーワードに対してtrueを返す' do
      expect(Angle.not_parts?('not_parts')).to be true
    end

    it '他のキーワードに対してfalseを返す' do
      expect(Angle.not_parts?('up')).to be false
      expect(Angle.not_parts?('down')).to be false
      expect(Angle.not_parts?('')).to be false
    end
  end
end
