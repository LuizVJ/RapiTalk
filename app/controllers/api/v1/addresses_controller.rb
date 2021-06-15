class Api::V1::AddressesController < Api::V1::ApiController

  before_action :set_address, only: [:show, :update, :destroy]
  before_action :require_authorization!, only: [:show, :update, :destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @addresses = pagy( current_user.contacts.joins(:addresses).select('addresses.*') )
    render json: @addresses
  end

  def show
    render json: @address
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address, status: :created
    else 
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def update 
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
  end

  private
    
    def address_params
      params.require(:address).permit(:street, :number, :cep, :contact_id)
    end

    def set_address 
      @address = Address.find(params[:id])
    end

    def require_authorization! 
      unless current_user == @address.contact.user
        render json: {}, status: :forbidden
      end
    end

end