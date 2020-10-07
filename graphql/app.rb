require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'rack/contrib'

require_relative 'models/managed_subscription'
require_relative 'graphql/schema'

class GraphApp < Sinatra::Base
  set :database_file, 'config/database.yml'
  use Rack::PostBodyContentTypeParser

  get '/ms' do
    @ms = ManagedSubscription.all
    JSON @ms.as_json
  end

  post '/graphql' do
    request.body.rewind
    puts request.body.rewind
    @request_payload = JSON.parse request.body.read
    params[:query] = @request_payload["query"]
    params[:variables] = @request_payload["variables"]
    result = GraphAppSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    JSON result
  end
end
