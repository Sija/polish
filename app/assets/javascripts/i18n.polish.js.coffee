((factory) ->

  # Node/CommonJS
  if typeof module isnt 'undefined'
    module.exports = factory require('i18n')

  # AMD
  else if typeof define is 'function' and define.amd
    define ['i18n'], factory

  # Browser globals
  else
    factory this.I18n

) (I18n) ->

  #   one -> n is 1
  #   few -> n mod 10 in 2..4 and n mod 100 not in 12..14
  #   other -> everything else

  if I18n? and I18n.pluralization?
    I18n.pluralization['pl'] = (count) ->
      switch count
        when 0 then ['zero', 'other']
        when 1 then ['one']
        else
          if Math.abs(count) % 10 in [2..4] and Math.abs(count) % 100 not in [12..14] then ['few', 'other']
          else ['other']
