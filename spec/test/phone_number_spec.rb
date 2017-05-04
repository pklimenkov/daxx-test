require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

RSpec.describe PhoneNumber do
  context 'factory' do
    it 'valid if using basic factory' do
      expect(build(:phone_number)).to be_valid
    end

    it 'not valid if using zero factory' do
      expect(build(:zeros_phone_number)).not_to be_valid
    end

    it 'not valid if using one factory' do
      expect(build(:ones_phone_number)).not_to be_valid
    end

    it 'not valid if using zero and one factory' do
      expect(build(:zero_ones_phone_number)).not_to be_valid
    end
  end

  context 'formatting' do
    it 'valid with +XXXXXXXXXX' do
      expect(described_class.new('+2222222222')).to be_valid
    end

    it 'valid with XXXXXXXXXX' do
      expect(described_class.new('2222222222')).to be_valid
    end

    it 'valid with +X-XXX-XXXXXX' do
      expect(described_class.new('+2-222-222222')).to be_valid
    end

    it 'valid with X-XXX-XXXXXX' do
      expect(described_class.new('2-222-222222')).to be_valid
    end

    it 'valid with +X XXX XXXXXX' do
      expect(described_class.new('+2 222 222222')).to be_valid
    end

    it 'valid with X XXX XXXXXX' do
      expect(described_class.new('2 222 222222')).to be_valid
    end

    it 'valid with X(XXX)XXXXXX' do
      expect(described_class.new('2(222)222222')).to be_valid
    end

    it 'valid with +X(XXX)XXXXXX' do
      expect(described_class.new('+2(222)222222')).to be_valid
    end

    it 'valid with X(XXX)XXX-XXX' do
      expect(described_class.new('2(222)222-222')).to be_valid
    end

    it 'valid with +X(XXX)XXX-XXX' do
      expect(described_class.new('+2(222)222-222')).to be_valid
    end

    it 'not valid with X.XXX.XXX.XXX' do
      expect(described_class.new('2.222.222.222')).not_to be_valid
    end

    it 'not valid with X,XXX,XXX,XXX' do
      expect(described_class.new('2,222,222,222')).not_to be_valid
    end

    it 'not valid with X_XXX_XXX_XXX' do
      expect(described_class.new('2_222_222_222')).not_to be_valid
    end
  end

  context 'valid digits' do
    it 'valid with every digit except 0 and 1' do
      expect(described_class.new('23456789999')).to be_valid
    end

    it 'not valid with 0' do
      expect(described_class.new('23456789990')).not_to be_valid
    end

    it 'not valid with 1' do
      expect(described_class.new('23456789991')).not_to be_valid
    end
  end
end
