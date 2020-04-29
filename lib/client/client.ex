defmodule SendGridEx.Client do
  @moduledoc """
  Tesla Client for `SendGridEx`.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.sendgrid.com/v3/")
  plug(Tesla.Middleware.JSON)
  plug(SendGridEx.Client.Auth)
  plug(SendGridEx.Client.ExpectedStatusCode)
end
