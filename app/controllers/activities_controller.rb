class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def index
    activities = Activity.all
    render json: activities, status: :ok, each_serializer: ActivitySerializer
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
  end

  private

  def record_not_found
    render json: {"error": "Activity not found"}, status: :not_found
  end
end
