defmodule BbvaChallengeWeb.TerminalController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Pos
  alias BbvaChallenge.Pos.Terminal

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    pos_terminals = Pos.list_pos_terminals()
    render(conn, :index, pos_terminals: pos_terminals)
  end

  def create(conn, %{"terminal" => terminal_params}) do
    with {:ok, %Terminal{} = terminal} <- Pos.create_terminal(terminal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/pos_terminals/#{terminal}")
      |> render(:show, terminal: terminal)
    end
  end

  def show(conn, %{"id" => id}) do
    terminal = Pos.get_terminal!(id)
    render(conn, :show, terminal: terminal)
  end

  def update(conn, %{"id" => id, "terminal" => terminal_params}) do
    terminal = Pos.get_terminal!(id)

    with {:ok, %Terminal{} = terminal} <- Pos.update_terminal(terminal, terminal_params) do
      render(conn, :show, terminal: terminal)
    end
  end

  def delete(conn, %{"id" => id}) do
    terminal = Pos.get_terminal!(id)

    with {:ok, %Terminal{}} <- Pos.delete_terminal(terminal) do
      send_resp(conn, :no_content, "")
    end
  end
end
