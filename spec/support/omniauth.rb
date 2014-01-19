def login_as(user)
  Omniauth.config.test_mode = true
  Omniauth.config.mock_auth[:twitter] = {
    "provider" => user.provider,
    "uid" => user.uid,
    "info" => {"name" => user.name}
  }
  visit.login_path
end
