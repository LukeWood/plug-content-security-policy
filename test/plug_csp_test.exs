defmodule PlugCspTest do
  use ExUnit.Case
  use Plug.Test

  test "removes the cross origin header" do
    conn = conn(:get, "/hello")
    conn = Plug.IFrame.call(conn, @allow)
    assert !Keyword.has_key?(conn.resp_headers, :"x-frame-options")
  end

end
