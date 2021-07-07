class OrdersController < ApplicationController
    def show
        @clients_db = Client.all
    end
end
