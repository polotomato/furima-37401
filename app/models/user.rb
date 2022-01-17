class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,128}\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'
    
  with_options presence: true do
    validates :nickname
    validates :birth_date

    NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
    NAME_ERROR_MSG = 'is invalid. Input full-width characters'
    with_options format: { with: NAME_REGEX, message: NAME_ERROR_MSG } do
      validates :last_name
      validates :first_name
    end

    NAME_KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
    NAME_KANA_ERROR_MSG = 'is invalid. Input full-width katakana characters'
    with_options format: { with: NAME_KANA_REGEX, message: NAME_KANA_ERROR_MSG } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  has_many :items
end
