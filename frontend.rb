require 'unirest'

class Frontend 
    
    def run
        while true
            system "clear"

            puts "Welcome to MyCancerCoach"
            puts "      Make a Selection"
            puts "          [1] See all users"
            puts "          [2] See one user"
            puts "          [3] Create a new user"
            puts "          [4] Update a user"
            puts "          [5] Delete a user"

            puts "          [6] See all diagnoses"
            puts "          [7] See one diagnosis"
            puts "          [8] Add a diagnosis"
            puts "          [9] Update a diagnosis"
            puts "          [10] Delete a diagnosis"

            puts "          [11] See all providers"
            puts "          [12] See one provider"
            puts "          [13] Create a new provider"
            puts "          [14] Update a provider"
            puts "          [15] Delete a provider"

            puts "          [16] See all medications"
            puts "          [17] See one medication"
            puts "          [18] Add a medication"
            puts "          [19] Update a medication"
            puts "          [20] Delete a medication"

            puts "          [21] See all timers"
            puts "          [22] See one timer"
            puts "          [23] Add a timer"
            puts "          [24] Update a timer"
            puts "          [25] Delete a timer"
            puts "---------------------------------------"

            puts "          [Signup] Sign up for a MyCancerCoach account (create a user)"
            puts "          [View] View your profile details"
            puts "          [Login] Log in to your MyCancerCoach account"
            puts "          [Logout] Log out of your MyCancerCoach account"
            puts "          [q] Quit"

            input_option = gets.chomp

            if input_option == "1"
                response = Unirest.get("http://localhost:3000/users")

                # puts JSON.pretty_generate(response.body)

                p response.body

            elsif input_option == "2"
                print "Enter a user id to view information for that user: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/users/#{input_id}")
                user = response.body
                puts JSON.pretty_generate(user)

            elsif input_option == "3"
                puts "Enter information to create a new user: "
                client_params = {}

                print "First Name: "
                client_params[:first_name] = gets.chomp

                print "Last Name: "
                client_params[:last_name] = gets.chomp

                print "Date of Birth: "
                client_params[:dob] = gets.chomp

                print "Street Address: "
                client_params[:street_address] = gets.chomp

                print "City: "
                client_params[:city] = gets.chomp

                print "State: "
                client_params[:state] = gets.chomp

                print "Zip: "
                client_params[:zip] = gets.chomp

                print "Phone Number: "
                client_params[:phone_number] = gets.chomp

                print "Email: "
                client_params[:email] = gets.chomp

                print "Password: "
                client_params[:password] = gets.chomp

                print "Password Confirmation: "
                client_params[:password_confirmation] = gets.chomp 


                response = Unirest.post(
                                        "http://localhost:3000/users",
                                        parameters: client_params
                                        )
                if response.code == 200 || response.code == 201
                    user = response.body
                    puts JSON.pretty_generate(user)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your user did not save"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end
                end

            elsif input_option == "4"
                print "Enter a user id to update: "
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

                if response.code == 200 || response.code == 201
                    user = response.body
                    puts JSON.pretty_generate(user)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your user information did not update"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end
                end

            elsif input_option == "5"
                print "Enter a user id that you want to delete: "
                input_id = gets.chomp

                response = Unirest.delete("http://localhost:3000/users/#{input_id}")
                data = response.body

                puts "Your user #{input_id} was deleted successfully"

            elsif input_option == "6"
                response = Unirest.get("http://localhost:3000/diagnoses")

                puts JSON.pretty_generate(response.body)

            elsif input_option == "7"
                print "Enter a diagnosis id to view information for that diagnosis: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/diagnoses/#{input_id}")
                diagnosis = response.body
                puts JSON.pretty_generate(diagnosis)

            elsif input_option == "8"
                puts "Enter information to enter a new diagnosis: "
                client_params = {}

                print "Name: "
                client_params[:name] = gets.chomp

                print "ICD 10 Code: "
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
                end 

            elsif input_option == "9"
                print "Enter a diagnosis id to update: "
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

                if response.code == 200 || response.code == 201
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
                end

            elsif input_option == "10"
                print "Enter a diagnosis id that you want to delete: "
                input_id = gets.chomp

                response = Unirest.delete("http://localhost:3000/diagnoses/#{input_id}")
                data = response.body

                puts "Diagnosis deleted successfully"

            elsif input_option == "11"
                response = Unirest.get("http://localhost:3000/providers")

                puts JSON.pretty_generate(response.body)

            elsif input_option == "12"
                print "Enter a provider id to see information for that provider: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/providers/#{input_id}")
                provider = response.body
                puts JSON.pretty_generate(provider)

            elsif input_option == "13"
                puts "Enter information to create a new provider: "
                client_params = {}

                print "Name: "
                client_params[:name] = gets.chomp

                print "Address: "
                client_params[:address] = gets.chomp

                response = Unirest.post(
                                        "http://localhost:3000/providers",
                                        parameters: client_params
                                        )
                if response.code == 200 || response.code == 201
                            provider = response.body
                            puts JSON.pretty_generate(provider)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your provider did not save"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end
                end 

            elsif input_option == "14"
                print "Enter a provider id to update: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/providers/#{input_id}")
                provider = response.body

                puts "Enter new information for provider ##{input_id}"
                client_params = {}

                print "Name (#{provider["name"]}): "
                client_params[:name] = gets.chomp

                print "Address (#{provider["address"]}): "
                client_params[:address] = gets.chomp

                client_params.delete_if {|key, value| value.empty? }

                response = Unirest.patch(
                                        "http://localhost:3000/providers/#{input_id}",
                                        parameters: client_params
                                        )

                if response.code == 200 || response.code == 201
                    provider = response.body
                    puts JSON.pretty_generate(provider)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your provider did not update"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end 
                end

            elsif input_option == "15"
                print "Enter a provider id that you want to delete: "
                input_id = gets.chomp

                response = Unirest.delete("http://localhost:3000/providers/#{input_id}")
                data = response.body

                puts "Your Provider #{input_id} was deleted successfully"

            elsif input_option == "16"
                response = Unirest.get("http://localhost:3000/medications")

                puts JSON.pretty_generate(response.body)

            elsif input_option == "17"
                print "Enter a medication id to view medication information: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/medications/#{input_id}")
                medication = response.body
                puts JSON.pretty_generate(medication)

            elsif input_option == "18"
                puts "Enter information to add a new medication: "
                client_params = {}

                print "Name: "
                client_params[:name] = gets.chomp

                response = Unirest.post(
                                        "http://localhost:3000/medications",
                                        parameters: client_params
                                        )
                if response.code == 200 || response.code == 201
                            medication = response.body
                            puts JSON.pretty_generate(medication)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your medication did not save"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end
                end 

            elsif input_option == "19"
                print "Enter a medication id to update: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/medications/#{input_id}")
                medication = response.body

                puts "Enter new information for medication ##{input_id}"
                client_params = {}

                print "Name (#{medication["name"]}): "
                client_params[:name] = gets.chomp

                print "Address (#{medication["address"]}): "
                client_params[:address] = gets.chomp

                client_params.delete_if {|key, value| value.empty? }

                response = Unirest.patch(
                                        "http://localhost:3000/medications/#{input_id}",
                                        parameters: client_params
                                        )

                if response.code == 200 || response.code == 201
                    medication = response.body
                    puts JSON.pretty_generate(medication)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your medication did not update"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end 
                end

            elsif input_option == "20"
                print "Enter a medication id that you want to delete: "
                input_id = gets.chomp

                response = Unirest.delete("http://localhost:3000/medications/#{input_id}")
                data = response.body

                puts "Your medication with id #{input_id} was deleted successfully"

            elsif input_option == "21"
                response = Unirest.get("http://localhost:3000/timers")

                puts JSON.pretty_generate(response.body)

            elsif input_option == "22"
                print "Enter a timer id to view timer information: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/timers/#{input_id}")
                timer = response.body
                puts JSON.pretty_generate(timer)

            elsif input_option == "23"
                puts "Enter information to add a new timer: "
                client_params = {}

                print "Timer last rang: "
                client_params[:last_rang] = gets.chomp

                print "Time Increment (Enter a number): "
                client_params[:time_increment] = gets.chomp

                print "Increment Unit (Enter unit (e.g., seconds, minutes, hours, days, weeks)):"
                client_params[:increment_unit] = gets.chomp

                print "Timerable ID:  "
                client_params[:timerable_id] = gets.chomp

                print "Type of Timer (Enter provider or usermedication):  "
                client_params[:timerable_type] = gets.chomp

                response = Unirest.post(
                                        "http://localhost:3000/timers",
                                        parameters: client_params
                                        )
                if response.code == 200 || response.code == 201
                            timer = response.body
                            puts JSON.pretty_generate(timer)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your timer did not save"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end
                end 

            elsif input_option == "24"
                print "Enter a timer id to update: "
                input_id = gets.chomp

                response = Unirest.get("http://localhost:3000/timers/#{input_id}")
                timer = response.body

                puts "Enter new information to update this timer: "
                client_params = {}

                print "New timer ##{input_id} last rang : "
                client_params[:last_rang] = gets.chomp

                print "New time increment for timer ##{input_id} (Enter a number): "
                client_params[:time_increment] = gets.chomp

                print "New increment unit for timer ##{input_id} (Enter unit (e.g., seconds, minutes, hours, days, weeks)):"
                client_params[:increment_unit] = gets.chomp

                print "New timerable ID for timer ##{input_id}:  "
                client_params[:timerable_id] = gets.chomp

                print "Type of timer (Enter provider or medication):  "
                client_params[:timerable_type] = gets.chomp

                client_params.delete_if {|key, value| value.empty? }

                response = Unirest.patch(
                                        "http://localhost:3000/timers/#{input_id}",
                                        parameters: client_params
                                        )

                if response.code == 200 || response.code == 201
                    timer = response.body
                    puts JSON.pretty_generate(timer)
                else
                    errors = response.body["errors"]
                    puts
                    puts "Your timer did not update"
                    puts "Please look at the following reasons"
                    puts "------------------------------------"
                    errors.each do |error|
                        puts error
                    end 
                end

            elsif input_option == "25"
                print "Enter a timer id that you want to delete: "
                input_id = gets.chomp

                response = Unirest.delete("http://localhost:3000/timers/#{input_id}")
                data = response.body

                puts "Your timer with id #{input_id} was deleted successfully"

            elsif input_option == "Signup"
                puts "Signup for your MyCancerCoach account!"
                puts
                client_params = {}

                print "First Name: "
                client_params[:first_name] = gets.chomp

                print "Last Name: "
                client_params[:last_name] = gets.chomp

                print "Date of Birth: "
                client_params[:dob] = gets.chomp

                print "Street Address: "
                client_params[:street_address] = gets.chomp

                print "City: "
                client_params[:city] = gets.chomp

                print "State: "
                client_params[:state] = gets.chomp

                print "Zip: "
                client_params[:zip] = gets.chomp

                print "Phone Number: "
                client_params[:phone_number] = gets.chomp

                print "Email: "
                client_params[:email] = gets.chomp
        
                print "Password: "
                client_params[:password] = gets.chomp
        
                print "Password confirmation: "
                client_params[:password_confirmation] = gets.chomp

                puts "----------------------------------------------------"
        
                response = Unirest.post("http://localhost:3000/users", parameters: client_params)

                user = response.body
                puts JSON.pretty_generate(response.body) 

            elsif input_option == "Login"
                puts "Login"
                puts
                print "Email: "
                input_email = gets.chomp
                print "Password: "
                input_password = gets.chomp

                response = Unirest.post(
                                        "http://localhost:3000/user_token", 
                                        parameters: {
                                              auth: {email: input_email, password: input_password}
                                            }
                                )

                jwt = response.body["jwt"]
                Unirest.default_header("Authorization", "Bearer #{jwt}")

                if jwt
                    puts "You are logged in"
                end 

            elsif input_option == "View"
                response = Unirest.get("http://localhost:3000/view_profile")

                puts JSON.pretty_generate(response.body)

            elsif input_option == "Logout"
                jwt = ""
                Unirest.clear_default_headers()
                puts "You are logged out"

            elsif input_option == "q"
                puts "Thanks for visiting the MyCancerCoach App!"
                exit
            end

            gets.chomp

        end 
    end 
end 