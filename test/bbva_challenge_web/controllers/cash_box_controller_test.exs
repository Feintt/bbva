defmodule BbvaChallengeWeb.CashBoxControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PosFixtures

  alias BbvaChallenge.Pos.CashBox

  @create_attrs %{
    state: "some state",
    opened_at: ~U[2025-05-12 19:40:00Z],
    closed_at: ~U[2025-05-12 19:40:00Z],
    initial_balance: "120.5",
    final_balance: "120.5"
  }
  @update_attrs %{
    state: "some updated state",
    opened_at: ~U[2025-05-13 19:40:00Z],
    closed_at: ~U[2025-05-13 19:40:00Z],
    initial_balance: "456.7",
    final_balance: "456.7"
  }
  @invalid_attrs %{state: nil, opened_at: nil, closed_at: nil, initial_balance: nil, final_balance: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cash_boxes", %{conn: conn} do
      conn = get(conn, ~p"/api/cash_boxes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cash_box" do
    test "renders cash_box when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cash_boxes", cash_box: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cash_boxes/#{id}")

      assert %{
               "id" => ^id,
               "closed_at" => "2025-05-12T19:40:00Z",
               "final_balance" => "120.5",
               "initial_balance" => "120.5",
               "opened_at" => "2025-05-12T19:40:00Z",
               "state" => "some state"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cash_boxes", cash_box: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cash_box" do
    setup [:create_cash_box]

    test "renders cash_box when data is valid", %{conn: conn, cash_box: %CashBox{id: id} = cash_box} do
      conn = put(conn, ~p"/api/cash_boxes/#{cash_box}", cash_box: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cash_boxes/#{id}")

      assert %{
               "id" => ^id,
               "closed_at" => "2025-05-13T19:40:00Z",
               "final_balance" => "456.7",
               "initial_balance" => "456.7",
               "opened_at" => "2025-05-13T19:40:00Z",
               "state" => "some updated state"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cash_box: cash_box} do
      conn = put(conn, ~p"/api/cash_boxes/#{cash_box}", cash_box: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cash_box" do
    setup [:create_cash_box]

    test "deletes chosen cash_box", %{conn: conn, cash_box: cash_box} do
      conn = delete(conn, ~p"/api/cash_boxes/#{cash_box}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cash_boxes/#{cash_box}")
      end
    end
  end

  defp create_cash_box(_) do
    cash_box = cash_box_fixture()
    %{cash_box: cash_box}
  end
end
