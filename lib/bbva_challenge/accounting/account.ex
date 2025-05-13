defmodule BbvaChallenge.Accounting.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @directions ~w(uni bi)a

  schema "accounts" do
    field :name, :string
    field :direction, Ecto.Enum, values: @directions
    field :current_balance, :decimal

    belongs_to :company, BbvaChallenge.Businesses.Company
    has_many :transactions, BbvaChallenge.Accounting.Transaction

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :direction, :current_balance, :company_id])
    |> validate_required([:name, :direction, :current_balance, :company_id])
    |> assoc_constraint(:company)
  end
end
