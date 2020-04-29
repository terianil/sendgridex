defmodule SendGridEx.Recipients do
  alias SendGridEx.Client
  alias SendGridEx.Model.Recipient

  @doc """
  Adds a single recipient.
  """
  def add(%Recipient{} = recipient) do
    add([recipient])
  end

  @doc """
  Adds multiple recipients.
  """
  def add(recipients) when is_list(recipients) do
    with {:ok, env} <- Client.post(
      "contactdb/recipients",
      recipients,
      opts: [expected_status_code: 201]
    ) do
      {:ok, env.body}
    end
  end

  @doc """
  Updates a single recipient. If the recipient does not exist, it will be created.
  """
  def update(%Recipient{} = recipient) do
    update([recipient])
  end

  @doc """
  Updates multiple recipients. If the recipient does not exist, it will be created.
  """
  def update(recipients) when is_list(recipients) do
    with {:ok, env} <- Client.patch(
      "contactdb/recipients",
      recipients,
      opts: [expected_status_code: 201]
    ) do
      {:ok, env.body}
    end
  end

  @doc """
  Deletes a recipient.
  """
  def delete(recipient_id) when is_binary(recipient_id) do
    with {:ok, _env} <- Client.delete(
      "contactdb/recipients/#{recipient_id}",
      opts: [expected_status_code: 204]
    ) do
      :ok
    end
  end

  @doc """
  Converts an email to the SendGrid recipient id.
  """
  def email_to_recipient_id(email) do
    email
    |> String.downcase()
    |> Base.encode64()
  end
end
