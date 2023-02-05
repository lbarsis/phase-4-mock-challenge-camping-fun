class CampersController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    campers = Camper.all
    render json: campers
  end
  
  def show
    find_camper
    render json: @camper, serializer: CamperIdSerializer, status: :ok
  end

  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

  def find_camper
    @camper = Camper.find(params[:id])
  end

  def record_not_found
    render json: { error: "Camper not found" }, status: :not_found
  end

  def record_invalid(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
  end
end
