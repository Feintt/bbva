alias BbvaChallenge.Repo

# Contexts
alias BbvaChallenge.{Accounts, Accounting, Pos}

# Schemas
alias BbvaChallenge.Businesses.Company
alias BbvaChallenge.Accounting.{Account, Transaction}
alias BbvaChallenge.Pos.{CashBox, CashMovement, Terminal, TerminalAssignment}

# -------------------------------------------------------------------
# 📌 1. Datos base de la empresa + docs
company_attrs = %{
  name: "Seed Corp",
  rfc: "SEED123456XYZ",
  # <─ enum
  society_type: :sa_de_cv,
  fiscal_address: "Av. Siempre Viva 742, CDMX",
  # <─ enum
  industry: :tecnologia,
  official_id: "/uploads/seedcorp/ine.pdf",
  e_signature: "/uploads/seedcorp/efirma.zip"
}

admin_attrs = %{
  email: "admin@seedcorp.com",
  password: "admin123!",
  name: "Seed Admin",
  role: :administrador
}

# -------------------------------------------------------------------
Ecto.Multi.new()
# 1) Empresa ---------------------------------------------------------
|> Ecto.Multi.insert(:company, Company.changeset(%Company{}, company_attrs))

# 2) Admin vinculado a la empresa ------------------------------------
|> Ecto.Multi.run(:admin, fn _repo, %{company: company} ->
  attrs = Map.put(admin_attrs, :company_id, company.id)
  Accounts.register_user(attrs)
end)

# 3) Cuentas contables ----------------------------------------------
|> Ecto.Multi.insert(:bi_account, fn %{company: company} ->
  Accounting.change_account(%Account{}, %{
    name: "Cuenta Banco (bi)",
    direction: :bi,
    current_balance: 0,
    company_id: company.id
  })
end)
|> Ecto.Multi.insert(:uni_account, fn %{company: company} ->
  Accounting.change_account(%Account{}, %{
    name: "Ingresos Efectivo (uni)",
    direction: :uni,
    current_balance: 0,
    company_id: company.id
  })
end)

# 4) Caja abierta ----------------------------------------------------
|> Ecto.Multi.insert(:cash_box, fn %{company: company, admin: admin, bi_account: acct} ->
  Pos.change_cash_box(%CashBox{}, %{
    state: :abierta,
    opened_at: DateTime.utc_now(),
    initial_balance: 0,
    user_id: admin.id,
    company_id: company.id,
    account_id: acct.id
  })
end)

# 5) Asiento contable (Transaction) ---------------------------------
|> Ecto.Multi.insert(:transaction, fn %{bi_account: acct, admin: admin} ->
  Accounting.change_transaction(%Transaction{}, %{
    kind: :ingreso,
    amount: 100,
    description: "Venta inicial (seed)",
    date: DateTime.utc_now(),
    account_id: acct.id,
    # ahora ligado al usuario
    user_id: admin.id
  })
end)

# 6) Apunte de caja (CashMovement) -----------------------------------
|> Ecto.Multi.insert(:cash_movement, fn %{cash_box: box, transaction: trx} ->
  Pos.change_cash_movement(%CashMovement{}, %{
    type: :ingreso,
    payment_method: :efectivo,
    amount: 100,
    description: "Venta inicial (seed)",
    date: DateTime.utc_now(),
    cash_box_id: box.id,
    transaction_id: trx.id
  })
end)

# 7) Terminal POS -----------------------------------------------------
|> Ecto.Multi.insert(:terminal, fn %{company: company} ->
  Pos.change_terminal(%Terminal{}, %{
    name: "Terminal Principal",
    qr_code_url: "https://qr.seedcorp.local/abc123",
    company_id: company.id
  })
end)

# 8) Asignación admin ↔ terminal -------------------------------------
|> Ecto.Multi.insert(:terminal_assignment, fn %{terminal: term, admin: admin} ->
  Pos.change_terminal_assignment(%TerminalAssignment{}, %{
    user_id: admin.id,
    terminal_id: term.id
  })
end)

# -------------------------------------------------------------------
|> Repo.transaction()
|> case do
  {:ok, _result} ->
    IO.puts("""
    ✅ Seed completo:
      • Empresa.............. #{company_attrs.name}
      • Admin email.......... #{admin_attrs.email}
      • Cuentas.............. bi & uni
      • Caja abierta......... ligada al admin
      • Transaction.......... ingreso 100 con user_id
      • CashMovement......... enlazado a caja/transacción
      • Terminal POS......... creado y asignado al admin
    """)

  {:error, step, changeset, _} ->
    IO.puts("❌ Seed abortado en #{step}")
    IO.inspect(changeset.errors, label: "Errores")
end
