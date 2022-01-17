class Item < ApplicationRecord
  # ActiveHash 関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :prefecture,
             :scheduled_delivery, :shipping_fee_status
  
  # テーブル関連
  belongs_to :user
end
