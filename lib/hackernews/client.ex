defmodule Hackernews.Client do

  def latest_title do
    title=Hackernews.Server.get_value(Hackernews.Server, "title")
    IO.puts(title)
  end

end
