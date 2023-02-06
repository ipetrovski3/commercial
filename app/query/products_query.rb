class ProductsQuery
  attr_reader :params, :resources

  def initialize(params, resources = Product.all)
    @params = params
    @resources = resources
  end

  def filter
    @resources = filter_by_location
    @resources = filter_by_seasons
    @resources = filter_by_brands
    @resources
  end

  private

  def filter_by_location
    return resources unless params[:location].present?

    resources.where(location: params[:location])
  end

  def filter_by_seasons
    return resources unless params[:seasons].present?

    resources.includes(:pattern).where(patterns: { season: params[:seasons] })
  end

  def filter_by_brands
    return resources unless params[:brands].present?

    resources.includes(:pattern).where(patterns: { brand_id: params[:brands] })
  end
end
