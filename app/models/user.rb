class User < ApplicationRecord
  # Postmark throwing errors -- commenting this out until Postmark account is verified
  # after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_favoritor

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
