class PurchaseItem
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code,
                :prefecture_id, :city, :address_line,
                :building_name, :phone_number, :purchase_id,
                :token
  
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input a 10 or 11 digit number" }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address_line: address_line,
      building_name: building_name,
      phone_number: phone_number,
      purchase_id: purchase.id
    )
  end
end
