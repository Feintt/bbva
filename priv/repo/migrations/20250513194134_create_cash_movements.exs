defmodule BbvaChallenge.Repo.Migrations.CreateCashMovements do
  use Ecto.Migration

  def change do
    create table(:cash_movements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :payment_method, :string
      add :amount, :decimal
      add :description, :text
      add :date, :utc_datetime
      add :cash_box_id, references(:cash_boxes, on_delete: :nothing, type: :binary_id)
      add :transaction_id, references(:transactions, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:cash_movements, [:cash_box_id])
    create index(:cash_movements, [:transaction_id])
  end
end
