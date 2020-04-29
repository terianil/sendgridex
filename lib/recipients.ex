defmodule SendGridEx.Recipients do
  alias SendGridEx.Client
  alias SendGridEx.Model.Recipient
  alias SendGridEx.Model.RecipientId

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
    with {:ok, env} <-
           Client.post(
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
    with {:ok, env} <-
           Client.patch(
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
  def delete(%RecipientId{} = r) do
    with {:ok, _env} <-
           Client.delete(
             "contactdb/recipients/#{r.recipient_id}",
             opts: [expected_status_code: 204]
           ) do
      :ok
    end
  end
end
