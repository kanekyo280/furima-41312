class ItemsController < ApplicationController
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
    @item = Item.find(params[:id])
  end

def edit
  @item = Item.find(params[:id])
  unless current_user == @item.user
    redirect_to root_path
  end
end

def update
  @item = Item.find(params[:id])
  if @item.update(item_params)
    redirect_to item_path
  else
    render :edit,status: :unprocessable_entity
  end
end

def delete

end


  private
  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :product_status_id, :postage_payer_id, :delivery_area_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
