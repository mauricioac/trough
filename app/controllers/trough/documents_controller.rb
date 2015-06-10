module Trough
  class DocumentsController < ApplicationController

    load_and_authorize_resource
    skip_load_resource :only => [:show, :destroy]

    def index
      @document = Document.new
      @documents = Document.all.order(:slug)
    end

    def new
    end

    def create
      if @document.save
        if @document.url.blank?
          f = @document.attachment.name
          f.slice! ".#{@document.attachment.ext}"
          @document.update(slug: nil, url: f)
        end
      end
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
      @document = Document.friendly.find(params[:id])
      send_file @document.attachment.file, filename: "#{@document.url}.#{@document.attachment.ext}"
    end

    private
    def document_params
      params.require(:document).permit(:attachment_uid, :attachment, :url)
    end
  end
end