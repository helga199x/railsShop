class MainController < ApplicationController
    def index
        @good = Good.all
    end

    def create
        binding.pry
        @permited_params = params.permit(:name, :phone, :adress, :id_good, :amount, :price).to_h
        @clie = Client.create(prepare_params(['name', 'phone', 'adress'])) 
        someI = 0;
        while someI < params.permit(goodT:{})[:goodT].to_h.length.to_i
            goodObj = params.permit(goodT:{})[:goodT]["#{someI}"]
            @orde = Order.create(id_good: goodObj[:id_good].to_i, amount: goodObj[:amount].to_s, price: goodObj[:price].to_s)
            someI += 1
        end
    end

    def new
    end

    def prepare_params(name_arr)
        @permited_params.slice(*name_arr)
    end
end
