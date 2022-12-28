module CustomersHelper
  def sort_link(column:, label:)
    link_to(
      label,
      list_customers_path(
        column: column,
        direction: params[:direction] == 'asc' ? 'desc' : 'asc'
      )
    )
  end

  def sort_indicator
    tag.span(class: "sort sort-#{params[:direction]}")
  end
end
