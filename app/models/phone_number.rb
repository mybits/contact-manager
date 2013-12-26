class PhoneNumber < ActiveRecord::Base
  belongs_to :contact, polymorphic: true
  validates :number, :contact_id, :contact_type, presence: true
end
