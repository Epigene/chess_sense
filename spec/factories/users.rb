FactoryBot.define do
  factory :user do
    sequence(:email, 1) { |n| "user#{n}@example.com" }
    password "test_password"
    name "John Doe"
    data({})
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :text             not null
#  password_digest :text             not null
#  name            :text             not null
#  data            :jsonb            not null
#
# Indexes
#
#  index_users_on_created_at  (created_at)
#  index_users_on_email       (email) UNIQUE
#  index_users_on_name        (name)
#
