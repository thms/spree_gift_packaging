# Spree Gift Packaging extension

The Spree Gift Packaging extension enables gift packaging for line items. It uses the PerItem calculator to set pricing for different types of packages and calculates per line item.

## Installation

1. Add the following to your Gemfile

<pre>
    gem 'spree_gift_packaging'
</pre>

2. Run `bundle install`

3. To setup the asset pipeline includes and copy migrations run: `rails g spree_gift_packaging:install`
