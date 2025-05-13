defmodule BbvaChallengeWeb.CashMovementJSON do
  alias BbvaChallenge.Pos.CashMovement

  @doc """
  Renders a list of cash_movements.
  """
  def index(%{cash_movements: cash_movements}) do
    %{data: for(cash_movement <- cash_movements, do: data(cash_movement))}
  end

  @doc """
  Renders a single cash_movement.
  """
  def show(%{cash_movement: cash_movement}) do
    %{data: data(cash_movement)}
  end

  defp data(%CashMovement{} = cash_movement) do
    %{
      id: cash_movement.id,
      type: cash_movement.type,
      payment_method: cash_movement.payment_method,
      amount: cash_movement.amount,
      description: cash_movement.description,
      date: cash_movement.date
    }
  end
end
