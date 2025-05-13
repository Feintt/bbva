defmodule BbvaChallengeWeb.TerminalAssignmentControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PosFixtures

  alias BbvaChallenge.Pos.TerminalAssignment

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all terminal_assignments", %{conn: conn} do
      conn = get(conn, ~p"/api/terminal_assignments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create terminal_assignment" do
    test "renders terminal_assignment when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/terminal_assignments", terminal_assignment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/terminal_assignments/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/terminal_assignments", terminal_assignment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update terminal_assignment" do
    setup [:create_terminal_assignment]

    test "renders terminal_assignment when data is valid", %{conn: conn, terminal_assignment: %TerminalAssignment{id: id} = terminal_assignment} do
      conn = put(conn, ~p"/api/terminal_assignments/#{terminal_assignment}", terminal_assignment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/terminal_assignments/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, terminal_assignment: terminal_assignment} do
      conn = put(conn, ~p"/api/terminal_assignments/#{terminal_assignment}", terminal_assignment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete terminal_assignment" do
    setup [:create_terminal_assignment]

    test "deletes chosen terminal_assignment", %{conn: conn, terminal_assignment: terminal_assignment} do
      conn = delete(conn, ~p"/api/terminal_assignments/#{terminal_assignment}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/terminal_assignments/#{terminal_assignment}")
      end
    end
  end

  defp create_terminal_assignment(_) do
    terminal_assignment = terminal_assignment_fixture()
    %{terminal_assignment: terminal_assignment}
  end
end
