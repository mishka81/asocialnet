def full_title(page_title)
  base_title = "AsocialNet"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit login_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end
