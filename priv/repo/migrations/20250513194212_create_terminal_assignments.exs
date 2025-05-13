defmodule BbvaChallenge.Repo.Migrations.CreateTerminalAssignments do
  use Ecto.Migration

  def change do
    create table(:terminal_assignments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :terminal_id, references(:pos_terminals, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:terminal_assignments, [:user_id])
    create index(:terminal_assignments, [:terminal_id])
  end
end
