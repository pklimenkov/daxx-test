FactoryGirl.define do
  factory :phone_number do
    country { rand(2..9) }
    area { rand(2..9) }
    number { n = ''; 7.times { n << rand(2..9).to_s }; n.to_i }

    initialize_with do
      new("+#{country}(#{area})#{number}")
    end
  end

  factory :zeros_phone_number, parent: :phone_number do
    country 20
    area 204
    number 90876554
  end

  factory :ones_phone_number, parent: :phone_number do
    country 11
    area 214
    number 19876554
  end

  factory :zero_ones_phone_number, parent: :phone_number do
    country 10
    area 210
    number 19806554
  end
end
