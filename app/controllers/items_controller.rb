class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

def index
  @item = Item.all.order("created_at DESC")
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

  def show

  end

def edit
  if @item.saleslog.present? ||  current_user.id != @item.user_id
    redirect_to root_path
  end
end

def update
  if @item.update(item_params)
    redirect_to item_path
  else
    render :edit,status: :unprocessable_entity
  end
end

def destroy
  if  current_user == @item.user
      @item.destroy
  end
    redirect_to root_path
end

  private
  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :product_status_id, :postage_payer_id, :delivery_area_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
