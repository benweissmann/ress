# Ress

A Ruby DSL for writing CSS, inspired by LESS.

## Installation

Add this line to your application's Gemfile:

    gem 'ress'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ress

## Usage

This is the eventual goal. `sample.ress` has a currently-valid RESS stylesheet;
look there if you want to see the project's status. `sample.css` contains the
compiled version of `sample.ress`.

    body do                                       // body {
      font_size 12.px                             //   font-size: 12px;
      background_color :green                     //   background-color: green;
      color rgba(255, 0, 0).lighten(10.percent)   //   color: rgb(255, 26, 26);
      border left: {width: 10, color: red}        //   border-left-width: 10px
                                                  //   border-left-clor: red;
                                                  // }
                                                  //
      s('.bar') do                                // body .foo {
        cool_mixin :red, 150.percent              //   background-color: red;
                                                  //   font-size: 150%;
      end                                         // }
                                                  //
      +s('.foo') do                               // body.foo {
        border_radius 1.em                        //   border-radius: 1em;
                                                  //   -moz-border-radius: 1em;
                                                  //   -webkit-border-radius: 1em;
      end                                         // }
                                                  //
      import "some_other_file.rass"               // imports some_other_file.rass,
                                                  // nesting its rules inside this
                                                  // selector block
    end                                           //

    def cool_mixin color, size
        background_color color
        font_size size
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
