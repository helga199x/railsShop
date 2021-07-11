class MainController < ApplicationController
    def index
        @good = Good.all
    end

    def create     
        clients = Client.all
        iI = 0
        clientID = 0
        clientP = params.permit(:name, :phone, :adress)
        while iI < clients.length || iI == 0
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

        i = 0;
        orderNum = 1;
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
                id_client: clientID.to_i, 
                id_good: goodObj[:id_good].to_i, 
                amount: goodObj[:amount].to_s, 
                price: goodObj[:price].to_s, 
                order_number: orderNum
            )
            i += 1
        end
    end

    def new

    end
end
