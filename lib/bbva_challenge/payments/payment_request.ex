defmodule BbvaChallenge.Payments.PaymentRequest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @statuses [:pending, :paid, :expired, :failed]

  schema "payment_requests" do
    field :status, Ecto.Enum, values: @statuses, default: :pending
    field :currency, :string, default: "MXN"
    field :amount, :decimal
    field :pay_url, :string
    field :qr_svg, :string

    belongs_to :account, BbvaChallenge.Accounting.Account
    belongs_to :cash_box, BbvaChallenge.Pos.CashBox
    belongs_to :user, BbvaChallenge.Accounts.User

    has_one :cash_movement,
            BbvaChallenge.Pos.CashMovement,
            foreign_key: :payment_request_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pr, attrs) do
    pr
    |> cast(
      attrs,
      [:amount, :currency, :status, :pay_url, :qr_svg, :account_id, :cash_box_id, :user_id]
    )
    |> validate_required([
      :amount,
      :currency,
      :status,
      :pay_url,
      :qr_svg,
      :account_id,
      :cash_box_id,
      :user_id
    ])
    |> validate_number(:amount, greater_than: 0)
    |> assoc_constraint(:account)
    |> assoc_constraint(:cash_box)
    |> assoc_constraint(:user)
  end
end
