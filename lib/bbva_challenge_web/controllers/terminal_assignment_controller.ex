defmodule BbvaChallengeWeb.TerminalAssignmentController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Pos
  alias BbvaChallenge.Pos.TerminalAssignment

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    terminal_assignments = Pos.list_terminal_assignments()
    render(conn, :index, terminal_assignments: terminal_assignments)
  end

  def create(conn, %{"terminal_assignment" => terminal_assignment_params}) do
    with {:ok, %TerminalAssignment{} = terminal_assignment} <- Pos.create_terminal_assignment(terminal_assignment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/terminal_assignments/#{terminal_assignment}")
      |> render(:show, terminal_assignment: terminal_assignment)
    end
  end

  def show(conn, %{"id" => id}) do
    terminal_assignment = Pos.get_terminal_assignment!(id)
    render(conn, :show, terminal_assignment: terminal_assignment)
  end

  def update(conn, %{"id" => id, "terminal_assignment" => terminal_assignment_params}) do
    terminal_assignment = Pos.get_terminal_assignment!(id)

    with {:ok, %TerminalAssignment{} = terminal_assignment} <- Pos.update_terminal_assignment(terminal_assignment, terminal_assignment_params) do
      render(conn, :show, terminal_assignment: terminal_assignment)
    end
  end

  def delete(conn, %{"id" => id}) do
    terminal_assignment = Pos.get_terminal_assignment!(id)

    with {:ok, %TerminalAssignment{}} <- Pos.delete_terminal_assignment(terminal_assignment) do
      send_resp(conn, :no_content, "")
    end
  end
end
