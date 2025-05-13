defmodule BbvaChallengeWeb.CashBoxController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Pos
  alias BbvaChallenge.Pos.CashBox

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    cash_boxes = Pos.list_cash_boxes()
    render(conn, :index, cash_boxes: cash_boxes)
  end

  def create(conn, %{"cash_box" => cash_box_params}) do
    with {:ok, %CashBox{} = cash_box} <- Pos.create_cash_box(cash_box_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/cash_boxes/#{cash_box}")
      |> render(:show, cash_box: cash_box)
    end
  end

  def show(conn, %{"id" => id}) do
    cash_box = Pos.get_cash_box!(id)
    render(conn, :show, cash_box: cash_box)
  end

  def update(conn, %{"id" => id, "cash_box" => cash_box_params}) do
    cash_box = Pos.get_cash_box!(id)

    with {:ok, %CashBox{} = cash_box} <- Pos.update_cash_box(cash_box, cash_box_params) do
      render(conn, :show, cash_box: cash_box)
    end
  end

  def delete(conn, %{"id" => id}) do
    cash_box = Pos.get_cash_box!(id)

    with {:ok, %CashBox{}} <- Pos.delete_cash_box(cash_box) do
      send_resp(conn, :no_content, "")
    end
  end
end
