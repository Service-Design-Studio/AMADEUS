module FlashString
  TO_LOGIN = "You must be logged in to access this section"

  class UploadString
    UPLOAD_DELETED = "Upload deleted!"
    UPLOAD_SOME_FAILED = "Some pdfs failed to be parse!"
  end

  class UploadLinkString
    DELETED_TOPIC = "Successfully deleted!"
  end

  class TopicString
    INVALID_TOPIC = "Invalid topic input!"
    LENGTHY_TOPIC = "Topic name too long!"
    def self.get_added_topic(topic)
      "%{topic} added." % {topic:topic}
    end

    def self.get_updated_tag(old_tag, new_tag)
      "%{old} updated into %{new}." % {old: old_tag, new: new_tag}
    end

    def self.get_deleted_topic(topic)
      "Deleted %{topic}." % {topic: topic}
    end
    def self.get_duplicate_topic(topic)
      "Topic %{topic} already exists!" % {topic: topic}
    end
    def self.get_special_characters(topic)
      "Topic %{topic} contains special characters!" % {topic: topic}
    end

    def self.get_space(topic)
      "Topic %{topic} starts or ends with a space!" % {topic: topic}
    end
  end
end