class PagesController < ApplicationController
  def home
	@title = "Start"
	@page_id = ''
  end

  def contact
	@title = "Kontakt"
	@page_id = 'contact'
  end

  def about
	@title = "Über mich"
	@page_id = 'about'
  end

  def service
	@title = "Webdienste"
	@page_id = 'service'
  end

  def reference
	@title = "Referenzen"
	@page_id = 'reference'
  end

  def news
	@title = "Aktuelles"
	@page_id = 'news'
  end

  def impressum
	@title = "Impressum"
	@page_id = 'impressum'
  end

end
