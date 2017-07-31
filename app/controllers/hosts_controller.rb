# This controller allows management of Host records.
class HostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show graph]
  after_action :verify_authorized

  def show
    @host = Host.find(params[:id])
    authorize @host
  end

  def new
    @host = Host.new node_id: params[:node]
    authorize @host
  end

  def create
    @host = Host.new(host_params)
    authorize @host
    save_and_respond @host, :created, :create_success
  end

  def edit
    @host = Host.find(params[:id])
    authorize @host
  end

  def update
    @host = Host.find(params[:id])
    @host.assign_attributes(host_params)
    authorize @host
    save_and_respond @host, :ok, :update_success
  end

  def destroy
    @host = Host.find(params[:id])
    authorize @host
    destroy_and_respond @host, @host.node
  end

  def graph
    @host = Host.find(params[:id])
    authorize @host

    respond_to do |format|
      format.png do
        send_data @host.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def host_params
    params.require(:host).permit(:node_id, :name, :status_id)
  end
end
