class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :prefecture,
             :scheduled_delivery, :shipping_fee_status
end
