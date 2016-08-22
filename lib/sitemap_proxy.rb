# frozen_string_literal: true

require "sitemap_proxy/version"
require "http"

class SitemapProxy
  HEADERS = {
    'Cache-Control' => 'public, max-age=3600'
  }.freeze

  def initialize(root)
    @root = root.chomp('/')
  end

  def call(env)
    url = "#{@root}#{env['PATH_INFO']}"
    response = HTTP.get(url)

    headers = HEADERS.dup

    # TODO helpers added to HTTP 2.0: https://github.com/httprb/http/pull/331
    if response.code >= 200 && response.code < 300
      content_type = response.headers['Content-Type']
      headers['Content-Type'] = content_type if content_type.present?

      [200, headers, response.body]
    elsif [403, 404].include?(response.code)
      [404, headers, ["not found"]]
    else
      raise "failed to fetch sitemap.xml: #{response.code}"
    end
  end
end
