@Cities =
  prepare: (toMapCoords) ->
    for own key, loc of @
      do (key, loc) ->
        if key != 'prepare'
          loc[key] = key
          mapCoords = toMapCoords(loc.ll)
          for own k, v of mapCoords
            do (k, v) ->
              loc[k] = v
    @

  'THF':
    ll: '52 30 N 13 25 E'
    country: 'DE'
    name: 'Berlin'
  'TXL':
    ll: '52 30 N 13 25 E'
    country: 'DE'
    name: 'Berlin'
  'BER':
    ll: '52 30 N 13 25 E'
    country: 'DE'
    name: 'Berlin'
  'FMO':
    ll: '52.1361° N, 7.6858° E'
    country: 'DE'
    name: 'Münster-Osnabrück'


  # test data
  'Paris':
    ll: '48 48 N 2 20 E'
    country: 'FR'
    name: 'Paris'
  'Rom':
    ll: '41 54 N 12 27 E'
    country: 'IT'
    name: 'Rom'
  'Moskau':
    ll: '55 45 N 37 36 E'
    country: 'RU'
    name: 'Moskau'
  'New York':
    ll: '40 47 N 73 58 W'
    country: 'US'
    name: 'New York'
  'Rio de Janeiro':
    ll: '22 57 S 43 12 W'
    country: 'BR'
    name: 'Rio de Janeiro'
  'Sydney':
    ll: '34 0 S 151 0 E'
    country: 'AU'
    name: 'Sydney'
