class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]
  before_action :set_nationality
  def index
    @pagy, @clients = pagy(extract_client, items: per_page)
  end

  def show
    @pagy, @projects = pagy(@client.projects, items: per_page)
  end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def set_nationality
    @clients = Client.all

    @clients.each do |client|
      n = client.address.split(',')[-1]
      client.update_columns(nationality: n)
    end
  end

  def client_params
    params.require(:client).permit(:name, :address, :hq)
  end

  def extract_client
    return Client.search(params[:search]) if params[:search]

    Client.order(id: :desc)
  end
end
