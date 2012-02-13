class UasController < ApplicationController
  # GET /uas
  # GET /uas.json
  def index
    @uas = Ua.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uas }
    end
  end

  # GET /uas/1
  # GET /uas/1.json
  def show
    @ua = Ua.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ua }
    end
  end

  # GET /uas/new
  # GET /uas/new.json
  def new
    @ua = Ua.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ua }
    end
  end

  # GET /uas/1/edit
  def edit
    @ua = Ua.find(params[:id])
  end

  # POST /uas
  # POST /uas.json
  def create
    @ua = Ua.new(params[:ua])

    respond_to do |format|
      if @ua.save
        format.html { redirect_to @ua, notice: 'Ua was successfully created.' }
        format.json { render json: @ua, status: :created, location: @ua }
      else
        format.html { render action: "new" }
        format.json { render json: @ua.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uas/1
  # PUT /uas/1.json
  def update
    @ua = Ua.find(params[:id])

    respond_to do |format|
      if @ua.update_attributes(params[:ua])
        format.html { redirect_to @ua, notice: 'Ua was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ua.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uas/1
  # DELETE /uas/1.json
  def destroy
    @ua = Ua.find(params[:id])
    @ua.destroy

    respond_to do |format|
      format.html { redirect_to uas_url }
      format.json { head :no_content }
    end
  end
end
