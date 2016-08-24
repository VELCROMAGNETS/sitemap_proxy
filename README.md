# SitemapProxy

A simple rack app for proxying requests for sitemap.xml to a remote host.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sitemap_proxy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sitemap_proxy

## Usage

This gem includes a single rack app called `SitemapProxy` that you should mount at the desired path. For example, to mount it in a Rails routes.rb file, use:

```ruby
get ':path',
  constraints: { path: %r{sitemap\d*\.xml(.gz)?} },
  to: SitemapProxy.new(SITEMAP_HOST)
```

## CDN

Be sure to use a CDN in front of your app since the request to the remote host can be slow and this will tie up your web thread/process.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sitemap_proxy.

