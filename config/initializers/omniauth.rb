Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'u1rKrNjTownQZO2KfP4yZw', 'gNIh6myFIjunLGSYLafcu12lSb3fUnqFGIZ71IOw'
  provider :facebook, '3a8155731436645771c888faee7177f6', 'ec097dcb82bbf26008e1337b52f36625'
end