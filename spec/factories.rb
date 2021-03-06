FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@univ-bpclermont.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
end
