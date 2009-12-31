require 'spec_helper'

describe PagesController do
	integrate_views

	before(:each) do
		@base_title = "matze.msh::WebDesign"
	end

	describe "GET 'home'" do
		it "should be successful" do
			get 'home'
			response.should be_success
		end

	it "should have the right title" do
		get 'home'
			response.should have_tag("title", @base_title + " | Start")
		end
	end

	describe "GET 'contact'" do
		it "should be successful" do
			get 'contact'
			response.should be_success
		end

		it "should have the right title" do
			get 'contact'
			response.should have_tag("title", @base_title + " | Kontakt")
		end
	end

	describe "GET 'about'" do
		it "should be successful" do
			get 'about'
			response.should be_success
		end

		it "should have the right title" do
			get 'about'
			response.should have_tag("title", @base_title + " | Über mich")
		end
	end

	describe "GET 'service'" do
		it "should be successful" do
			get 'service'
			response.should be_success
		end

		it "should have the right title" do
			get 'service'
			response.should have_tag("title", @base_title + " | Webdienste")
		end
	end

end