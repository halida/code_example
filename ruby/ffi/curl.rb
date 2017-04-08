# doc: https://curl.haxx.se/libcurl/c/

require 'ffi'

module Curl
  extend FFI::Library
  ffi_lib 'curl'

  attach_function :curl_easy_init, [], :pointer
  attach_function :curl_easy_setopt, [curl, CURLOPT_URL, "http://example.com"]
  attach_function :curl_easy_perform, [:pointer]
  attach_function :curl_easy_cleanup, [:pointer]
end

def run
  curl = Curl.curl_easy_init
  raise "cannot get curl" unless curl

  curl_easy_setopt(curl, Curl::CURLOPT_URL, "http://example.com")
  res = curl_easy_perform(curl)

  curl_easy_cleanup(curl)
end

