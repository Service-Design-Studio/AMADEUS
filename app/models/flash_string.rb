module FlashString
  TO_LOGIN = "You must be logged in to access this section"
  DELETED = "Successfully deleted!"

  class CategoryString
    CATEGORY_EMPTY = "No categories found!"
  end

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

    def self.get_updated_tag(old_tag, new_tag)
      "%{old} updated into %{new}." % {old: old_tag, new: new_tag}
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

    def self.get_space(tag)
      "Tag %{tag} starts or ends with a space!" % {tag: tag}
    end
  end
end