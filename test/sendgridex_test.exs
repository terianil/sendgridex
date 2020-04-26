defmodule SendGridExTest do
  use ExUnit.Case
  alias SendGridEx.Model.Recipient
  # doctest SendGridEx

  test "test requests" do
    email = "sendgridex@sendgridex.com"
    recipient_id = SendGridEx.Recipients.email_to_recipient_id(email)
    recipient = %Recipient{
      email: email,
      custom_fields: %{
        number: 44,
        binary: "binary",
        datetime: DateTime.utc_now()
      }
    }

    assert SendGridEx.Recipients.add(recipient) |> IO.inspect()
    # assert SendGridEx.Recipients.delete(recipient_id) |> IO.inspect()
  end
end
