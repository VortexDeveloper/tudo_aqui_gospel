class PubAttachmentsController < ApplicationController
  before_action :set_pub_attachment, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /pub_attachments
  # GET /pub_attachments.json
  def index
    @pub_attachments = PubAttachment.all
  end

  # GET /pub_attachments/1
  # GET /pub_attachments/1.json
  def show
  end

  # GET /pub_attachments/new
  def new
    @pub_attachment = PubAttachment.new
  end

  # GET /pub_attachments/1/edit
  def edit
  end

  # POST /pub_attachments
  # POST /pub_attachments.json
  def create
    @pub_attachment = PubAttachment.new(pub_attachment_params)

    respond_to do |format|
      if @pub_attachment.save
        format.html { redirect_to root_path, notice: 'Pub attachment was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /pub_attachments/1
  # PATCH/PUT /pub_attachments/1.json
  def update
    respond_to do |format|
      if @pub_attachment.update(pub_attachment_params)
        format.html { redirect_to root_path, notice: 'Pub attachment was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  # DELETE /pub_attachments/1
  # DELETE /pub_attachments/1.json
  def destroy
    @pub_attachment.destroy
    respond_to do |format|
      format.js { head :ok, notice: 'Anexo excluído com sucesso.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pub_attachment
      @pub_attachment = PubAttachment.find(params[:id])
    end

    def pub_attachment_params
      params.require(:pub_attachment).permit(
      :file,
      :publication_id
      )
    end

end
