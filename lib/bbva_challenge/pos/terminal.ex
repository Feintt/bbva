defmodule BbvaChallenge.Pos.Terminal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pos_terminals" do
    field :name, :string
    field :qr_code_url, :string

    belongs_to :company, BbvaChallenge.Businesses.Company
    many_to_many :users, BbvaChallenge.Accounts.User, join_through: "terminal_assignments"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(terminal, attrs) do
    terminal
    |> cast(attrs, [:name, :qr_code_url, :company_id])
    |> validate_required([:name, :company_id])
  end
end
