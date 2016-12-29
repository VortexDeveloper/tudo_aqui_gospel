class TelephonesController < ApplicationController
  before_action :set_telephone, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /telephones
  # GET /telephones.json
  def index
    @telephones = Telephone.all
  end

  # GET /telephones/1
  # GET /telephones/1.json
  def show
  end

  # GET /telephones/new
  def new
    @telephone = Telephone.new
  end

  # GET /telephones/1/edit
  def edit
  end

  # POST /telephones
  # POST /telephones.json
  def create
    personal_profile = current_user.profile
    @telephone = Telephone.new(telephone_params)
    personal_profile.telephones << @telephone

    respond_to do |format|
      if @telephone.save
        format.html { redirect_to personal_profiles_edit_path(personal_profile), notice: 'Telefone adicionado com sucesso!' }
        format.json { render :show, status: :created, location: @telephone }
      else
        format.html { redirect_to personal_profiles_edit_path(personal_profile), notice: 'Telefone adicionado com sucesso!' }
        format.json { render json: @telephone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /telephones/1
  # PATCH/PUT /telephones/1.json
  def update
    personal_profile = current_user.profile
    respond_to do |format|
      if @telephone.update(telephone_params)
        format.html { redirect_to personal_profiles_edit_path(personal_profile), notice: 'Telefone atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @telephone }
      else
        format.html { redirect_to personal_profiles_edit_path(personal_profile), notice: 'Telefone atualizado com sucesso!' }
        format.json { render json: @telephone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /telephones/1
  # DELETE /telephones/1.json
  def destroy
    personal_profile = current_user.profile
    @phonebook = @telephone.phonebooks.where(personal_profile_id: personal_profile.id).first
    @phonebook.destroy
    @telephone.destroy
    respond_to do |format|
      format.html { redirect_to personal_profiles_edit_path(personal_profile), notice: 'Telefone excluído com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_telephone
      @telephone = Telephone.find(params[:id])
    end

    def telephone_params
      params.require(:telephone).permit(
      :number
      )
    end
end
