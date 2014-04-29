require 'spec_helper'
include Sign
describe "UserPages" do
  
  subject{ page }
    
    
    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
      let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
        
      before { visit user_path(user) }
        
      it { should have_content(user.name) }
      it { should have_title(user.name) }
        
        describe "Microposts" do
          it { should have_content(m1.content) }
          it { should have_content(m2.content) }
          it { should have_content(user.microposts.count) }
        end 
      
    end
  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "Ben@example.com")
      visit users_path
    end
    
    it { should have_title("All users") }
    it { should have_content("All users") }
      
  describe "pagination" do
    
    before(:all) { 30.times { FactoryGirl.create(:user) }}
    after(:all) { User.delete_all }
      
    it { should have_selector('div.pagination') }
      
      it "Should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
  end
  end
    
    describe "signup" do
      
    before { visit signup_path }
    
    
  let(:submit) {"Create my account" }
    
  it { should have_content("Sign up") }
  it { should have_title(full_title("Sign up")) }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "user_name",   with: "Example User"
        fill_in "user_email",  with: "user@example.com"
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    
      describe "after submission" do
      before {click_button submit }
      
      it { should_not have_title('Sign up') }
      it { should have_content('error') }
    end
    

    
    describe "after saving user" do
      
      before { click_button submit }
      let(:user) { User.find_by(email: 'user@example.com') }
        
      it { should have_link('Sign out') }
      it { should have_title(user.name) }
      it { should have_selector('div.alert.alert-success', text: 'Welcome')}
      
    end
      
    describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
      
      describe "with vaild information" do
        
        it { should have_selector('h1', text: "Update your profile") }
        it { should have_title("Edit user") }
        it { should have_link('change', href: "http://gravatar.com/emails")}
      end
      end
      describe "With invalid information" do
        before { click_button "Save changes" }
          
        it { should have_content('error') }
      end 
end
end
end