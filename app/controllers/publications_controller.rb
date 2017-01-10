class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.where(author_id: current_user.id).paginate(page: params[:page], per_page: 4)
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
    @pub_attachment = PubAttachment.new
  end

  # GET /publications/1/edit
  def edit
    @pub_attachment = PubAttachment.new
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)
    @publication.knowledge_area = KnowledgeArea.find knowledge_params[:knowledge_area]
    @publication.author = current_user

    respond_to do |format|
      if @publication.save
        @publication.create_attachments(params[:file])
        format.html { redirect_to @publication, notice: 'Publicação cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        @publication.create_attachments(params[:file])
        format.html { redirect_to @publication, notice: 'Publicação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.js { head :ok, notice: 'Publicação excluída com sucesso.' }
      format.html { redirect_to publications_url, notice: 'Publicação excluída com sucesso.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title, :pub_category, :description, :body, :image, :pub_type)
    end

    def knowledge_params
      params.require(:publication).permit(:knowledge_area)
    end
end
