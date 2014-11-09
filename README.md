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

Get a deposition.
```
deposition = Insightly.client.get_deposition(id: 1)
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
deposition = Insightly.client.create_deposition(deposition: deposition_attributes)
```

Update a deposition.
```
# Build JSON serialized attributes.
# The gem won't do this for you. You need to build a serializer that meets your needs."
# deposition_attributes = <same as create>

# Update the deposition.
deposition = Insightly.client.update_deposition(id: 1, deposition: deposition_attributes)
```

Delete a deposition.
```
Insightly.client.delete_deposition(id: 1)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zenodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
