require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

RSpec.describe PhoneNumber do
  context 'factory' do
    it 'valid if using basic factory' do
      expect(build(:phone_number)).to be_valid
    end

    it 'not valid if using zero factory' do
      expect(build(:zeros_phone_number)).to_not be_valid
    end

    it 'not valid if using one factory' do
      expect(build(:ones_phone_number)).to_not be_valid
    end

    it 'not valid if using zero and one factory' do
      expect(build(:zero_ones_phone_number)).to_not be_valid
    end
  end
end
