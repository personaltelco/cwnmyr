# frozen_string_literal: true

# This controller allows management of Device records.
class DevicesController < ApplicationController
  before_action :authenticate_user!,
                except: %i[show conf build_config postbuild prebuild graph]
  after_action :verify_authorized

  def show
    @device = authorize Device.find(params[:id])
  end

  def conf
    show
  end

  def build
    @device = authorize Device.find(params[:id])
    try_build if @device.can_build?
    redirect_to @device
  end

  def new
    @device = authorize Device.new(node_id: params[:node])
  end

  def create
    @device = authorize Device.new(safe_params)
    save_and_respond @device, :created, :create_success
  end

  def edit
    @device = authorize Device.find(params[:id])
  end

  def update
    @device = authorize Device.find(params[:id])
    @device.assign_attributes(safe_params)
    save_and_respond @device, :ok, :update_success
  end

  def destroy
    @device = authorize Device.find(params[:id])
    destroy_and_respond @device, @device.node
  end

  def build_config
    show
    render plain: @device.device_type.config
  end

  def postbuild
    show
    render plain: @device.device_type.postbuild
  end

  def prebuild
    show
    render plain: @device.device_type.prebuild
  end

  def graph
    @device = authorize Device.find(params[:id])

    respond_to do |format|
      format.png do
        send_data @device.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def safe_params
    params.require(:device).permit(
      :node_id, :name, :device_type_id, :body,
      interfaces_attributes: %i[
        id code name network_id address_ipv6 address_ipv4 address_mac
        _destroy
      ],
      device_properties_attributes: %i[id key value _destroy]
    )
  end

  def try_build
    provider = @device&.device_type&.build_provider
    if provider&.build(@device, device_url(@device))
      flash[:notice] = 'Build started.'
    else
      flash[:warning] = 'Build not available.'
    end
  end
end
