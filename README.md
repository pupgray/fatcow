# Fatcow

This adds some basic helpers to rails that let you use
the [Fatcow icon set](https://web.archive.org/web/20160323032439/http://www.fatcow.com/free-icons) in all of it's
early-2010s glory.

[You can browse the icons via wikimedia.](https://commons.wikimedia.org/wiki/Farm-Fresh_web_icons)

## Installation

To install, simply add it to your gemfile,

```ruby
gem 'fatcow'
```

then add the `fatcow_style_tag` helper to your `<head>` to include the basic stylesheet.

```erbruby
<%= fatcow_style_tag %>
```

and you're good to go!

## How to use

In any view, just use the `fci` helper to place an arbitrary icon.

```erbruby
<%= fci :note %>
```

You can also include a status, which is a small icon placed in the bottom left hand corner of the icon.

```erbruby
<%= fci :note, :add %>
```

### Use with models

You can also assign an icon to a model,
which will then be displayable with a status reflecting the current state of the record.
Add the `has_icon` macro into your model definition, and you're good to go.

```ruby

class Alert < ActiveRecord
  has_icon :bell
end
```

There are some default statuses (`:add` for new records, `:edit` for persisted records in a form, etc.)
but you can include + overwrite statues using the same macro.
Provide `show` statuses to be used with `record.show_icon` and `form` statuses to be used with `record.form_icon`.
Include the name of the status as the key, and the value should be a `Proc` that returns true/false,
and is executed in the context of the record instance.

```ruby

class Alert < ActiveRecord
  has_icon :bell, show: { attach: -> { has_attachment? } }, form: { warning: -> { invalid? } }
end
```

Then, to show your icon in a view, just called either `#show_icon` (when showing the resource) or `#form_icon` (when
displaying a form) on a record instance.
You cannot do this on collections, though that may be coming later.

```erbruby
<%= @alert.show_icon %>
```

## All Icons
![a big list of icons](https://web.archive.org/web/20160324052646if_/http://www.fatcow.com/images/fatcow-icons/fatcow-3926.png)

## Licensing

FatCow web icons are licensed under
a [Creative Commons Attribution 3.0 License.](https://creativecommons.org/licenses/by/3.0/deed.en) This library has
opted to do the same because I'm not a lawyer and I have no idea what I'm doing.

All icons are attributed to FatCow, who formerly hosted the icons at http://www.fatcow.com/free-icons. ([Archive](https://web.archive.org/web/20160323032439/http://www.fatcow.com/free-icons))