defmodule BbvaChallenge.Repo.Migrations.CreateCashBoxes do
  use Ecto.Migration

  def change do
    create table(:cash_boxes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :state, :string
      add :opened_at, :utc_datetime
      add :closed_at, :utc_datetime
      add :initial_balance, :decimal
      add :final_balance, :decimal
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id)
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:cash_boxes, [:user_id])
    create index(:cash_boxes, [:company_id])
    create index(:cash_boxes, [:account_id])
  end
end
