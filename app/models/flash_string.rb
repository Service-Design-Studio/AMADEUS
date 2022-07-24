module FlashString
  TO_LOGIN = "You must be logged in to access this section"
  DELETED = "Successfully deleted!"

  class UploadString
    UPLOAD_DELETED = "Upload deleted!"
    UPLOAD_SOME_FAILED = "Some pdfs failed to be parse!"
  end

  class TagString
    INVALID_TAG = "Invalid tag input!"
    LENGTHY_TAG = "Tag name too long!"
    def self.get_added_tag(tag)
      "%{tag} added." % {tag:tag}
    end

    def self.get_deleted_tag(tag)
      "Deleted %{tag}." % {tag: tag}
    end

    def self.get_duplicate_tag(tag)
      "Tag %{tag} already exists!" % {tag: tag}
    end

    def self.get_special_characters(tag)
      "Tag %{tag} contains special characters!" % {tag: tag}
    end
  end

  class CategoryString
    INVALID_CAT = "Invalid category input!"
    LENGTHY_CAT = "Category name too long!"
    def self.get_added_category(category)
      "Category %{category} set." % {category:category}
    end

    def self.get_deleted_category(category)
      "Deleted %{category}." % {category: category}
    end

    def self.get_duplicate_category(category)
      "Category %{category} already exists!" % {category: category}
    end

    def self.get_special_characters(category)
      "Category %{category} contains special characters!" % {category: category}
    end
  end
end