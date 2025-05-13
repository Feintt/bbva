defmodule BbvaChallenge.Accounting.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @kinds [:ingreso, :egreso]

  schema "transactions" do
    field :date, :utc_datetime
    field :description, :string
    field :kind, Ecto.Enum, values: @kinds
    field :amount, :decimal

    belongs_to :account, BbvaChallenge.Accounting.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(trx, attrs) do
    trx
    |> cast(attrs, [:amount, :kind, :description, :date, :account_id])
    |> validate_required([:amount, :kind, :description, :date, :account_id])
    |> assoc_constraint(:account)
  end
end
