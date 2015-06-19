module Trough
  class DocumentUsagesController < ApplicationController

    before_action :find_document

    layout false

    def links
      @document_usages = @document.document_usages.
        active.includes(:content_package)
    end

    def stats
      @document_usages = @document.document_usages.includes(:content_package)
    end

    private

      def find_document
        @document = Document.
          includes(:document_usages).find(params[:document_id])
        authorize! :edit, @document
      end

  end
end
