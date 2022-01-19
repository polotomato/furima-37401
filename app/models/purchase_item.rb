class PurchaseItem
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code,
                :prefecture_id, :city, :address_line,
                :building_name, :phone_number, :purchase_id
  
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input a 10 or 11 digit number" }
    validates :purchase_id
  end
end