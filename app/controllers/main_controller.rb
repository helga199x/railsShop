class MainController < ApplicationController
    def index
        @good = Good.all
    end

    def create
        binding.pry
        @permited_params = params.permit(:name, :phone, :adress, :id_good, :amount, :price).to_h
        @clie = Client.create(prepare_params(%w(name phone adress)))
        @orde = Order.create(prepare_params(%w(id_good amount price)))
    end

    def new
    end

    private
    def prepare_params(name_arr)
        @permited_params.slice(*name_arr)
    end
end
