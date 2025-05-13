defmodule BbvaChallenge.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :rfc, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:companies, [:rfc])
  end
end
