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

  def service
	@title = "Webdienste"
  end

  def reference
	@title = "Referenzen"
  end

  def news
	@title = "Aktuelles"
  end

  def impressum
	@title = "Impressum"
  end

end
