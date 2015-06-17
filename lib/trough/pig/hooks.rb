module Trough
  module Pig
    module Hooks
      def update_document_usages
        changed_chunks = content_chunks.select do |content_chunk|
          content_chunk.changed? && content_chunk.content_attribute.field_type.in?(%w(document rich_content))
        end

        changed_chunks.each do |changed_chunk|
          send("determine_#{changed_chunk.content_attribute.field_type}_change", changed_chunk)
        end
      end

      def determine_document_change(content_chunk)
        if content_chunk.value_was.present?
          document_usage = DocumentUsage.where(trough_document_id: content_chunk.value_was,
                                               pig_content_package_id: content_chunk.content_package.id).first
          document_usage.deactivate! if document_usage
        end
        if content_chunk.value.present?
          document_usage = DocumentUsage.find_or_initialize_by(trough_document_id: content_chunk.value, pig_content_package_id: content_chunk.content_package.id)
          document_usage.active = true
          document_usage.save
        end
      end

      def determine_rich_content_change(_content_chunk)
        # TODO: make this look at the old and new values, find additions / removals and
        # create / update DocumentUsage as appropriate
      end
    end
  end
end
