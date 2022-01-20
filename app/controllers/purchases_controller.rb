class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @purchase_item = PurchaseItem.new
  end

  def create
    @purchase_item = PurchaseItem.new(purchase_params)
    if @purchase_item.valid?
      pay_item
      @purchase_item.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def move_to_index
    @item = Item.includes(:purchase).find(params[:item_id])
    if @item.purchase || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def purchase_params
    params.require(:purchase_item).permit(
      :postal_code,   :prefecture_id,
      :city,          :address_line,
      :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
