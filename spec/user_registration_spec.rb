# feature "Signing in" do
#   background do
#     User.make(:email => 'user@example.com', :password => 'caplin')
#   end

#   scenario "Signing in with correct credentials" do
#     visit '/sessions/new'
#     within("#session") do
#       fill_in 'Login', :with => 'user@example.com'
#       fill_in 'Password', :with => 'caplin'
#     end
#     click_link 'Sign in'
#     expect(page).to have_content 'Success'
#   end
