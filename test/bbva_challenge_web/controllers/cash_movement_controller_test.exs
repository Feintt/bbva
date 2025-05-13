defmodule BbvaChallengeWeb.CashMovementControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PosFixtures

  alias BbvaChallenge.Pos.CashMovement

  @create_attrs %{
    type: "some type",
    date: ~U[2025-05-12 19:41:00Z],
    description: "some description",
    payment_method: "some payment_method",
    amount: "120.5"
  }
  @update_attrs %{
    type: "some updated type",
    date: ~U[2025-05-13 19:41:00Z],
    description: "some updated description",
    payment_method: "some updated payment_method",
    amount: "456.7"
  }
  @invalid_attrs %{type: nil, date: nil, description: nil, payment_method: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cash_movements", %{conn: conn} do
      conn = get(conn, ~p"/api/cash_movements")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cash_movement" do
    test "renders cash_movement when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cash_movements", cash_movement: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cash_movements/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "120.5",
               "date" => "2025-05-12T19:41:00Z",
               "description" => "some description",
               "payment_method" => "some payment_method",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cash_movements", cash_movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cash_movement" do
    setup [:create_cash_movement]

    test "renders cash_movement when data is valid", %{conn: conn, cash_movement: %CashMovement{id: id} = cash_movement} do
      conn = put(conn, ~p"/api/cash_movements/#{cash_movement}", cash_movement: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cash_movements/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "456.7",
               "date" => "2025-05-13T19:41:00Z",
               "description" => "some updated description",
               "payment_method" => "some updated payment_method",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cash_movement: cash_movement} do
      conn = put(conn, ~p"/api/cash_movements/#{cash_movement}", cash_movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cash_movement" do
    setup [:create_cash_movement]

    test "deletes chosen cash_movement", %{conn: conn, cash_movement: cash_movement} do
      conn = delete(conn, ~p"/api/cash_movements/#{cash_movement}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cash_movements/#{cash_movement}")
      end
    end
  end

  defp create_cash_movement(_) do
    cash_movement = cash_movement_fixture()
    %{cash_movement: cash_movement}
  end
end
