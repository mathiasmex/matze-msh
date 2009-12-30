class PagesController < ApplicationController
  def home
	@title = "Start"
  end

  def contact
	@title = "Kontakt"
  end

  def about
	@title = "Über mich"
  end

end
