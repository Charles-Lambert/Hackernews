defmodule Hackernews.Update_Timer do
  use Task
  require Logger

  def interval do
    Application.fetch_env!(:hackernews, :interval)
  end

  def loop do
    Hackernews.Server.update(Hackernews.Server)
    Logger.debug("triggering update")
    :timer.sleep(interval())
    loop()
  end

  def start_link(_pid) do
    Task.start(__MODULE__, :loop, [])
  end
end
