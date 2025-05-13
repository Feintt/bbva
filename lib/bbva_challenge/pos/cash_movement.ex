defmodule BbvaChallenge.Pos.CashMovement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @movement_types [:ingreso, :egreso]
  @payment_methods [:efectivo, :tarjeta, :transferencia]

  schema "cash_movements" do
    field :type, Ecto.Enum, values: @movement_types
    field :payment_method, Ecto.Enum, values: @payment_methods
    field :date, :utc_datetime
    field :description, :string
    field :amount, :decimal

    belongs_to :cash_box, BbvaChallenge.Pos.CashBox
    belongs_to :transaction, BbvaChallenge.Accounting.Transaction

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cash_movement, attrs) do
    cash_movement
    |> cast(attrs, [
      :type,
      :payment_method,
      :amount,
      :description,
      :date,
      # 👈 ahora sí
      :cash_box_id,
      :transaction_id
    ])
    |> validate_required([
      :type,
      :payment_method,
      :amount,
      :description,
      :date,
      # 👈 ahora sí
      :cash_box_id,
      :transaction_id
    ])
    |> assoc_constraint(:cash_box)
    |> assoc_constraint(:transaction)
  end
end
