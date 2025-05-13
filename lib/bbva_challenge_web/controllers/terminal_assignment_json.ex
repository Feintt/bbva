defmodule BbvaChallengeWeb.TerminalAssignmentJSON do
  alias BbvaChallenge.Pos.TerminalAssignment

  @doc """
  Renders a list of terminal_assignments.
  """
  def index(%{terminal_assignments: terminal_assignments}) do
    %{data: for(terminal_assignment <- terminal_assignments, do: data(terminal_assignment))}
  end

  @doc """
  Renders a single terminal_assignment.
  """
  def show(%{terminal_assignment: terminal_assignment}) do
    %{data: data(terminal_assignment)}
  end

  defp data(%TerminalAssignment{} = terminal_assignment) do
    %{
      id: terminal_assignment.id
    }
  end
end
