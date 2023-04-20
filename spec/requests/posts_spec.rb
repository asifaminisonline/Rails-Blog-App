# require 'rails_helper'
# RSpec.describe '/posts', type: :request do
#   let(:seeded_user) { User.first } # pick the first user from seed file
#   let(:seeded_post) { seeded_user.posts.first } # use the first post of seeded user for show action

#   describe 'GET /index' do
#     before(:example) do
#       get '/users/1/posts'
#     end
#     it 'renders a successful response' do
#       expect(response).to be_successful
#     end
#     it 'renders the correct template' do
#       expect(response).to render_template(:index)
#     end
#     it 'contains the correct text' do
#       expect(response.body).to include('Here is the list of all posts for user A')
#     end
#   end

#   describe 'Get/show' do
#     before { get "/users/#{seeded_user.id}/posts/#{seeded_post.id}" }

#     it 'renders a successful response' do
#       expect(response).to be_successful
#     end

#     it 'renders the correct template' do
#       expect(response).to render_template(:show)
#     end

#     it 'contains the correct text' do
#       expect(response.body).to include('Here is a post POST for user X')
#     end
#   end
# end
