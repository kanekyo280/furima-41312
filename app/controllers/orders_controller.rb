class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @saleslog_delivery =SaleslogDelivery.new
  end

def create
  @saleslog_delivery = SaleslogDelivery.new(delivery_params)
  if @saleslog_delivery.valid?
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段※個々の記述を質問で聞く
      card: delivery_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
    @saleslog_delivery.save
    redirect_to root_path
  else
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render :index, status: :unprocessable_entity
  end
end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def delivery_params
    params.require(:saleslog_delivery).permit(:postal_code, :delivery_area_id, :address_city, :address_house_number, :address_building_name, :phone_number, :item_id).merge(user_id: current_user.id, token: params[:token],  item_id: params[:item_id])
  end
end
