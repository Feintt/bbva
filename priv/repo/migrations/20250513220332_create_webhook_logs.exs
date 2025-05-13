defmodule BbvaChallenge.Repo.Migrations.CreateWebhookLogs do
  use Ecto.Migration

  def change do
    create table(:webhook_logs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :provider, :string
      add :payload, :map
      add :payment_request_id, references(:payment_requests, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:webhook_logs, [:payment_request_id])
  end
end
