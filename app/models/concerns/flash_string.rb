module FlashString
  TO_LOGIN = "You must be logged in to access this section"
  DELETED = "Successfully deleted!"

  class UploadString
    UPLOAD_DELETED = "Upload deleted!"
    UPLOAD_SOME_FAILED = "Some pdfs failed to be parse!"
  end

  class SummaryString
    INVALID_SUMMARY = "Summary cannot be blank, and must be between 10 to 100 words."
    SUMMARY_UPDATED = "Summary updated!"
  end

  class TagString
    INVALID_TAG = "Tag cannot be blank or contain special characters and must be less than 15 characters."
    def self.get_new_added_tag(tag, tag_type)
      "Added new tag %{tag} under type %{tag_type}." % {tag: tag, tag_type: tag_type}
    end

    def self.get_existing_added_tag(tag, tag_type)
      "Added existing tag %{tag} under type %{tag_type}." % {tag: tag, tag_type: tag_type}
    end

    def self.get_deleted_tag(tag)
      "Deleted tag %{tag}." % {tag: tag}
    end

    def self.get_duplicate_tag(tag)
      "%{tag} already added to this article!" % {tag: tag}
    end

    def self.get_duplicated_tag_name(tag, tag_type)
      "%{tag} already exists in database under type %{tag_type}!" % {tag: tag, tag_type: tag_type}
    end

  end

  class CategoryString
    INVALID_CAT = "Category cannot be blank or contain special characters and must be less than 30 characters."
    def self.get_added_category(category)
      "Set new category: %{category}." % {category:category}
    end

    def self.get_linked_category(category)
      "Replaced with existing category: %{category}." % {category:category}
    end

    def self.get_deleted_category(category)
      "Deleted %{category}." % {category: category}
    end

    def self.get_duplicate_category(category)
      "Category %{category} already exists!" % {category: category}
    end

    def self.get_already_assigned_category(category)
      "No change!" % {category: category}
    end
  end
end