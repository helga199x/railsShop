class OrdersController < ApplicationController

    def show
        @orders_db = Order.all

        @finalOrderArray = []
        iI = 1
        while ((@orderHash = Order.all.where(order_number: iI)[0]) != nil)
            @orderHash = Order.all.where(order_number: iI)
            @finalOrder = {
                client: @orderHash[0].id_client,
                orderNumber: @orderHash[0].order_number,
                createdAt: @orderHash[0].created_at,
                totalPrice: [],
                good: [],
                amount: []
            }
            i = 0
            while i < @orderHash.length
                @finalOrder[:totalPrice].push(@orderHash[i].amount.to_i * @orderHash[i].price.to_i)
                @finalOrder[:good].push(@orderHash[i].id_good)
                @finalOrder[:amount].push(@orderHash[i].amount)
                i += 1
            end
            @finalOrderArray.push(@finalOrder)

            iI += 1
        end

    end


end
