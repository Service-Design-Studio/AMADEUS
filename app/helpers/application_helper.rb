module ApplicationHelper

    def side_bar_visible()
        # if url starts with /admin or /admin/
        if request.path.start_with?("/admin")
            return false
        end
        return true
    end

end
