class Contact < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy
end
