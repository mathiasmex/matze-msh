module ScreencastsHelper

  def categories
    @categories ||= Category.all
  end

  def manufacturers
    @manufacturers ||= Manufacturer.all
  end

  def formats
    @formats ||= Format.all
  end

  def format_price_in_euro(price)
    "%0.2f EUR" % (price * 0.01)
  end

end
