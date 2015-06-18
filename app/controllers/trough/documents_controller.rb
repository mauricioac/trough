module Trough
  class DocumentsController < ApplicationController

    load_and_authorize_resource
    skip_load_resource :only => [:show, :destroy]

    def index
      @document = Document.new
      @documents = Document.
        select("trough_documents.*, 
               (SELECT COUNT(*) FROM trough_document_usages WHERE (trough_document_usages.trough_document_id = trough_documents.id AND trough_document_usages.active = 't')) AS active_document_usage_count,
               (SELECT SUM(trough_document_usages.download_count) FROM trough_document_usages WHERE (trough_document_usages.trough_document_id = trough_documents.id)) AS downloads_count").
        all.
        order(:slug)
    end

    def new
    end

    def create
      @document.save
      logger.info @document.errors.messages
    end

    def destroy
      @document = Document.friendly.find(params[:id])
      @d_id = @document.attributes["id"]
      @document.destroy
    end

    def edit
    end

    def update
    end

    def show
      @document = Document.find_by(slug: params[:id])
      redirect_to @document.s3_url
    end

    def modal
      @documents = Document.all
      @document = Document.new
      render :layout => false
    end

    def modal_create
      @document = Document.new(document_params)
      @document.uploader = current_user
      @document.save
      logger.info @document.errors.messages
    end

    private
    def document_params
      params.require(:document).permit(:file, :slug, :description, :uploader)
    end
  end
end
