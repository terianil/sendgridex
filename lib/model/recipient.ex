defmodule SendGridEx.Model.Recipient do
  @moduledoc """
  New recipient model.
  """

  alias SendGridEx.Model.Recipient

  @enforce_keys [:email]
  defstruct [
    :email,
    custom_fields: %{}
  ]

  @type t :: %Recipient{
          email: String.t(),
          custom_fields: map()
        }

  @doc """
  Builds a Repient.
  """
  @spec build(String.t(), map()) :: t()
  def build(email, custom_fields \\ %{}) when is_map(custom_fields) do
    %Recipient{
      email: email,
      custom_fields: custom_fields
    }
  end

  defimpl Jason.Encoder do
    def encode(%Recipient{email: email, custom_fields: %{} = fields}, opts) do
      data =
        %{email: email}
        |> Map.merge(fields)

      Jason.Encode.map(data, opts)
    end
  end
end
