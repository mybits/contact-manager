class PhoneNumber < ActiveRecord::Base
  belongs_to :contact, polymorphic: true
  validates :number, :contact_id, presence: true
end
