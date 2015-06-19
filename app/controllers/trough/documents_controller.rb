module Trough
  class DocumentsController < ApplicationController

    load_and_authorize_resource
    skip_load_resource :only => [:show, :destroy]

    before_action :prepare_new_document, only: [:index, :search]

    def index
      @documents = Document.include_meta.all.order(:slug)
    end

    def search
      @documents = Document.include_meta.search(params[:term]).order(:slug)
      render :index
    end

    def autocomplete
      render json: Document.search(params[:term]).pluck(:slug).to_json
    end

    def new
    end

    def create
      @new_document = true
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

      def prepare_new_document
        @document = Document.new
      end
  end
end
