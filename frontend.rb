require 'unirest'

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
    puts "[7] See one diagnosis"
    puts "[8] Add a diagnosis"
    puts "[9] Update a diagnosis"
    puts "[10] Delete a diagnosis"

    puts "[11] See all medications"
    puts "[12] See one medication"
    puts "[13] Add a medication"
    puts "[14] Update a medication"
    puts "[15] Delete a medication"

    puts "[16] See all providers"
    puts "[17] See one provider"
    puts "[18] Create a new provider"
    puts "[19] Update a provider"
    puts "[20] Delete a provider"

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

        response = Unirest.post(
                          "http://localhost:3000/users",
                          parameters: client_params
                          )
        if response.code == 200
            user = response.body
            puts JSON.pretty_generate(user)
        else
            errors = response.body["errors"]
            puts
            puts "Your user did not save"
            puts "please look at the following reasons"
            puts "------------------------------------"
            errors.each do |error|
            puts error
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

    elsif input_option == "6"
        response = Unirest.get("http://localhost:3000/diagnoses")

        puts JSON.pretty_generate(response.body)
    elsif input_option == "7"
        print "Enter a diagnosis id: "
        input_id = gets.chomp

        response = Unirest.get("http://localhost:3000/diagnoses/#{input_id}")
        diagnosis = response.body
        puts JSON.pretty_generate(diagnosis)
    elsif input_option == "8"
        puts "Enter new information for diagnosis ##{input_id}"
        client_params = {}

        print "Name (#{diagnosis["name"]}): "
        client_params[:name] = gets.chomp

        print "ICD 10 Code(#{diagnosis["icd_10_code"]}): "
        client_params[:icd_10_code] = gets.chomp

        response = Unirest.post(
                          "http://localhost:3000/diagnoses",
                          parameters: client_params
                          )
        if response.code == 200
            diagnosis = response.body
            puts JSON.pretty_generate(diagnosis)
        else
            errors = response.body["errors"]
            puts
            puts "Your diagnosis did not save"
            puts "please look at the following reasons"
            puts "------------------------------------"
            errors.each do |error|
            puts error
        end
    elsif input_option == "9"
        print "Enter a diagnosis id: "
        input_id = gets.chomp

        response = Unirest.get("http://localhost:3000/diagnoses/#{input_id}")
        diagnosis = response.body

        puts "Enter new information for diagnosis ##{input_id}"
        client_params = {}

        print "Name (#{diagnosis["name"]}): "
        client_params[:name] = gets.chomp

        print "ICD 10 Code (#{diagnosis["icd_10_code"]}): "
        client_params[:icd_10_code] = gets.chomp

        client_params.delete_if {|key, value| value.empty? }

        response = Unirest.patch(
                          "http://localhost:3000/diagnoses/#{input_id}",
                          parameters: client_params
                          )

        if response.code == 200
            diagnosis = response.body
            puts JSON.pretty_generate(diagnosis)
        else
            errors = response.body["errors"]
            puts
            puts "Your diagnosis did not update"
            puts "Please look at the following reasons"
            puts "------------------------------------"
            errors.each do |error|
            puts error
        end
    elsif input_option == "10"
        print "Enter a diagnosis id that you want to delete: "
        input_id = gets.chomp

        response = Unirest.delete("http://localhost:3000/diagnoses/#{input_id}")
        data = response.body
end 
