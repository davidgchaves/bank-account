defmodule BankAccount do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    BankAccount.Supervisor.start_link
  end

  def start do
    await
  end

  def await do
    receive do
      {:check_balance, pid} -> divulge_balance pid
    end
    await
  end

  defp divulge_balance(pid) do
    send pid, {:balance, 0}
  end
end
