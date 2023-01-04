class HotelsController < ApplicationController
  def index
    @hotels = Hotel.in_hotel
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      redirect_to hotels_path
    else
      render :new
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "hotel_#{params[:id]}",
               template: 'hotels/pdf',
               layout: 'hotel_pdf',
               formats: [:html],
               encoding: 'UTF-8'
      end
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    if @hotel.update(hotel_params)
      redirect_to hotels_path
    else
      render :edit
    end
  end

  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    redirect_to hotels_path
  end

  private

  def hotel_params
    params.require(:hotel)
          .permit(
            :customer_id,
            :car_model,
            :licence_plate,
            :with_wheels,
            :date_in,
            :date_out,
            tire_hotels_attributes: %i[id hotel_id season tire qty _destroy]
          ).merge(date_in: Date.today)
  end
end
