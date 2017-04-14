<h1 align="center">
<img src="https://cdn.rawgit.com/stickermule/http-cage/example/assets/images/http-case_logo.svg" width="500">
</h1>

# HTTP-Cage.

Global timeouts for Ruby's `Net::HTTP`.

## Why.

`Net::HTTP` by default has a connect timeout of 60 seconds and a request timeout of 60 seconds, a 2 minutes worst-case scenario timeout, with auto-retry.

These defaults are kinda dangerous in a micro-services environment, where requests should happen fast or just timeout, to avoid server processes locking.

This gem lets you globally restrict timeouts of `Net::HTTP` calls, so that all gems and libraries that use `Net::HTTP` will timeout fast.

## Installation.

- Add it to your Gemfile:
```ruby
gem 'http-cage'
```

## Usage.

```ruby
# Initialize the cage in your app initializer.
HTTPCage.timeout(connection: 3, request: 5)

# Increase global timeouts in a delayed job, for example.
HTTPCage.timeout(connection: 10, request: 30)
```

## Test.

```ruby
bundle exec rake test:all
```

## Demo

- Forking server, slow request: [example.rb](demo/example.rb)
- Without http-cage: [without_cage.rb](demo/without_cage.rb)
- With http-cage: [with_cage.rb](demo/with_cage.rb)

[![asciicast](https://asciinema.org/a/113238.png)](https://asciinema.org/a/113238)

## Contribute

- We use GitHub issues to discuss everything: features, bugs, docs.
- Before sending a pull request always open an issue.

## Maintainers

[badshark](https://github.com/badshark)

## License

[MIT License](https://opensource.org/licenses/MIT)
