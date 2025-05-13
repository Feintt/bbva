defmodule BbvaChallenge.Payments.WebhookLog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "webhook_logs" do
    field :payload, :map
    field :provider, :string
    field :payment_request_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(webhook_log, attrs) do
    webhook_log
    |> cast(attrs, [:provider, :payload])
    |> validate_required([:provider])
  end
end
