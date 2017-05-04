# Class to check and validate behaviour of phone numbers
class PhoneNumber
  include ActiveModel::Validations

  attr_reader :value, :country, :area, :number

  validates :value, presence: true
  validates_type :value, :string, message: 'value must be String'
  validates :value, length: 1..99
  validates :value, format: { with: /\A[0-9\-\s\(\)\+]+\Z/i,
                              message: 'have to contain only digits and dashes or brackets' }

  validates :value, format: { with: /\A[\+]{0,1}[0-9]{1,3}[\-\s\(]{0,1}[0-9]{1,3}[\-\s\)]{0,1}[0-9\-]{1,15}\Z/i,
                              message: 'have to be structured properly' }

  validates :country, presence: true
  validates_type :country, :string, message: 'country must be string'
  validates :country, format: { with: /\A[0-9]+\Z/i,
                                message: 'have to contain only digits' }

  validates :area, presence: true
  validates_type :area, :string, message: 'area must be number'
  validates :area, format: { with: /\A[0-9]+\Z/i,
                             message: 'have to contain only digits' }

  validates :number, presence: true
  validates_type :number, :string, message: 'number must be number'
  validates :number, format: { with: /\A[0-9]+\Z/i,
                               message: 'have to contain only digits' }

  validates_each :number do |entity, attr, value|
    entity.errors.add(attr, 'must not contain 0 or 1') if value.to_s =~ /[01]+/
  end

  def initialize(value)
    @value = value
    parse
  end

  private

  def parse
    _, s_country, _, s_area, _, s_number = @value.scan(
      /(\A[\+]{0,1})([0-9]{1,3})([\-\s\(]{0,1})([0-9]{1,3})([\-\s\)]{0,1})([0-9\-]{1,15})\Z/i
    ).flatten
    convert(s_country, s_area, s_number)
  end

  def convert(country, area, number)
    return if country.nil? || area.nil? || number.nil?

    @country = country.scan(/\d/).join('')
    @area = area.scan(/\d/).join('')
    @number = number.scan(/\d/).join('')
  end
end
