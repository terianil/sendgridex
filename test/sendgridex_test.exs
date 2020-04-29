defmodule SendGridExTest do
  use ExUnit.Case
  import Tesla.Mock
  alias SendGridEx.Model.{Recipient, RecipientId}
  alias SendGridEx.Recipients
  # doctest SendGridEx

  setup do
    mock(fn
      %{method: :patch, url: "https://api.sendgrid.com/v3/contactdb/recipients", body: body} ->
        body = Jason.decode!(body)

        %Tesla.Env{
          status: 201,
          body: %{
            "error_count" => 0,
            "error_indices" => [],
            "errors" => [],
            "new_count" => 0,
            "persisted_recipients" => [
              RecipientId.email_to_recipient_id(Enum.at(body, 0)["email"])
            ],
            "unmodified_indices" => [0],
            "updated_count" => 1
          }
        }

      %{method: :post, url: "https://api.sendgrid.com/v3/contactdb/recipients", body: body} ->
        body = Jason.decode!(body)

        %Tesla.Env{
          status: 201,
          body: %{
            "error_count" => 0,
            "error_indices" => [],
            "errors" => [],
            "new_count" => 1,
            "persisted_recipients" => [
              RecipientId.email_to_recipient_id(Enum.at(body, 0)["email"])
            ],
            "unmodified_indices" => [],
            "updated_count" => 0
          }
        }

      %{
        method: :delete,
        url:
          "https://api.sendgrid.com/v3/contactdb/recipients/c2VuZGdyaWRleEBzZW5kZ3JpZGV4LmNvbQ=="
      } ->
        %Tesla.Env{
          status: 201,
          body: ""
        }
    end)

    :ok
  end

  test "update recipient with custom fields" do
    email = "sendgridex@sendgridex.com"

    recipient = %Recipient{
      email: email,
      custom_fields: %{
        number: 44,
        binary: "binary",
        datetime: DateTime.utc_now()
      }
    }

    assert Recipients.update(recipient) ==
             {:ok,
              %{
                "error_count" => 0,
                "error_indices" => [],
                "errors" => [],
                "new_count" => 0,
                "persisted_recipients" => ["c2VuZGdyaWRleEBzZW5kZ3JpZGV4LmNvbQ=="],
                "unmodified_indices" => [0],
                "updated_count" => 1
              }}
  end

  test "add recipient with custom fields" do
    email = "sendgridex@sendgridex.com"

    recipient = %Recipient{
      email: email,
      custom_fields: %{
        number: 44,
        binary: "binary",
        datetime: DateTime.utc_now()
      }
    }

    assert Recipients.add(recipient) ==
             {:ok,
              %{
                "error_count" => 0,
                "error_indices" => [],
                "errors" => [],
                "new_count" => 1,
                "persisted_recipients" => ["c2VuZGdyaWRleEBzZW5kZ3JpZGV4LmNvbQ=="],
                "unmodified_indices" => [],
                "updated_count" => 0
              }}
  end

  test "delete recipient with custom fields" do
    email = "sendgridex@sendgridex.com"
    recipient_id = RecipientId.from_email(email)

    assert Recipients.delete(recipient_id) == :ok
  end
end
