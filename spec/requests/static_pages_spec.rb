require 'spec_helper'

describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end

  describe "Home page" do

    it "should have the h1 'Home'" do
      visit root_path
      page.should have_selector('h1', :text => 'Home')
    end

    it "should have the right title" do
      visit root_path
      page.should have_selector('title',
                    :text => "AsocialNet | Home")
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the right title" do
      visit help_path
      page.should have_selector('title',
                    :text => "AsocialNet | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the right title" do
      visit about_path
      page.should have_selector('title',
                    :text => "AsocialNet | About Us")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "AsocialNet | Contact")
    end
  end

end
