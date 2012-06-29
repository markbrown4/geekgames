OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = {
  'provider'  => 'facebook',
  'uid'       => '123545',
  'extra'     => {'raw_info' => {'email' => 'mark@email.com', 'first_name' => 'Mark', 'last_name' => 'Brown'}}
}