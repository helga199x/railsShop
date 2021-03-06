class OrdersController < ApplicationController

  before_action :user

  def user
    render 'main/not_accepted' unless user_signed_in?
  end

  def show
    if Order.maximum('order_number').nil?
      @finalOrderArray = []
    else
      @finalOrderArray = []
      iI = 1
      while Order.maximum('order_number') >= iI
        if Order.all.where(order_number: iI).nil? || Order.all.where(order_number: iI) == []
          iI += 1
          next
        elsif (@orderHash = Order.all.where(order_number: iI)[0].status == 'done')
          iI += 1
          next
        end
        @orderHash = Order.all.where(order_number: iI)
        @clients_db = Client.all.where(id: @orderHash[0].client_id)
        @finalOrder = {
          client: [@clients_db[0].name, @clients_db[0].adress, @clients_db[0].phone],
          orderNumber: @orderHash[0].order_number,
          createdAt: @orderHash[0].created_at,
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

  def updateStatus
    orderNumber = params.permit(:numberOrder)[:numberOrder].to_i
    case Order.all.where(order_number: orderNumber)[0].status
    when 'processed'
      update_new('prepare', orderNumber)
    when 'prepare'
      update_new('done', orderNumber)
    else
      render status: 409
    end
    redirect_to controller: 'orders', action: 'show'
  end

  def update_new(status_new, orderNumber)
    ord = Order.all.where(order_number: orderNumber)
    ord.each do |elem|
      elem.update(status: status_new)
    end
  end

end
