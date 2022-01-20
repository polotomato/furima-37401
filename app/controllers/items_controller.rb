class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_wrong_user_to_index, only: [:edit, :destroy]

  def index
    @items = Item.order("created_at DESC").includes(:purchase)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @item.purchase
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :description, :category_id,:condition_id,
      :shipping_fee_status_id, :prefecture_id,
      :scheduled_delivery_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.includes(:purchase).find(params[:id])
  end

  def move_wrong_user_to_index
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
