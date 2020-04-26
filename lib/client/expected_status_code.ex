defmodule SendGridEx.Client.ExpectedStatusCode do
  @moduledoc """
  Checks SendGrid response HTTP status code

  ## Example usage

  ```
  defmodule Myclient do
    use Tesla

    plug SendGridEx.Client.ExpectedStatusCode
  end
  ```
  """

  @behaviour Tesla.Middleware

  @impl Tesla.Middleware
  def call(env, next, opts) do
    opts = opts || []

    expected_status_code = Keyword.get(opts, :expected_status_code)

    with {:ok, env} <- Tesla.run(env, next) do
      if env.status in 200..299 and
           (expected_status_code == nil or env.status == expected_status_code) do
        {:ok, env}
      else
        {:error, env}
      end
    end
  end
end
