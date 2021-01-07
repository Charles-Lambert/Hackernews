defmodule Hackernews.Server do
  use GenServer
  require Logger


  def list_url do
    Application.fetch_env!(:hackernews, :list_url)
  end

  def story_url do
    Application.fetch_env!(:hackernews, :story_url)
  end


  def update(server) do
    GenServer.cast(server, {:update})
  end

  def get_value(server, key) do
    GenServer.call(server, {:get, key})
  end

  def start_link(_opts) do
    GenServer.start(__MODULE__, :ok, name: __MODULE__)
  end

  def get_id_list(url) do
    with {:ok, response} <- HTTPoison.get(url),
         {:ok, id_list} <- Jason.decode(response.body),
         do: {:ok, id_list}
  end

  def get_details(incomplete_url, id) do
    url = ~s/#{incomplete_url}#{id}.json/
    with {:ok, response} <- HTTPoison.get(url),
         {:ok, details} <- Jason.decode(response.body, [keys: :strings]),
         do: {:ok, details}
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:update}, old_details) do
    case get_id_list(list_url()) do
      {:ok, id_list} -> id = id_list |> hd
      case get_details(story_url(), id) do
        {:ok, details} -> {:noreply, details}
        {:error, reason} ->
          Logger.warn ~s/failed for reason: #{reason}/
            {:noreply, old_details}
        _ -> 
          Logger.warn ~s/failed for unknown reason/
            {:noreply, old_details}
      end
      {:error, reason} ->
        Logger.warn ~s/id_list failed for reason: #{reason}/
          {:norply, old_details}
      _ -> 
        Logger.warn ~s/id_list failed for unknown reason/
          {:noreply, old_details}
    end
  end

  def handle_call({:get, key}, _from, details) do
    {:reply, details[key], details}
  end
end
