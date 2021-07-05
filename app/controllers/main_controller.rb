class MainController < ApplicationController
    def index
        @good = Good.all
    end
end