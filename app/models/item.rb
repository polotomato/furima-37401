class Item < ApplicationRecord
  # ActiveHash 関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :prefecture,
             :scheduled_delivery, :shipping_fee_status
  
  # テーブル関連
  has_one_attached :image
  belongs_to :user
end
