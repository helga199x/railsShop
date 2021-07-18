class AdminsController < ApplicationController
    def admin
        
    end

    def orders
        @finalOrderArray = []
        iI = 1
        while ((@orderHash = Order.all.where(order_number: iI)[0]) != nil)
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

    def goods
        @good = Good.all
    end

    def create
        binding.pry
        Good.create(good_params)
        redirect_to "/admin/goods"
    end

    def destroy
        Good.where(id: params[:id]).first.destroy
        redirect_to "/admin/goods"
    end

    def update
        Good.where(id: params[:id])
        .update(good_params)
        redirect_to "/admin/goods"
    end

    def good_params
        params.permit(:name, :price, :weight, :discription, :insale, :category, :img)
    end

end
