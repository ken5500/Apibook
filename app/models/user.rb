class User < ApplicationRecord
before_create :generate_api_key
has_many :book_copies

validates :first_name, :last_name, :email, presence: true

def generate_api_key
  loop do
self.api_key = SecureRandom.base64(30)
break unless User.exists?(api_key: self.api_key)
  end
end
end
