defmodule BbvaChallenge.Repo.Migrations.CreatePaymentRequests do
  use Ecto.Migration

  def change do
    create table(:payment_requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :decimal
      add :currency, :string
      add :status, :string
      add :pay_url, :text
      add :qr_svg, :text
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :cash_box_id, references(:cash_boxes, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:payment_requests, [:account_id])
    create index(:payment_requests, [:cash_box_id])
    create index(:payment_requests, [:user_id])
  end
end
