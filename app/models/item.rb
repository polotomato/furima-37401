class Item < ApplicationRecord
  # ActiveHash 関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to :shipping_fee_status
  
  # テーブル関連
  has_one_attached :image
  belongs_to :user
  has_one :purchase

  # バリデーション
  validates :image, presence: { message: "must be attaced" }

  with_options presence: true do
    validates :name,        length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }

    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
    validates :price, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999
    }
  end
end
