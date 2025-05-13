defmodule BbvaChallenge.Businesses.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "companies" do
    field :name, :string
    field :rfc, :string
    has_many :users, BbvaChallenge.Accounts.User
    has_many :accounts, BbvaChallenge.Accounting.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :rfc])
    |> validate_required([:name, :rfc])
    |> unique_constraint(:rfc)
  end
end
