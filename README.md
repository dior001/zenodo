# Zenodo

A Ruby wrapper for the Zenodo API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenodo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zenodo

## Usage

Set the client API key.
```
Zenodo.api_key = <your API key>
```

Get depositions.
```
depositions = Zenodo.client.get_depositions
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zenodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
