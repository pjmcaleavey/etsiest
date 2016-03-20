require "etsiest/version"
require "sinatra/base"
require "pry"
require "etsy"

Etsy.api_key = ENV["ETSY_KEY"]

module Etsiest
  class App < Sinatra::Application

    #http://localhost:4567/dog/bjorn

    get "/dog/:dog_name" do#/route/:variable_name
      # "This is your dogs name: #{params["dog_name"]}"
      erb :dog, locals: {dog_name: params["dog_name"]}
      # Render the file dog.erb, I want dog_name to equal the value of params["dog_name"] dog_name is now available to use
      # in dog.erb


      #  <%= %>
      # ^ This will "display" in template
      # <% %>
      # ^ This won't display
    end

    #http://localhost:4567/dog/bjorn/3

    get "/dog/:dog_name/:age" do#/route/:variable_name/:variable_name
      "This is your dogs name: #{params["dog_name"]}. His age is: #{params["age"]}"
      # erb :dog
    end

    #http://localhost:4567/mysearch?dog_name=bjorn

    get "/mysearch" do
      "<h1> This is your dog's name: #{params["dog_name"]} </h1>"
    end
################################################################################

    #http://localhost:4567/search?q=dog
    get "/search" do
      query = params["q"]


    #maybe have an if for missing 'q' person?

      response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => query )
      #response is Etsy::Response instance/object
      # response = Etsy::Response.new
      listings = response.result#.result returns a ruby array of hashes

  #ls response - gives methods you can use    response.code/response.body/response.to_hash
      erb :index, locals:{listings: listings}#{items: data(response.result)(results)}
      #:locals - if you want to pass variables into local file
      #listings: is a variable accessible in erb file
    end

    run! if app_file == $0
  end
end

#params -
