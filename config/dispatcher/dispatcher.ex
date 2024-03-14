defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    sparql: [ "application/sparql-results+json" ],
    any: [ "*/*" ]
  ]

  @html %{ accept: %{ html: true } }
  @any %{ accept: %{ any: true } }

  ###############
  # SPARQL
  ###############

  match "/sparql", %{ accept: %{ sparql: true } } do
    Proxy.forward conn, [], "http://sparql-cache/sparql"
  end

  match "/raw-sparql", %{  accept: %{ sparql: true } } do
    Proxy.forward conn, [], "http://database:8890/sparql"
  end



  get "/published-resource-consumer/*path", @any do
    Proxy.forward conn, path, "http://published-resource-consumer/"
  end
  get "/agendas/*path", @any do
    Proxy.forward conn, path, "http://cache/agendas/"
  end

  get "/besluitenlijsten/*path", @any do
    Proxy.forward conn, path, "http://cache/besluitenlijsten/"
  end

  get "/uittreksels/*path", @any do
    Proxy.forward conn, path, "http://cache/uittreksels/"
  end

  get "/agendapunten/*path", @any do
    Proxy.forward conn, path, "http://cache/agendapunten/"
  end

  get "/behandelingen-van-agendapunten/*path", @any do
    Proxy.forward conn, path, "http://cache/behandelingen-van-agendapunten/"
  end

  get "/stemmingen/*path", @any do
    Proxy.forward conn, path, "http://cache/stemmingen/"
  end

  get "/besluiten/*path", @any do
    Proxy.forward conn, path, "http://cache/besluiten/"
  end

  get "/bestuurseenheden/*path", @any do
    Proxy.forward conn, path, "http://cache/bestuurseenheden/"
  end

  get "/werkingsgebieden/*path", @any do
    Proxy.forward conn, path, "http://cache/werkingsgebieden/"
  end

  get "/bestuurseenheid-classificatie-codes/*path", @any do
    IO.inspect(conn, label: "conn to cache")
    Proxy.forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end

  get "/bestuursorganen/*path", @any do
    Proxy.forward conn, path, "http://cache/bestuursorganen/"
  end

  get "/bestuursorgaan-classificatie-codes/*path", @any do
    Proxy.forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end

  get "/zittingen/*path", @any do
    Proxy.forward conn, path, "http://cache/zittingen/"
  end

  get "/notulen/*path", @any do
    Proxy.forward conn, path, "http://cache/notulen/"
  end


  get "/signed-resources/*path", @any do
    Proxy.forward conn, path, "http://cache/signed-resources/"
  end

  get "/published-resources/*path", @any do
    Proxy.forward conn, path, "http://cache/published-resources/"
  end

  get "/versioned-agendas/*path", @any do
    Proxy.forward conn, path, "http://cache/versioned-agendas/"
  end

  get "/versioned-besluiten-lijsten/*path", @any do
    Proxy.forward conn, path, "http://cache/versioned-besluiten-lijsten/"
  end

  get "/versioned-behandelingen/*path", @any do
    Proxy.forward conn, path, "http://cache/versioned-behandelingen/"
  end

  get "/versioned-notulen/*path", @any do
    Proxy.forward conn, path, "http://cache/versioned-notulen/"
  end

  get "/concepts/*path", @any do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  get "/concept-schemes/*path", @any do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/@appuniversum/*path", @any do
    Proxy.forward conn, path, "http://publicatie/@appuniversum/"
  end

  get "/assets/*path", @any do
    Proxy.forward conn, path, "http://publicatie/assets/"
  end

  get "/files/:id/download" do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end

  match "/favicon.ico", @any do
    send_resp( conn, 404, "" )
  end

  ###############
  # PERMALINKS
  ###############

  # This will catch calls to pages {HOST}/Aalst/Gemeente/zitting/b2f47ed1-3534-11e9-a984-7db43f975d75
  # and redirect them to {HOST}/Aalst/Gemeente/zittingen/b2f47ed1-3534-11e9-a984-7db43f975d75
  # Note "zitting" vs "zittingen
  get "/:bestuurseenheid_naam/:bestuurseenheid_classificatie_code_label/zitting/*path", @any do
    conn = Plug.Conn.put_resp_header( conn, "location", "/" <> bestuurseenheid_naam <> "/" <> bestuurseenheid_classificatie_code_label <> "/zittingen/" <> Enum.join( path, "/") )
    conn = send_resp( conn, 301, "" )
  end

  get "/permalink", @any do
    conn = Plug.Conn.fetch_query_params(conn)
    uri = conn.query_params["uri"]

    if !uri || uri == "" do
      send_resp( conn, 404, "" )
    else
      Proxy.forward conn, [], "http://cooluri" <> "?uri=" <> uri
    end
  end

  get "/*path", @html do
    # *_path allows a path to be supplied, but will not yield
    # an error that we don't use the path variable.
    Proxy.forward conn, path, "http://publicatie/"
  end

  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end
end
