defmodule BbvaChallenge.Repo.Migrations.AddPaymentRequestToCashMovements do
  use Ecto.Migration

  def change do
    alter table(:cash_movements) do
      add :payment_request_id,
          references(:payment_requests, type: :binary_id, on_delete: :nilify_all)
    end

    create index(:cash_movements, [:payment_request_id])
  end
end
