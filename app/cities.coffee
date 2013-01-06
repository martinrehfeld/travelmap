@Cities =
  prepare: (toMapCoords) ->
    for own key, loc of @
      do (key, loc) ->
        if key != 'prepare'
          mapCoords = toMapCoords(loc.ll)
          for own k, v of mapCoords
            do (k, v) ->
              loc[k] = v
    @

  'THF':
    ll: '52 30 N 13 25 E'
    name: 'Berlin'
  'TXL':
    ll: '52 30 N 13 25 E'
    name: 'Berlin'
  'BER':
    ll: '52 30 N 13 25 E'
    name: 'Berlin'
  'FMO':
    ll: '52.1361° N, 7.6858° E'
    name: 'Münster-Osnabrück'


  # test data
  'Paris':
    ll: '48 48 N 2 20 E'
    name: 'Paris'
  'Rom':
    ll: '41 54 N 12 27 E'
    name: 'Rom'
  'New York':
    ll: '40 47 N 73 58 W'
    name: 'New York'
  'Rio de Janeiro':
    ll: '22 57 S 43 12 W'
    name: 'Rio de Janeiro'
  'Sydney':
    ll: '34 0 S 151 0 E'
    name: 'Sydney'
