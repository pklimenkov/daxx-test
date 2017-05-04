# Class to check and validate behaviour of phone numbers
class PhoneNumber
  include ActiveModel::Validations

  attr_reader :value, :country, :area, :number

  validates :value, presence: true
  validates_type :value, :string, message: 'value must be String'
  validates :value, length: 1..99
  validates :value, format: { with: /\A[0-9\-\s\(\)]+\Z/i,
                              message: 'have to contain only digits and dashes or brackets' }

  validates :value, format: { with: /\A[\+]{0,1}[0-9]{1,3}[\-\s\(]{0,1}[0-9]{1,3}[\-\s\)]{0,1}[0-9\-]{1,9}\Z/i,
                              message: 'have to be structured properly' }

  validates :country, presence: true
  validates_type :country, :integer, message: 'country must be number'

  validates :area, presence: true
  validates_type :area, :integer, message: 'area must be number'

  validates :number, presence: true
  validates_type :number, :integer, message: 'number must be number'

  validates_each :country, :area, :number do |entity, attr, value|
    entity.errors.add(attr, 'must not contain 0 or 1') if value.to_s =~ /[01]+/
  end

  def initialize(value)
    @value = value
    parse
    convert
  end

  private

  def parse
    _, @country, _, @area, _, @number = @value.scan(
        /(\A[\+]{0,1})([0-9]{1,3})([\-\s\(]{0,1})([0-9]{1,3})([\-\s\)]{0,1})([0-9\-]{1,9})\Z/i
    )
  end

  def convert
    @country = @country.scan(/\d/).join('').to_i
    @area = @area.scan(/\d/).join('').to_i
    @number = @number.scan(/\d/).join('').to_i
  end
end