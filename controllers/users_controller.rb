module UsersController
  def users_index_action
    user_hashes = get_request("/users")
    users = User.convert_hashes(user_hashes)
    users_index_view(users)
  end 

  def users_show_action
    input_id = users_id_form

    user_hash = get_request("/users/#{input_id}")
    user = User.new(user_hash)

    users_show_view(user)
  end 

  def users_create_action
    client_params = users_new_form
    response = Unirest.post("http://localhost:3000/users", parameters: client_params)

    if response.code == 200
      user = User.new(response.body)
      users_show_view(user)
    elsif response.code == 422
      errors = response.body["errors"]
      users_errors_view(errors)
    elsif response.cody == 401
      puts JSON.pretty_generate(response.body)
    end 
  end 

  def users_update_action
    input_id = users_id_form
    user_hash = get_request("/users/#{input_id}")
    user = User.new(user_hash)

    client_params = users_update_form(user)
    response = Unirest.patch("http://localhost:3000/users/#{input_id}", parameters: client_params)

    if response.code == 200
      user = User.new(user.body)
      users_show_view(user)
    elsif response.code == 422
      errors = response.body["errors"]
      users_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate( response.body)
    end 
  end 

  def users_destroy_action
    input_id = users_id_form
    json_data = delete_request("/users/#{input_id}")
    puts json_data["message"]
  end 
end 
