defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/published-resource-consumer/*path" do
    Proxy.forward conn, path, "http://published-resource-consumer/"
  end
  match "/agendas/*path" do
    Proxy.forward conn, path, "http://resource/agendas/"
  end

  match "/besluitenlijsten/*path" do
    Proxy.forward conn, path, "http://resource/besluitenlijsten/"
  end

  match "/uittreksels/*path" do
    Proxy.forward conn, path, "http://resource/uittreksels/"
  end

  match "/agendapunten/*path" do
    Proxy.forward conn, path, "http://resource/agendapunten/"
  end

  match "/behandelingen-van-agendapunten/*path" do
    Proxy.forward conn, path, "http://resource/behandelingen-van-agendapunten/"
  end

  match "/stemmingen/*path" do
    Proxy.forward conn, path, "http://resource/stemmingen/"
  end

  match "/besluiten/*path" do
    Proxy.forward conn, path, "http://resource/besluiten/"
  end

  match "/bestuurseenheden/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheden/"
  end

  match "/werkingsgebieden/*path" do
    Proxy.forward conn, path, "http://cache/werkingsgebieden/"
  end

  match "/bestuurseenheid-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end

  match "/bestuursorganen/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorganen/"
  end

  match "/bestuursorgaan-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end

  match "/zittingen/*path" do
    Proxy.forward conn, path, "http://resource/zittingen/"
  end

  match "/notulen/*path" do
    Proxy.forward conn, path, "http://resource/notulen/"
  end


  match "/signed-resources/*path" do
    Proxy.forward conn, path, "http://resource/signed-resources/"
  end

  match "/published-resources/*path" do
    Proxy.forward conn, path, "http://resource/published-resources/"
  end

  match "/versioned-agendas/*path" do
    Proxy.forward conn, path, "http://resource/versioned-agendas/"
  end

  match "/versioned-besluiten-lijsten/*path" do
    Proxy.forward conn, path, "http://resource/versioned-besluiten-lijsten/"
  end

  match "/versioned-behandelingen/*path" do
    Proxy.forward conn, path, "http://resource/versioned-behandelingen/"
  end

  match "/versioned-notulen/*path" do
    Proxy.forward conn, path, "http://resource/versioned-notulen/"
  end
end
