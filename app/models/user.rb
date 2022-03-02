class User < ApplicationRecord
	validates :name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :address, presence: true, length: {maximum: 256}, allow_blank: false
  validates :phone,   :presence => true,
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :status, presence: true, allow_blank: false

end
