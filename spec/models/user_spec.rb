require 'spec_helper'

describe User do
  
  before do @user = User.new(name: "Example User", email: "user@example.com",
          password: "foobar", password_confirmation: "foobar") 
  end
    
  subject {@user}
    
it { should respond_to(:name) }
it { should respond_to(:email) }

it { should respond_to(:admin) }
it { should respond_to(:microposts) }
it { should respond_to(:password_confirmation) }
it { should respond_to(:remember_token) }
it { should respond_to(:authenticate) }
it { should respond_to(:microposts) }
it { should respond_to(:feed) }

describe "Remember token" do
  before { @user.save }
  its(:remember_token) { should_not be_blank }
end

describe "Microposts associations" do
  
  before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end
    
    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [ newer_micropost, older_micropost ]
    end
    
    it "Should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
          
      end
    end
    describe "status" do
      let(:unfolowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))

      end

      its(:feed) { Should include(newer_micropost) }
      its(:feed) { Should include(older_micropost) }
      its(:feed) { Should_not include(unfolowed_post) }
    end
end
end
