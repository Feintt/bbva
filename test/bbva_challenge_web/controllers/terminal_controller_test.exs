defmodule BbvaChallengeWeb.TerminalControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PosFixtures

  alias BbvaChallenge.Pos.Terminal

  @create_attrs %{
    name: "some name",
    qr_code_url: "some qr_code_url"
  }
  @update_attrs %{
    name: "some updated name",
    qr_code_url: "some updated qr_code_url"
  }
  @invalid_attrs %{name: nil, qr_code_url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pos_terminals", %{conn: conn} do
      conn = get(conn, ~p"/api/pos_terminals")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create terminal" do
    test "renders terminal when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pos_terminals", terminal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pos_terminals/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name",
               "qr_code_url" => "some qr_code_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pos_terminals", terminal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update terminal" do
    setup [:create_terminal]

    test "renders terminal when data is valid", %{conn: conn, terminal: %Terminal{id: id} = terminal} do
      conn = put(conn, ~p"/api/pos_terminals/#{terminal}", terminal: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pos_terminals/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "qr_code_url" => "some updated qr_code_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, terminal: terminal} do
      conn = put(conn, ~p"/api/pos_terminals/#{terminal}", terminal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete terminal" do
    setup [:create_terminal]

    test "deletes chosen terminal", %{conn: conn, terminal: terminal} do
      conn = delete(conn, ~p"/api/pos_terminals/#{terminal}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pos_terminals/#{terminal}")
      end
    end
  end

  defp create_terminal(_) do
    terminal = terminal_fixture()
    %{terminal: terminal}
  end
end
