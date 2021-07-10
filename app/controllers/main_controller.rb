class MainController < ApplicationController
    def index
        @good = Good.all
    end

    def create
        binding.pry
        clientP = params.permit(:name, :phone, :adress)
        clients = Client.all
        iI = 0
        clientID = 0
        while iI < clients.length
            if (clients[iI].name == clientP[:name] && clients[iI].phone == clientP[:phone] && clients[iI].adress == clientP[:adress])
                clientID = clients[iI].id
                break
            end
            if (iI < clients.length+1)
                newClient = Client.create(name: clientP[:name].to_s, phone: clientP[:phone].to_s, adress: clientP[:adress].to_s)
                clientID = newClient.id
                break
            end
            iI += 1
        end

        i = 0;
        while i < params.permit(goodT:{})[:goodT].to_h.length.to_i
            goodObj = params.permit(goodT:{})[:goodT]["#{i}"]
            Order.create(id_client: clientID.to_i, id_good: goodObj[:id_good].to_i, amount: goodObj[:amount].to_s, price: goodObj[:price].to_s)
            i += 1
        end

    end

    def new

    end
end