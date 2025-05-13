defmodule BbvaChallenge.Repo.Migrations.CreatePosTerminals do
  use Ecto.Migration

  def change do
    create table(:pos_terminals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :qr_code_url, :string
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:pos_terminals, [:company_id])
  end
end
