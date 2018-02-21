require 'unirest'
require_relative 'controllers/users_controller'
require_relative 'views/users_views'
require_relative 'models/user'

def run
  while true
    system "clear"

    puts "Welcome to MyCancerCoach"
    puts "Make a Selection"
    puts "[1] See all users"
    puts "[2] See one user"
    puts "[3] Create a new user"
    puts "[4] Update a user"
    puts "[5] Delete a user"

    puts "[6] See all diagnoses"
    puts "[7] Add a diagnosis"
    puts "[8] Update a diagnosis"
    puts "[9] Delete a diagnosis"

    puts "[10] See all medications"
    puts "[11] See one medication"
    puts "[12] Add a medication"
    puts "[13] Update a medication"
    puts "[14] Delete a medication"

    puts "[15] See all providers"
    puts "[16] See one provider"
    puts "[17] Create a new provider"
    puts "[18] Update a provider"
    puts "[19] Delete a provider"

    puts "[signup] Sign up for a MyCancerCoach account (create a user)"
    puts "[login] Log in to your MyCancerCoach account"
    puts "[logout] Log out of your MyCancerCoach account"
    puts "[q] Quit"

    input_option = gets.chomp

    if input_option == "1"
        response = Unirest.get("http://localhost:3000/users")

        puts JSON.pretty_generate(response.body)
    elsif input_option == "2"
        print "Enter a user id: "
        input_id = gets.chomp

        response = Unirest.get("http://localhost:3000/users/#{input_id}")
        user = response.body
        puts JSON.pretty_generate(user)
    elsif input_option == "3"
        client_params = users_new_form
        response = Unirest.post("http://localhost:3000/users", parameters: client_params)

        if response.code == 200
            user = User.new(response.body)
            users_show_view(user)
        elsif response.code == 422
            errors = response.body["errors"]
            users_errors_view(errors)
        elsif response.code == 401
        
        puts JSON.pretty_generate(response.body)
        end 
    elsif input_option == "4"
        print "Enter a user id: "
        input_id = gets.chomp

        response = Unirest.get("http://localhost:3000/users/#{input_id}")
        user = response.body

        puts "Enter new information for user ##{input_id}"
        client_params = {}

        print "First Name (#{user["first_name"]}): "
        client_params[:first_name] = gets.chomp

        print "Last Name (#{user["last_name"]}): "
        client_params[:last_name] = gets.chomp

        print "Date of Birth (#{user["dob"]}): "
        client_params[:dob] = gets.chomp

        print "Street Address (#{user["street_address"]}): "
        client_params[:street_address] = gets.chomp

        print "City (#{user["city"]}): "
        client_params[:city] = gets.chomp

        print "State (#{user["state"]}): "
        client_params[:state] = gets.chomp

        print "Zip (#{user["zip"]}): "
        client_params[:zip] = gets.chomp

        print "Phone Number (#{user["phone_number"]}): "
        client_params[:phone_number] = gets.chomp

        print "Email (#{user["email"]}): "
        client_params[:email] = gets.chomp

        client_params.delete_if {|key, value| value.empty? }

        response = Unirest.patch(
                          "http://localhost:3000/users/#{input_id}",
                          parameters: client_params
                          )

        if response.code == 200
            user = response.body
            puts JSON.pretty_generate(user)
        else
            errors = response.body["errors"]
            puts
            puts "Your user did not update"
            puts "please look at the following reasons"
            puts "------------------------------------"
            errors.each do |error|
            puts error
        end
    elsif input_option == "5"
        print "Enter a user id that you want to delete: "
        input_id = gets.chomp

        response = Unirest.delete("http://localhost:3000/users/#{input_id}")
        data = response.body
    end 
end 
