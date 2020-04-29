defmodule SendGridEx.Model.RecipientId do
  @moduledoc """
  RecipientId helpers.
  """

  alias SendGridEx.Model.RecipientId

  @enforce_keys [:recipient_id]
  defstruct [
    :recipient_id
  ]

  @doc """
  Builds a RecipientId from an email.
  """
  def from_email(email) do
    %RecipientId{
      recipient_id: email_to_recipient_id(email)
    }
  end

  @doc """
  Converts an email to a SendGrid recipient id.
  """
  def email_to_recipient_id(email) do
    email
    |> String.downcase()
    |> Base.encode64()
  end
end
