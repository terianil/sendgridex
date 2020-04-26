use Mix.Config

config :sendgridex,
  api_key: ""

import_config "#{Mix.env()}.exs"
