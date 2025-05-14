defmodule BbvaChallenge.Repo.Migrations.AddDetailsToCompanies do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :society_type, :string, null: false
      add :fiscal_address, :text, null: false
      add :industry, :string, null: false
      add :official_id, :string
      add :e_signature, :string
    end

    # índices sencillos para consultas rápidas
    create index(:companies, [:society_type])
    create index(:companies, [:industry])
  end
end
