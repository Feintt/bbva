defmodule BbvaChallenge.Pos.TerminalAssignment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "terminal_assignments" do
    belongs_to :user, BbvaChallenge.Accounts.User
    belongs_to :terminal, BbvaChallenge.Pos.Terminal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ta, attrs) do
    ta
    |> cast(attrs, [:user_id, :terminal_id])
    |> validate_required([:user_id, :terminal_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:terminal)
  end
end
