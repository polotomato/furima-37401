class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,128}\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_ERROR_MSG = 'is invalid. Input full-width characters'
  validates_format_of :last_name, with: NAME_REGEX, message: NAME_ERROR_MSG
  validates_format_of :first_name, with: NAME_REGEX, message: NAME_ERROR_MSG
  
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  NAME_KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  NAME_KANA_ERROR_MSG = 'is invalid. Input full-width katakana characters'
  validates_format_of :last_name_kana, with: NAME_KANA_REGEX, message: NAME_KANA_ERROR_MSG
  validates_format_of :first_name_kana, with: NAME_KANA_REGEX, message: NAME_KANA_ERROR_MSG
  
  validates :birth_date, presence: true
end
