defmodule BankAccount do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    BankAccount.Supervisor.start_link
  end
end
