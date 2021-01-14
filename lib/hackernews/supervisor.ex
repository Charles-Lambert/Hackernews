defmodule Hackernews.Supervisor do
  use Supervisor
  use Application

  def start(_args, _opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {Hackernews.Server, name: Hackernews.Server},
      {Hackernews.Update_Timer, name: Hackernews.Update_Timer}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
