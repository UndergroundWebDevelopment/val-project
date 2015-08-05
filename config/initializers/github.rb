Github.configure do |c|
  c.client_id         = ENV.fetch("GITHUB_CLIENT_ID")
  c.client_secret     = ENV.fetch("GITHUB_CLIENT_SECRET")
end
