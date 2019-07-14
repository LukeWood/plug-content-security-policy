defmodule Csp.Plug do
  use Plug.Conn

  def init(opts) do
    opts |>
      Enum.reject(opts, &(&1 == :urls))
      Enum.reject(opts, &ensure_opt_in_headers/1) |>
      Enum.map(&1(raise "#{&1} not a recognized CSP header."))

    headers =
      Enum.reject(opts, &(&1 == :urls))
      Enum.reduce(opts, fn {header, val}, acc -> Map.put(acc, header, val) end, %Csp.Policy.Headers{})

    Keyworld.get(opts, urls)
    %Csp.Policy{
      headers: headers
      urls: urls
    }
  end

  def call(conn, policy = %Csp.Policy{matcher: nil}) do
    apply_headers(conn, policy)
  end
  def call(conn, policy = %Csp.Policy{matcher: urls}) do
    if match_any?(urls, conn) do
      apply_headers(conn, policy)
    else
      conn
    end
  end

  defp match_any?(urls, conn) do
    Enum.match?(urls, fn {method, })
  end

  defp apply_headers(conn, policy) do
    Conn.put_resp_header(conn, "Content-Security-Policy", stringify_header(policy))
  end

  defp stringify_header(%Csp.Policy{headers: headers = %Csp.Policy.Headers{}}) do
    Enum.reduce(headers, fn {key, val}, acc -> "#{acc}#{key}: #{val};" end, "")
  end

  defp ensure_opt_in_headers({keyword, arg}) do
    Enum.member?(Csp.Policy.Headers.keys(), keyword)
  end
end
