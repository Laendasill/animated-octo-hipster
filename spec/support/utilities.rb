include ApplicationHelper
def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def vaild_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  clic_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_seletor('div.alert.alert-error', text: message)
  end
end
module Sign
def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token]=remember_token
      user.update_attribute(:remember_token, User.hash(remember_token))
  else
  visit signin_path
  fill_in "Email",      with: user.email
  fill_in "Password",   with: user.password
  click_button "Sign in"
  #sign in when not using capybara as well
  end
end
end