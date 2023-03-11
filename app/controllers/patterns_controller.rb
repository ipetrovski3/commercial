class PatternsController < ApplicationController

  def index
    @patterns = Pattern.all
  end

  def new
    @pattern = Pattern.new
  end

  def create
    @pattern = Pattern.new(pattern_params)
    if @pattern.save
      respond_to do |format|
        format.turbo_stream
      end
      redirect_to patterns_path
    else
      render :new
    end
  end

  private

  def pattern_params
    params.require(:pattern).permit(:name, :brand_id, :season)
  end
end
