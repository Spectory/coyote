defmodule CoyoteWeb.AdminController do
  use CoyoteWeb, :controller
  use Coyote.Constants

  def index(conn, _params) do
    render_index(conn, 10)
  end

  def create_topic(conn, %{"topic" => %{"name" => name}}) do
    create_topic(name)
    redirect conn, to: "/admin"
  end

  defp create_topic(name) do
    Coyote.Cache.insert(@user_channel_cache, {name, 0})
    Coyote.Cache.to_file(@user_channel_cache)
  end

  defp render_index(conn, token_count \\ 0) do
    topics = @user_channel_cache
      |> Coyote.Cache.to_list
      |> Enum.map(&(Tuple.to_list &1))
      |> Enum.map(&(List.first &1))
      |> Enum.sort
    tokens = 0..token_count
      |> Enum.to_list
      |> Coyote.Auth.sign_all
    render conn, "index.html", %{topics: topics, tokens: tokens}
  end
end
