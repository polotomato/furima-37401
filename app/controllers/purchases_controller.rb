class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @purchase_item = PurchaseItem.new
  end

  def create
  end

  private

  def move_to_index
    @item = Item.includes(:purchase).find(params[:item_id])
    if @item.purchase || current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
