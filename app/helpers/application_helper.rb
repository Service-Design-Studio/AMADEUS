module ApplicationHelper

    def side_bar_visible()
        # if url starts with /admin or /admin/
        if request.path.start_with?("/admin")
            return false
        end
        return true
    end

    def set_sidebar_category_selected(selected_category_name, category_name)
        if selected_category_name == ""
            return "custom-category"
        else
            if selected_category_name == category_name
                return "custom-category-selected btn-outline-primary"
            else
                return "custom-category"
            end
        end
    end

end
