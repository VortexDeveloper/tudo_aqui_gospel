class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  before_action only: [:edit, :update, :destroy] do
    authenticate_current_user(current_user != @publication.author)
  end
  # 
  # before_action :is_active?, only: [:index, :show, :new, :create]
  #
  # def is_active?
  #   redirect_to root_path, notice: 'Conteúdo não autorizado você precisa assinar nosso portal para acessar essa area!' unless current_user.active? || current_user.has_role?("Columnist")
  # end

  # GET /publications
  # GET /publications.json
  #autenticar current user
  def index
    @publications = Publication.where(author_id: current_user.id).paginate(page: params[:page], per_page: 4)
    @lastest_news = Publication.latest_news
    # authorize! :manage, @publications
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @lastest_news = Publication.latest_news
  end

  # GET /publications/new
  #só para colunista #autenticar current user
  def new
    @publication = Publication.new
    @pub_attachment = PubAttachment.new
  end

  # GET /publications/1/edit
  #só para colunista #autenticar current user
  def edit
    @pub_attachment = PubAttachment.new
  end

  # POST /publications
  # POST /publications.json
  #só para colunista #autenticar current user
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
  #só para colunista #autenticar current user
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
  #só para colunista #autenticar current user
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

  # def authenticate_current_user
  #   authenticate_user!
  #   redirect_to after_sign_in_path_for(current_user), notice: 'Você não está autorizado a acessar esta página.' if current_user != @publication.author
  # end
end
