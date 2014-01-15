class Company < ActiveRecord::Base
  belongs_to :user
  include Contact
  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
