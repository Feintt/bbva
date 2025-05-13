defmodule BbvaChallengeWeb.TerminalJSON do
  alias BbvaChallenge.Pos.Terminal

  @doc """
  Renders a list of pos_terminals.
  """
  def index(%{pos_terminals: pos_terminals}) do
    %{data: for(terminal <- pos_terminals, do: data(terminal))}
  end

  @doc """
  Renders a single terminal.
  """
  def show(%{terminal: terminal}) do
    %{data: data(terminal)}
  end

  defp data(%Terminal{} = terminal) do
    %{
      id: terminal.id,
      name: terminal.name,
      qr_code_url: terminal.qr_code_url
    }
  end
end
