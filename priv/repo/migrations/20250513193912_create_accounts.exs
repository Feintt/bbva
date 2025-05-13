defmodule BbvaChallenge.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :direction, :string
      add :current_balance, :decimal
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:accounts, [:company_id])
  end
end
