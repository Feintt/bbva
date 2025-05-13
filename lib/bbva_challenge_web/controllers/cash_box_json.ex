defmodule BbvaChallengeWeb.CashBoxJSON do
  alias BbvaChallenge.Pos.CashBox

  @doc """
  Renders a list of cash_boxes.
  """
  def index(%{cash_boxes: cash_boxes}) do
    %{data: for(cash_box <- cash_boxes, do: data(cash_box))}
  end

  @doc """
  Renders a single cash_box.
  """
  def show(%{cash_box: cash_box}) do
    %{data: data(cash_box)}
  end

  defp data(%CashBox{} = cash_box) do
    %{
      id: cash_box.id,
      state: cash_box.state,
      opened_at: cash_box.opened_at,
      closed_at: cash_box.closed_at,
      initial_balance: cash_box.initial_balance,
      final_balance: cash_box.final_balance
    }
  end
end
