class ConfsController < ApplicationController
  # GET /confs
  # GET /confs.json
  def index
    @confs = Conf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @confs }
    end
  end

  # GET /confs/1
  # GET /confs/1.json
  def show
    @conf = Conf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conf }
    end
  end

  # GET /confs/new
  # GET /confs/new.json
  def new
    @conf = Conf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conf }
    end
  end

  # GET /confs/1/edit
  def edit
    @conf = Conf.find(params[:id])
  end

  # POST /confs
  # POST /confs.json
  def create
    @conf = Conf.new(params[:conf])

    respond_to do |format|
      if @conf.save
        format.html { redirect_to @conf, notice: 'Conf was successfully created.' }
        format.json { render json: @conf, status: :created, location: @conf }
      else
        format.html { render action: "new" }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /confs/1
  # PUT /confs/1.json
  def update
    @conf = Conf.find(params[:id])

    respond_to do |format|
      if @conf.update_attributes(params[:conf])
        format.html { redirect_to @conf, notice: 'Conf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confs/1
  # DELETE /confs/1.json
  def destroy
    @conf = Conf.find(params[:id])
    @conf.destroy

    respond_to do |format|
      format.html { redirect_to confs_url }
      format.json { head :no_content }
    end
  end
end
