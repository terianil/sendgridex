defmodule SendGridEx.Client.Auth do
  @moduledoc """
  Set SendGrid Authorization header for all requests

  ## Example usage

  ```
  defmodule Myclient do
    use Tesla

    plug SendGridEx.Client.Auth
  end
  ```
  """

  @behaviour Tesla.Middleware

  @impl Tesla.Middleware
  def call(env, next, _opts) do
    api_key = Application.fetch_env!(:sendgridex, :api_key)

    env
    |> Tesla.put_headers([{"Authorization", "Bearer #{api_key}"}])
    |> Tesla.run(next)
  end
end
