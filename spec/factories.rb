FactoryBot.define do
    factory :user do
      email { 'test@example.com' }
      password { '255685464' }
      # using dynamic attributes over static attributes in FactoryBot
    end
    factory :article do
        title { 'test' }
        body { '255685464' }
        # using dynamic attributes over static attributes in FactoryBot
      end
  end