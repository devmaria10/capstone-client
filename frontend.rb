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
      users_index_action
    elsif input_option == "2"
      users_show_action
    elsif input_option == "3"
      users_create_action
    elsif input_option == "4"
      users_update_action
    elsif input_option == "5"
      users_destroy_action
    end 
end 
