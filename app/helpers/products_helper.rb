module ProductsHelper
  def widths
    (115..325).step(5).map { |w| [w, w] }.reverse
  end

  def heights
    (25..85).step(5).map { |h| [h, h] }.reverse
  end

  def diameters
    (12..22).step(1).map { |d| [sprintf('%g', d), sprintf('%g', d)] }
  end

  def truck_diameters
    (17..22.5).step(0.5).map { |d| [sprintf('%g', d), sprintf('%g', d)] }
  end

  def all_diameters
    (diameters + truck_diameters).uniq
  end

  def dimensions
    TireDimension.all.map { |d| [d.dimension, d.dimension] }
  end
end
