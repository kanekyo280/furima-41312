class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

def inex
  @item = Item.all
end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :product_status_id, :postage_payer_id, :delivery_area_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
