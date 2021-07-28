class AdminsController < ApplicationController

  before_action :admin

  def admin
    render 'main/not_accepted' unless (user_signed_in? && current_user.try(:admin?))
  end

  def orders
    if Order.maximum('order_number').nil?
      @finalOrderArray = []
    else
      @finalOrderArray = []
      iI = 1
      while Order.maximum('order_number') >= iI
        if Order.all.where(order_number: iI).nil? || Order.all.where(order_number: iI) == []
          iI += 1
          next
        end
        @orderHash = Order.all.where(order_number: iI)
        @clients_db = Client.all.where(id: @orderHash[0].client_id)
        @finalOrder = {
          client: [@clients_db[0].name, @clients_db[0].adress, @clients_db[0].phone],
          orderNumber: @orderHash[0].order_number,
          createdAt: @orderHash[0].created_at,
          updatedAt: @orderHash[0].updated_at,
          status: @orderHash[0].status,
          totalPrice: [],
          good: [],
          amount: []
        }
        i = 0
        while i < @orderHash.length
          @goods_db = Good.all.where(id: @orderHash[i].good_id)
          @finalOrder[:totalPrice].push(@orderHash[i].amount.to_i * @orderHash[i].price.to_i)
          @finalOrder[:good].push(@goods_db[0].name)
          @finalOrder[:amount].push(@orderHash[i].amount)
          i += 1
        end
        @finalOrderArray.push(@finalOrder)
        iI += 1
      end
    end
  end

  def clients
    @client = Client.all
  end

  def destroyClient
    Client.where(id: params[:id]).first.destroy
    redirect_to '/admin/clients'
  end

  def goods
    @good = Good.all.order('created_at DESC')
  end

  def create
    Good.create(good_params)
    redirect_to '/admin/goods'
  end

  def destroy
    Good.where(id: params[:id]).first.destroy
    redirect_to '/admin/goods'
  end

  def update
    Good.where(id: params[:id]).update(good_params)
    redirect_to '/admin/goods'
  end

  def good_params
    params.permit(:name, :price, :weight, :discription, :insale, :category, :storage_image)
  end

end
