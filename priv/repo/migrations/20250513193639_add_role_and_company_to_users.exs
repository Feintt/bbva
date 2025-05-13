defmodule BbvaChallenge.Repo.Migrations.AddRoleAndCompanyToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, null: false, default: "empleado"
      add :company_id, references(:companies, on_delete: :nilify_all, type: :binary_id)
    end

    create index(:users, [:company_id])
  end
end
