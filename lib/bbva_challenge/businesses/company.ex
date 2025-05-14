defmodule BbvaChallenge.Businesses.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @societies [:sa_de_cv, :s_de_rl]
  @industries [:ropa, :alimentos, :tecnologia]

  schema "companies" do
    field :name, :string
    field :rfc, :string

    field :society_type, Ecto.Enum, values: @societies
    field :fiscal_address, :string
    field :industry, Ecto.Enum, values: @industries

    # path o URL subida
    field :official_id, :string
    # path o URL subida
    field :e_signature, :string

    has_many :users, BbvaChallenge.Accounts.User
    has_many :accounts, BbvaChallenge.Accounting.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [
      :name,
      :rfc,
      :society_type,
      :fiscal_address,
      :industry,
      :official_id,
      :e_signature
    ])
    |> validate_required([
      :name,
      :rfc,
      :society_type,
      :fiscal_address,
      :industry
    ])
    |> unique_constraint(:rfc)
  end
end
