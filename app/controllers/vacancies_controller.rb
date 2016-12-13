class VacanciesController < ApplicationController
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /vacancies
  # GET /vacancies.json
  def index
    @vacancies = Vacancy.all
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
  end

  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new
  end

  # GET /vacancies/1/edit
  def edit
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    announcer = Announcer.where("user_id = ?", current_user.id).first
    @vacancy = Vacancy.new(vacancy_params)

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to edit_announcer_path(announcer), notice: 'Vaga cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  # PATCH/PUT /vacancies/1.json
  def update
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to @vacancy, notice: 'Vaga atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    announcer = Announcer.where("user_id = ?", current_user.id).first
    @vacancy.destroy
    respond_to do |format|
      format.js { head :ok, notice: 'Vaga excluída com sucesso.' }
      format.html { redirect_to edit_announcer_path(announcer), notice: 'Vaga excluída com sucesso.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacancy_params
      params.require(:vacancy).permit(
      :name,
      :description,
      :announcer_id
      )
    end
end
