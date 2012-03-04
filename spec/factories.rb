FactoryGirl.define do
  factory :user do
     sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@univ-bpclermont.com"}   
    password "foobar"
  end
end
