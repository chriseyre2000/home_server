defmodule HomeServer.Router do
  use Plug.Router

  def child_spec do
    {
      Plug.Cowboy,
      scheme: :http,
      plug: HomeServer.Router,
      options: [port: (System.get_env("PORT") || "1066") |> String.to_integer()]
    }
  end

  plug(:match)
  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "This is a test...")
  end

  get "/control" do
    send_resp(conn, 200, '<a href="shutdown">Shut Me Down</a>')
  end

  get "/shutdown" do
    Task.start(fn ->
      Process.sleep(5_000)
      IO.puts("About to shutdown")
      System.stop()
    end)

    send_resp(conn, 200, "About to shutdown...")
  end

  match _ do
    send_resp(conn, 404, "Wrong place mate")
  end
end
