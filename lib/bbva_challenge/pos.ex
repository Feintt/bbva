defmodule BbvaChallenge.Pos do
  @moduledoc """
  The Pos context.
  """

  import Ecto.Query, warn: false
  alias BbvaChallenge.Repo

  alias BbvaChallenge.Pos.CashBox

  @doc """
  Returns the list of cash_boxes.

  ## Examples

      iex> list_cash_boxes()
      [%CashBox{}, ...]

  """
  def list_cash_boxes do
    Repo.all(CashBox)
  end

  @doc """
  Gets a single cash_box.

  Raises `Ecto.NoResultsError` if the Cash box does not exist.

  ## Examples

      iex> get_cash_box!(123)
      %CashBox{}

      iex> get_cash_box!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cash_box!(id), do: Repo.get!(CashBox, id)

  @doc """
  Creates a cash_box.

  ## Examples

      iex> create_cash_box(%{field: value})
      {:ok, %CashBox{}}

      iex> create_cash_box(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cash_box(attrs \\ %{}) do
    %CashBox{}
    |> CashBox.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cash_box.

  ## Examples

      iex> update_cash_box(cash_box, %{field: new_value})
      {:ok, %CashBox{}}

      iex> update_cash_box(cash_box, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cash_box(%CashBox{} = cash_box, attrs) do
    cash_box
    |> CashBox.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cash_box.

  ## Examples

      iex> delete_cash_box(cash_box)
      {:ok, %CashBox{}}

      iex> delete_cash_box(cash_box)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cash_box(%CashBox{} = cash_box) do
    Repo.delete(cash_box)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cash_box changes.

  ## Examples

      iex> change_cash_box(cash_box)
      %Ecto.Changeset{data: %CashBox{}}

  """
  def change_cash_box(%CashBox{} = cash_box, attrs \\ %{}) do
    CashBox.changeset(cash_box, attrs)
  end

  alias BbvaChallenge.Pos.CashMovement

  @doc """
  Returns the list of cash_movements.

  ## Examples

      iex> list_cash_movements()
      [%CashMovement{}, ...]

  """
  def list_cash_movements do
    Repo.all(CashMovement)
  end

  @doc """
  Gets a single cash_movement.

  Raises `Ecto.NoResultsError` if the Cash movement does not exist.

  ## Examples

      iex> get_cash_movement!(123)
      %CashMovement{}

      iex> get_cash_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cash_movement!(id), do: Repo.get!(CashMovement, id)

  @doc """
  Creates a cash_movement.

  ## Examples

      iex> create_cash_movement(%{field: value})
      {:ok, %CashMovement{}}

      iex> create_cash_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cash_movement(attrs \\ %{}),
    do:
      BbvaChallenge.Pos.CashMovement
      |> struct()
      |> BbvaChallenge.Pos.CashMovement.changeset(attrs)
      |> Repo.insert()

  @doc """
  Updates a cash_movement.

  ## Examples

      iex> update_cash_movement(cash_movement, %{field: new_value})
      {:ok, %CashMovement{}}

      iex> update_cash_movement(cash_movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cash_movement(%CashMovement{} = cash_movement, attrs) do
    cash_movement
    |> CashMovement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cash_movement.

  ## Examples

      iex> delete_cash_movement(cash_movement)
      {:ok, %CashMovement{}}

      iex> delete_cash_movement(cash_movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cash_movement(%CashMovement{} = cash_movement) do
    Repo.delete(cash_movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cash_movement changes.

  ## Examples

      iex> change_cash_movement(cash_movement)
      %Ecto.Changeset{data: %CashMovement{}}

  """
  def change_cash_movement(%CashMovement{} = cash_movement, attrs \\ %{}) do
    CashMovement.changeset(cash_movement, attrs)
  end

  alias BbvaChallenge.Pos.Terminal

  @doc """
  Returns the list of pos_terminals.

  ## Examples

      iex> list_pos_terminals()
      [%Terminal{}, ...]

  """
  def list_pos_terminals do
    Repo.all(Terminal)
  end

  @doc """
  Gets a single terminal.

  Raises `Ecto.NoResultsError` if the Terminal does not exist.

  ## Examples

      iex> get_terminal!(123)
      %Terminal{}

      iex> get_terminal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_terminal!(id), do: Repo.get!(Terminal, id)

  @doc """
  Creates a terminal.

  ## Examples

      iex> create_terminal(%{field: value})
      {:ok, %Terminal{}}

      iex> create_terminal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_terminal(attrs \\ %{}) do
    %Terminal{}
    |> Terminal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a terminal.

  ## Examples

      iex> update_terminal(terminal, %{field: new_value})
      {:ok, %Terminal{}}

      iex> update_terminal(terminal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_terminal(%Terminal{} = terminal, attrs) do
    terminal
    |> Terminal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a terminal.

  ## Examples

      iex> delete_terminal(terminal)
      {:ok, %Terminal{}}

      iex> delete_terminal(terminal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_terminal(%Terminal{} = terminal) do
    Repo.delete(terminal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking terminal changes.

  ## Examples

      iex> change_terminal(terminal)
      %Ecto.Changeset{data: %Terminal{}}

  """
  def change_terminal(%Terminal{} = terminal, attrs \\ %{}) do
    Terminal.changeset(terminal, attrs)
  end

  alias BbvaChallenge.Pos.TerminalAssignment

  @doc """
  Returns the list of terminal_assignments.

  ## Examples

      iex> list_terminal_assignments()
      [%TerminalAssignment{}, ...]

  """
  def list_terminal_assignments do
    Repo.all(TerminalAssignment)
  end

  @doc """
  Gets a single terminal_assignment.

  Raises `Ecto.NoResultsError` if the Terminal assignment does not exist.

  ## Examples

      iex> get_terminal_assignment!(123)
      %TerminalAssignment{}

      iex> get_terminal_assignment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_terminal_assignment!(id), do: Repo.get!(TerminalAssignment, id)

  @doc """
  Creates a terminal_assignment.

  ## Examples

      iex> create_terminal_assignment(%{field: value})
      {:ok, %TerminalAssignment{}}

      iex> create_terminal_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_terminal_assignment(attrs \\ %{}) do
    %TerminalAssignment{}
    |> TerminalAssignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a terminal_assignment.

  ## Examples

      iex> update_terminal_assignment(terminal_assignment, %{field: new_value})
      {:ok, %TerminalAssignment{}}

      iex> update_terminal_assignment(terminal_assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_terminal_assignment(%TerminalAssignment{} = terminal_assignment, attrs) do
    terminal_assignment
    |> TerminalAssignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a terminal_assignment.

  ## Examples

      iex> delete_terminal_assignment(terminal_assignment)
      {:ok, %TerminalAssignment{}}

      iex> delete_terminal_assignment(terminal_assignment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_terminal_assignment(%TerminalAssignment{} = terminal_assignment) do
    Repo.delete(terminal_assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking terminal_assignment changes.

  ## Examples

      iex> change_terminal_assignment(terminal_assignment)
      %Ecto.Changeset{data: %TerminalAssignment{}}

  """
  def change_terminal_assignment(%TerminalAssignment{} = terminal_assignment, attrs \\ %{}) do
    TerminalAssignment.changeset(terminal_assignment, attrs)
  end

  @doc """
  Devuelve `{:ok, caja}` si el usuario tiene una caja abierta.
  """
  def get_open_box(user_id) do
    CashBox
    |> where([c], c.user_id == ^user_id and c.state == :abierta)
    |> Repo.one()
    |> case do
      nil -> {:error, :no_open_box}
      box -> {:ok, box}
    end
  end
end
