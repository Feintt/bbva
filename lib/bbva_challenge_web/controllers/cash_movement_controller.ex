defmodule BbvaChallengeWeb.CashMovementController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Pos
  alias BbvaChallenge.Pos.CashMovement

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    cash_movements = Pos.list_cash_movements()
    render(conn, :index, cash_movements: cash_movements)
  end

  def create(conn, %{"cash_movement" => cash_movement_params}) do
    with {:ok, %CashMovement{} = cash_movement} <- Pos.create_cash_movement(cash_movement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/cash_movements/#{cash_movement}")
      |> render(:show, cash_movement: cash_movement)
    end
  end

  def show(conn, %{"id" => id}) do
    cash_movement = Pos.get_cash_movement!(id)
    render(conn, :show, cash_movement: cash_movement)
  end

  def update(conn, %{"id" => id, "cash_movement" => cash_movement_params}) do
    cash_movement = Pos.get_cash_movement!(id)

    with {:ok, %CashMovement{} = cash_movement} <- Pos.update_cash_movement(cash_movement, cash_movement_params) do
      render(conn, :show, cash_movement: cash_movement)
    end
  end

  def delete(conn, %{"id" => id}) do
    cash_movement = Pos.get_cash_movement!(id)

    with {:ok, %CashMovement{}} <- Pos.delete_cash_movement(cash_movement) do
      send_resp(conn, :no_content, "")
    end
  end
end
