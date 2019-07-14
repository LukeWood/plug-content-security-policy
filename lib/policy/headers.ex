defmodule Csp.Policy.Headers do
  @keys [
    [
      :"child-src",
      :"connect-src",
      :"default-src",
      :"font-src",
      :"frame-src",
      :"img-src",
      :"manifest-src",
      :"media-src",
      :"object-src",
      :"prefetch-src",
      :"script-src",
      :"webrtc-src",
      :"worker-src",
      :"base-uri",
      :"plugin-types",
      :"sandbox",
      :"disown-opener",
      :"form-action",
      :"frame-ancestors",
      :"navigate-to",
      :"report-uri",
      :"report-to",
      :"block-all-mixed-content",
      :"referrer",
      :"trusted-types",
      :"upgrade-insecure-requests",
      :"require-sri-for"
    ]
  ]

  def keys, do: @keys
  defstruct @keys
end
