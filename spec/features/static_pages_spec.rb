require 'spec_helper'

describe "Static pages" do
  let(:tytul)  {'Ruby on Rails Tutorial Sample App'}
    
subject {page}
  describe "Home Page" do
    before { visit root_path } 
    it { should have_content('Sample App') }
    it { should have_title("#{tytul}") }
   it { should_not have_title('| Home')}

   describe "for signed-in users" do
     let(:user) { FactoryGirl.create(:user) }
     before do
       FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
       FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
       sign_in user
       visit root_path
     end

     it " should render the user's feed" do
       user.feed.each do |item|
         expect(page).to have_selector("li##{item.id}", text: item.content)
       end
     end
   end
  end

  describe "Help page" do

    it "should have the h1 'Help' " do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the right title" do
      visit help_path
      page.should have_title("#{tytul} | Help")
    end
  end

  describe "About Page" do
    it "Should have the h1 'About Us' " do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "Should have the title 'About Us' " do
      visit about_path
      page.should have_title("#{tytul} | About Us")
    end
  end
  describe "Contact" do
    it "Should have the right title" do
      visit contact_path
      page.should have_title("#{tytul} | Contact")
    end
    it "should have the h1'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end
  end
end
