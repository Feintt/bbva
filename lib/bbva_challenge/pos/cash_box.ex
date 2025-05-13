defmodule BbvaChallenge.Pos.CashBox do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @states [:abierta, :cerrada]

  schema "cash_boxes" do
    field :state, Ecto.Enum, values: @states
    field :opened_at, :utc_datetime
    field :closed_at, :utc_datetime
    field :initial_balance, :decimal
    field :final_balance, :decimal

    belongs_to :user, BbvaChallenge.Accounts.User
    belongs_to :company, BbvaChallenge.Businesses.Company
    belongs_to :account, BbvaChallenge.Accounting.Account
    has_many :cash_movements, BbvaChallenge.Pos.CashMovement

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, [
      :state,
      :opened_at,
      :closed_at,
      :initial_balance,
      :final_balance,
      :user_id,
      :company_id,
      :account_id
    ])
    |> validate_required([
      :state,
      :opened_at,
      :initial_balance,
      :user_id,
      :company_id,
      :account_id
    ])
    |> maybe_require_close_fields()
  end

  defp maybe_require_close_fields(changeset) do
    case get_field(changeset, :state) do
      :cerrada ->
        validate_required(changeset, [:closed_at, :final_balance])

      _ ->
        changeset
    end
  end
end
