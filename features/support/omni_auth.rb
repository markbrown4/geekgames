OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = {
  'provider'  => 'facebook',
  'uid'       => '123545',
  'extra'     => {'raw_info' => {'email' => 'mark@email.com', 'first_name' => 'Mark', 'last_name' => 'Brown'}}
}

OmniAuth.config.mock_auth[:twitter] = {
  'provider' => 'twitter',
  'uid'      => '123545',
  'info'     => { 'name' => 'Mark Brown' }

}
