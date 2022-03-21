class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid

  # GET /apartments
  def index
    render json: Apartment.all
  end

  # GET /apartments/:id
  def show
    apt = find_apartment
    render json: apt
    #OR
    # render json: apartment_params
  end

  # POST /apartment
  def create
    apt = Apartment.create!(apartment_params)
    render json: apt, status: :created
  end

  # PATCH /apartments/:id
  def update
    apt = find_apartment
    apt.update(apartment_params)
    render json: apt, status: :ok
    # render json: apt.update(apartment_params), status: :accepted
    #OR
    # render json: find_apartment.update(apartment_params)
  end

  # DELETE /apartments/:id
  def destroy
    apt = find_apartment
    apt.destroy
    head :no_content
    # render json: {}
  end


  private 

  def find_apartment
    Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def not_found(exception)
    render json: {errors: exception.message}, status: :not_found
    # render json: {errors: "can't find it"}, status: :not_found
  end

  def handle_invalid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end


  # def not_found(error)
  #   render json: {errors: "#{error.model} Not Found"}, status: :not_found
  # end
end
