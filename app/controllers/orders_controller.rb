class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index]
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @saleslog_delivery =SaleslogDelivery.new
    if @item.saleslog.present? || @item.user_id == current_user.id
      redirect_to root_path
    end
  end

def create
  @saleslog_delivery = SaleslogDelivery.new(delivery_params)
  if @saleslog_delivery.valid?
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: delivery_params[:token],
      currency: 'jpy'
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
    params.require(:saleslog_delivery).permit(:postal_code, :delivery_area_id, :address_city, :address_house_number, :address_building_name, :phone_number).merge(user_id: current_user.id, token: params[:token],  item_id: params[:item_id])
  end
end
