use Mix.Config

config :sendgridex,
  api_key: "API_KEY"

import_config "#{Mix.env()}.exs"
