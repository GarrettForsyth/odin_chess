class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  VALID_HANDLE_REGEX = /\A[a-zA-Z0-9\-_]+\z/ # Only letters letters and numbers
  validates :handle, presence: true,
                     length: { maximum: 20 },
                     format: { with: VALID_HANDLE_REGEX },
                     uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 256 }, format: { with: VALID_EMAIL_REGEX }

end
