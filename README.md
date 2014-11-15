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

Due to the use of keyword arguments this gem requires Ruby 2.0 and above.

## Configuration

This gem uses VCR for testing. https://github.com/vcr/vcr

To run gem tests complete the following:

1. Obtain a Zenodo API token from their site. https://zenodo.org.
2. Create file gem_secret.yml in the gems config folder.
3. Add the following to your gem_secret.yml file. ```zenodo_api_key: '<YOUR API TOKEN>'```
4. Run rspec as normal.

VCR will create fixtures in the spec/fixtures/vcr_cassettes folder.

## Usage

Set the client API key.
```
Zenodo.api_key = <your API key>
```

Get depositions.
```
depositions = Zenodo.client.get_depositions
```

Get a deposition.
```
deposition = Zenodo.client.get_deposition(id: 1)
```

Create a deposition.
```
# Build JSON serialized attributes.
# The gem won't do this for you. You need to build a serializer that meets your needs."
deposition_attributes = {
  'metadata' => {
    'title' => 'My first upload',
    'upload_type' => 'poster',
    'description' => 'This is my first upload',
    'creators' =>[{'name' => 'Doe, John','affiliation' => 'ZENODO'}]
  }
}

# Create the deposition.
deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
```

Update a deposition.
```
# Build JSON serialized attributes.
# The gem won't do this for you. You need to build a serializer that meets your needs."
# deposition_attributes = <same as create>

# Update the deposition.
deposition = Zenodo.client.update_deposition(id: 1, deposition: deposition_attributes)
```

Delete a deposition.
```
Zenodo.client.delete_deposition(id: 1)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zenodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
