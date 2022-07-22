class MainController < ApplicationController
    def index
        # sort all categories by their name in ascending order
        @categories = Category.all.sort_by { |category| category.name }
        @category = nil

        if params[:category] == "" || params[:category].nil?
            @selected_category = ""
            # if no category is selected, show all uploads in descending order according to their created_at
            @uploads = Upload.all.reverse
        else
            @selected_category = params[:category]
            @category = Category.find_by(name: @selected_category)

            # get all the uploads that are of @category.name and sort by its creation date in descending order
            @uploads = @category.uploads.sort_by { |upload| upload.created_at }.reverse

        end
    end
end