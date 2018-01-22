require 'rest-client'
require 'json'
require 'securerandom'

class RestApiInterface

  @headers = {
    'content-type' => 'application/json',
    'user-agent' => 'Rest Api Helper',
  }

  def post_to_api url, post_body_obj
    json_body = JSON.generate(post_body_obj)
    response = RestClient.post url, json_body, @headers
  end

  def create_test_user
    # Step 1: Build the user parameters randomly
    random_test_user = {
      'username'   => random_string,
      'password'   => random_string,
      'email'      => "#{random_string}@testing.com",
      'first_name' => 'test',
      'last_name'  => 'user',
    }

    # Step 2: Execute the API call
    response = post_to_api "http://api.myfakeapp.com/v1/create-user", random_test_user

    # Step 3: Ensure the api call returned a success code
    if response.code != '200'
      raise 'User creation failed'
    end

    # Final Step: Return the user object so we can use it
    response.body['user']['data']
  end

  def random_string
    # This is an easy way to get a good randomized string
    SecureRandom.hex
  end
end

$driver = Selenium::WebDriver.for :firefox
user = RestApiInterface.new.create_test_user

$driver.get 'http://myfakeapp.com'
$driver.find_element(:css, 'input[name="username"]').send_keys @user['username']
$driver.find_element(:css, 'input[name="password"]').send_keys @user['password']
$driver.find_element(:css, 'button[name="login"]').click
puts $driver.find_element(:css, '#user_id').text