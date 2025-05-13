defmodule BbvaChallenge.PosTest do
  use BbvaChallenge.DataCase

  alias BbvaChallenge.Pos

  describe "cash_boxes" do
    alias BbvaChallenge.Pos.CashBox

    import BbvaChallenge.PosFixtures

    @invalid_attrs %{state: nil, " ": nil}

    test "list_cash_boxes/0 returns all cash_boxes" do
      cash_box = cash_box_fixture()
      assert Pos.list_cash_boxes() == [cash_box]
    end

    test "get_cash_box!/1 returns the cash_box with given id" do
      cash_box = cash_box_fixture()
      assert Pos.get_cash_box!(cash_box.id) == cash_box
    end

    test "create_cash_box/1 with valid data creates a cash_box" do
      valid_attrs = %{state: "some state", " ": "some  "}

      assert {:ok, %CashBox{} = cash_box} = Pos.create_cash_box(valid_attrs)
      assert cash_box.state == "some state"
      assert cash_box.  == "some  "
    end

    test "create_cash_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_cash_box(@invalid_attrs)
    end

    test "update_cash_box/2 with valid data updates the cash_box" do
      cash_box = cash_box_fixture()
      update_attrs = %{state: "some updated state", " ": "some updated  "}

      assert {:ok, %CashBox{} = cash_box} = Pos.update_cash_box(cash_box, update_attrs)
      assert cash_box.state == "some updated state"
      assert cash_box.  == "some updated  "
    end

    test "update_cash_box/2 with invalid data returns error changeset" do
      cash_box = cash_box_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_cash_box(cash_box, @invalid_attrs)
      assert cash_box == Pos.get_cash_box!(cash_box.id)
    end

    test "delete_cash_box/1 deletes the cash_box" do
      cash_box = cash_box_fixture()
      assert {:ok, %CashBox{}} = Pos.delete_cash_box(cash_box)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_cash_box!(cash_box.id) end
    end

    test "change_cash_box/1 returns a cash_box changeset" do
      cash_box = cash_box_fixture()
      assert %Ecto.Changeset{} = Pos.change_cash_box(cash_box)
    end
  end

  describe "cash_boxes" do
    alias BbvaChallenge.Pos.CashBox

    import BbvaChallenge.PosFixtures

    @invalid_attrs %{state: nil, opened_at: nil, closed_at: nil, initial_balance: nil, final_balance: nil}

    test "list_cash_boxes/0 returns all cash_boxes" do
      cash_box = cash_box_fixture()
      assert Pos.list_cash_boxes() == [cash_box]
    end

    test "get_cash_box!/1 returns the cash_box with given id" do
      cash_box = cash_box_fixture()
      assert Pos.get_cash_box!(cash_box.id) == cash_box
    end

    test "create_cash_box/1 with valid data creates a cash_box" do
      valid_attrs = %{state: "some state", opened_at: ~U[2025-05-12 19:40:00Z], closed_at: ~U[2025-05-12 19:40:00Z], initial_balance: "120.5", final_balance: "120.5"}

      assert {:ok, %CashBox{} = cash_box} = Pos.create_cash_box(valid_attrs)
      assert cash_box.state == "some state"
      assert cash_box.opened_at == ~U[2025-05-12 19:40:00Z]
      assert cash_box.closed_at == ~U[2025-05-12 19:40:00Z]
      assert cash_box.initial_balance == Decimal.new("120.5")
      assert cash_box.final_balance == Decimal.new("120.5")
    end

    test "create_cash_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_cash_box(@invalid_attrs)
    end

    test "update_cash_box/2 with valid data updates the cash_box" do
      cash_box = cash_box_fixture()
      update_attrs = %{state: "some updated state", opened_at: ~U[2025-05-13 19:40:00Z], closed_at: ~U[2025-05-13 19:40:00Z], initial_balance: "456.7", final_balance: "456.7"}

      assert {:ok, %CashBox{} = cash_box} = Pos.update_cash_box(cash_box, update_attrs)
      assert cash_box.state == "some updated state"
      assert cash_box.opened_at == ~U[2025-05-13 19:40:00Z]
      assert cash_box.closed_at == ~U[2025-05-13 19:40:00Z]
      assert cash_box.initial_balance == Decimal.new("456.7")
      assert cash_box.final_balance == Decimal.new("456.7")
    end

    test "update_cash_box/2 with invalid data returns error changeset" do
      cash_box = cash_box_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_cash_box(cash_box, @invalid_attrs)
      assert cash_box == Pos.get_cash_box!(cash_box.id)
    end

    test "delete_cash_box/1 deletes the cash_box" do
      cash_box = cash_box_fixture()
      assert {:ok, %CashBox{}} = Pos.delete_cash_box(cash_box)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_cash_box!(cash_box.id) end
    end

    test "change_cash_box/1 returns a cash_box changeset" do
      cash_box = cash_box_fixture()
      assert %Ecto.Changeset{} = Pos.change_cash_box(cash_box)
    end
  end

  describe "cash_movements" do
    alias BbvaChallenge.Pos.CashMovement

    import BbvaChallenge.PosFixtures

    @invalid_attrs %{type: nil, date: nil, description: nil, payment_method: nil, amount: nil}

    test "list_cash_movements/0 returns all cash_movements" do
      cash_movement = cash_movement_fixture()
      assert Pos.list_cash_movements() == [cash_movement]
    end

    test "get_cash_movement!/1 returns the cash_movement with given id" do
      cash_movement = cash_movement_fixture()
      assert Pos.get_cash_movement!(cash_movement.id) == cash_movement
    end

    test "create_cash_movement/1 with valid data creates a cash_movement" do
      valid_attrs = %{type: "some type", date: ~U[2025-05-12 19:41:00Z], description: "some description", payment_method: "some payment_method", amount: "120.5"}

      assert {:ok, %CashMovement{} = cash_movement} = Pos.create_cash_movement(valid_attrs)
      assert cash_movement.type == "some type"
      assert cash_movement.date == ~U[2025-05-12 19:41:00Z]
      assert cash_movement.description == "some description"
      assert cash_movement.payment_method == "some payment_method"
      assert cash_movement.amount == Decimal.new("120.5")
    end

    test "create_cash_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_cash_movement(@invalid_attrs)
    end

    test "update_cash_movement/2 with valid data updates the cash_movement" do
      cash_movement = cash_movement_fixture()
      update_attrs = %{type: "some updated type", date: ~U[2025-05-13 19:41:00Z], description: "some updated description", payment_method: "some updated payment_method", amount: "456.7"}

      assert {:ok, %CashMovement{} = cash_movement} = Pos.update_cash_movement(cash_movement, update_attrs)
      assert cash_movement.type == "some updated type"
      assert cash_movement.date == ~U[2025-05-13 19:41:00Z]
      assert cash_movement.description == "some updated description"
      assert cash_movement.payment_method == "some updated payment_method"
      assert cash_movement.amount == Decimal.new("456.7")
    end

    test "update_cash_movement/2 with invalid data returns error changeset" do
      cash_movement = cash_movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_cash_movement(cash_movement, @invalid_attrs)
      assert cash_movement == Pos.get_cash_movement!(cash_movement.id)
    end

    test "delete_cash_movement/1 deletes the cash_movement" do
      cash_movement = cash_movement_fixture()
      assert {:ok, %CashMovement{}} = Pos.delete_cash_movement(cash_movement)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_cash_movement!(cash_movement.id) end
    end

    test "change_cash_movement/1 returns a cash_movement changeset" do
      cash_movement = cash_movement_fixture()
      assert %Ecto.Changeset{} = Pos.change_cash_movement(cash_movement)
    end
  end

  describe "pos_terminals" do
    alias BbvaChallenge.Pos.Terminal

    import BbvaChallenge.PosFixtures

    @invalid_attrs %{name: nil, qr_code_url: nil}

    test "list_pos_terminals/0 returns all pos_terminals" do
      terminal = terminal_fixture()
      assert Pos.list_pos_terminals() == [terminal]
    end

    test "get_terminal!/1 returns the terminal with given id" do
      terminal = terminal_fixture()
      assert Pos.get_terminal!(terminal.id) == terminal
    end

    test "create_terminal/1 with valid data creates a terminal" do
      valid_attrs = %{name: "some name", qr_code_url: "some qr_code_url"}

      assert {:ok, %Terminal{} = terminal} = Pos.create_terminal(valid_attrs)
      assert terminal.name == "some name"
      assert terminal.qr_code_url == "some qr_code_url"
    end

    test "create_terminal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_terminal(@invalid_attrs)
    end

    test "update_terminal/2 with valid data updates the terminal" do
      terminal = terminal_fixture()
      update_attrs = %{name: "some updated name", qr_code_url: "some updated qr_code_url"}

      assert {:ok, %Terminal{} = terminal} = Pos.update_terminal(terminal, update_attrs)
      assert terminal.name == "some updated name"
      assert terminal.qr_code_url == "some updated qr_code_url"
    end

    test "update_terminal/2 with invalid data returns error changeset" do
      terminal = terminal_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_terminal(terminal, @invalid_attrs)
      assert terminal == Pos.get_terminal!(terminal.id)
    end

    test "delete_terminal/1 deletes the terminal" do
      terminal = terminal_fixture()
      assert {:ok, %Terminal{}} = Pos.delete_terminal(terminal)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_terminal!(terminal.id) end
    end

    test "change_terminal/1 returns a terminal changeset" do
      terminal = terminal_fixture()
      assert %Ecto.Changeset{} = Pos.change_terminal(terminal)
    end
  end

  describe "terminal_assignments" do
    alias BbvaChallenge.Pos.TerminalAssignment

    import BbvaChallenge.PosFixtures

    @invalid_attrs %{}

    test "list_terminal_assignments/0 returns all terminal_assignments" do
      terminal_assignment = terminal_assignment_fixture()
      assert Pos.list_terminal_assignments() == [terminal_assignment]
    end

    test "get_terminal_assignment!/1 returns the terminal_assignment with given id" do
      terminal_assignment = terminal_assignment_fixture()
      assert Pos.get_terminal_assignment!(terminal_assignment.id) == terminal_assignment
    end

    test "create_terminal_assignment/1 with valid data creates a terminal_assignment" do
      valid_attrs = %{}

      assert {:ok, %TerminalAssignment{} = terminal_assignment} = Pos.create_terminal_assignment(valid_attrs)
    end

    test "create_terminal_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_terminal_assignment(@invalid_attrs)
    end

    test "update_terminal_assignment/2 with valid data updates the terminal_assignment" do
      terminal_assignment = terminal_assignment_fixture()
      update_attrs = %{}

      assert {:ok, %TerminalAssignment{} = terminal_assignment} = Pos.update_terminal_assignment(terminal_assignment, update_attrs)
    end

    test "update_terminal_assignment/2 with invalid data returns error changeset" do
      terminal_assignment = terminal_assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_terminal_assignment(terminal_assignment, @invalid_attrs)
      assert terminal_assignment == Pos.get_terminal_assignment!(terminal_assignment.id)
    end

    test "delete_terminal_assignment/1 deletes the terminal_assignment" do
      terminal_assignment = terminal_assignment_fixture()
      assert {:ok, %TerminalAssignment{}} = Pos.delete_terminal_assignment(terminal_assignment)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_terminal_assignment!(terminal_assignment.id) end
    end

    test "change_terminal_assignment/1 returns a terminal_assignment changeset" do
      terminal_assignment = terminal_assignment_fixture()
      assert %Ecto.Changeset{} = Pos.change_terminal_assignment(terminal_assignment)
    end
  end
end
