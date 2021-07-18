class MainController < ApplicationController
    def index
        @good = Good.all.where(insale: true)
    end

    def create
        clients = Client.all
        statusIn = "processed"
        iI = 0
        clientID = 0
        clientP = params.permit(:name, :phone, :adress)
        while (iI < clients.length || iI == 0) && (params.permit(goodT:{})[:goodT] != nil)
            if (clients.length == 0)
                newClient = Client.create(
                    name: clientP[:name].to_s, 
                    phone: clientP[:phone].to_s, 
                    adress: clientP[:adress].to_s
                )
                clientID = newClient.id
                break
            elsif (clients[iI].name == clientP[:name] && clients[iI].phone == clientP[:phone] && clients[iI].adress == clientP[:adress])
                clientID = clients[iI].id
                statusIn = "prepare"
                break
            elsif (iI+1 == clients.length)
                newClient = Client.create(
                    name: clientP[:name].to_s, 
                    phone: clientP[:phone].to_s, 
                    adress: clientP[:adress].to_s
                )
                clientID = newClient.id
                break
            end
            iI += 1
        end
        
        i = 0
        orderNum = 1
        orderT = Order.all
        orderNumLast = 0
        if (orderT[0] != nil)
            orderNumLast = orderT.last[:order_number]
        elsif (orderT[0] == nil)
            orderNumLast = 0
        end
        while i < params.permit(goodT:{})[:goodT].to_h.length.to_i
            goodObj = params.permit(goodT:{})[:goodT]["#{i}"]
            if (clients.length == 0)
                orderNum = 1;
            else
                orderNum = orderNumLast + 1
            end
            Order.create(
                client_id: clientID.to_i, 
                good_id: goodObj[:good_id].to_i, 
                amount: goodObj[:amount].to_s, 
                price: goodObj[:price].to_s, 
                order_number: orderNum,
                status: statusIn
            )
            i += 1
        end
        redirect_to :controller => 'main', 
                    :action => 'accepted', 
                    :client => clientID, 
                    :order => params.permit(goodT:{})[:goodT].to_h.length
    end

    def accepted
        if ((params[:client].to_i != 0) && (params[:order].to_i != 0))
            render :accepted
        else
            render :not_accepted
        end
    end
end
