class MainController < ApplicationController
    def index
        # sort all categories by their name in ascending order
        @categories = Category.all.sort_by { |category| category.name }
        @category = @categories.first
    end

    private
    def flash_message
        FlashString::MainString
    end
end