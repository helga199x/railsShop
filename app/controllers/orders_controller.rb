class OrdersController < ApplicationController

    def show
        @finalOrderArray = []
        iI = 1
        while ((@orderHash = Order.all.where(order_number: iI)[0]) != nil)
            if (@orderHash.status == "done")
                iI += 1
                next  
            end
            @orderHash = Order.all.where(order_number: iI)
            @clients_db = Client.all.where(id: @orderHash[0].id_client)
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
                @goods_db = Good.all.where(id: @orderHash[i].id_good)
                @finalOrder[:totalPrice].push(@orderHash[i].amount.to_i * @orderHash[i].price.to_i)
                @finalOrder[:good].push(@goods_db[0].name)
                @finalOrder[:amount].push(@orderHash[i].amount)
                i += 1
            end
            @finalOrderArray.push(@finalOrder)
            iI += 1
        end
    end

    def updateStatus
        orderNumber = params.permit(:numberOrder)[:numberOrder].to_i
        if (Order.all.where(order_number: orderNumber)[0].status == 'processed')
            ord = Order.all.where(order_number: orderNumber)
            ord.each do |elem|
                elem.update(status: "prepare")
            end
        elsif (Order.all.where(order_number: orderNumber)[0].status == 'prepare')
            ord = Order.all.where(order_number: orderNumber)
            ord.each do |elem|
                elem.update(status: "done")
            end
        end
        redirect_to :controller => 'orders', :action => 'show'
    end


end
