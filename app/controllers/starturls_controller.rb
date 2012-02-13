class StarturlsController < ApplicationController
  # GET /starturls
  # GET /starturls.json
  def index
    @starturls = Starturl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @starturls }
    end
  end

  # GET /starturls/1
  # GET /starturls/1.json
  def show
    @starturl = Starturl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @starturl }
    end
  end

  # GET /starturls/new
  # GET /starturls/new.json
  def new
    @starturl = Starturl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @starturl }
    end
  end

  # GET /starturls/1/edit
  def edit
    @starturl = Starturl.find(params[:id])
  end

  # POST /starturls
  # POST /starturls.json
  def create
    @starturl = Starturl.new(params[:starturl])

    respond_to do |format|
      if @starturl.save
        format.html { redirect_to @starturl, notice: 'Starturl was successfully created.' }
        format.json { render json: @starturl, status: :created, location: @starturl }
      else
        format.html { render action: "new" }
        format.json { render json: @starturl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /starturls/1
  # PUT /starturls/1.json
  def update
    @starturl = Starturl.find(params[:id])

    respond_to do |format|
      if @starturl.update_attributes(params[:starturl])
        format.html { redirect_to @starturl, notice: 'Starturl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @starturl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /starturls/1
  # DELETE /starturls/1.json
  def destroy
    @starturl = Starturl.find(params[:id])
    @starturl.destroy

    respond_to do |format|
      format.html { redirect_to starturls_url }
      format.json { head :no_content }
    end
  end
end
