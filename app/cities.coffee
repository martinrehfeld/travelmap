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

  # airports
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
  'CGN':
    ll: '50.8672° N, 7.1436° E'
    country: 'DE'
    name: 'Köln-Bonn'

  # referenced cities
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
  'Rio de Janeiro':
    ll: '22 57 S 43 12 W'
    country: 'BR'
    name: 'Rio de Janeiro'
  'Warschau':
    ll: '52.2300° N, 21.0108° E'
    country: 'PL'
    name: 'Warschau'
  'Krakau':
    ll: '50.0614° N, 19.9372° E'
    country: 'PL'
    name: 'Krakau'
  'Poznan':
    ll: '52.4000° N, 16.9167° E'
    country: 'PL'
    name: 'Poznan'
  'Szczecin':
    ll: '53.4333° N, 14.5333° E'
    country: 'PL'
    name: 'Szczecin'
  'Prag':
    ll: '50.0833° N, 14.4167° E'
    country: 'CZ'
    name: 'Prag'
  'Salzburg':
    ll: '47.8000° N, 13.0333° E'
    country: 'AT'
    name: 'Salzburg'
  'Zürich':
    ll: '47.3690° N, 8.5380° E'
    country: 'CH'
    name: 'Zürich'
  'Amsterdam':
    ll: '52.3700° N, 4.8900° E'
    country: 'NL'
    name: 'Amsterdam'
  'Antwerpen':
    ll: '51.2209° N, 4.4021° E'
    country: 'BE'
    name: 'Antwerpen'
  'Budapest':
    ll: '47.5000° N, 19.0500° E'
    country: 'HU'
    name: 'Budapest'
  'Tirgu Mures':
    ll: '46.5400° N, 24.5558° E'
    country: 'RO'
    name: 'Tirgu Mures'
  'Barcelona':
    ll: '41.3857° N, 2.1699° E'
    country: 'ES'
    name: 'Barcelona'
  'Hämmenlinna':
    ll: '60.9958° N, 24.4653° E'
    country: 'FI'
    name: 'Hämeenlinna'
  'Nijni Novgorod':
    ll: '56.3264° N, 44.0078° E'
    country: 'RU'
    name: 'Nizhny Novgorod'
  'Rouen':
    ll: '49.4433° N, 1.0958° E'
    country: 'FR'
    name: 'Rouen'
  'Wien':
    ll: '48.2088° N, 16.3726° E'
    country: 'AT'
    name: 'Wien'
  'Milton Keynes':
    ll: '52.0360° N, 0.7700° W'
    country: 'GB'
    name: 'Milton Keynes'
  'Sevilla':
    ll: '37.3833° N, 5.9833° W'
    country: 'ES'
    name: 'Sevilla'
  'San Francisco':
    ll: '37.7750° N, 122.4183° W'
    country: 'US'
    name: 'San Francisco'
  'Denver':
    ll: '39.7392° N, 104.9842° W'
    country: 'US'
    name: 'Denver'
  'Cleveland':
    ll: '41.4994° N, 81.6956° W'
    country: 'US'
    name: 'Cleveland'
  'Erfurt':
    ll: '50.9718° N, 11.0244° E'
    country: 'DE'
    name: 'Erfurt'
  'Wuppertal':
    ll: '51.2563° N, 7.1494° E'
    country: 'DE'
    name: 'Wuppertal'
  'Lugano':
    ll: '46.0046° N, 8.9535° E'
    country: 'CH'
    name: 'Lugano'
  'Mailand':
    ll: '45.4640° N, 9.1916° E'
    country: 'IT'
    name: 'Mailand'
  'Dortmund':
    ll: '51.5161° N, 7.4683° E'
    country: 'DE'
    name: 'Dortmund'
  'Frankfurt':
    ll: '50.1167° N, 8.6833° E'
    country: 'DE'
    name: 'Frankfurt'
  'Wermelskirchen':
    ll: '51.1399° N, 7.2149° E'
    country: 'DE'
    name: 'Wermelskirchen'
  'Müllheim (Baden)':
    ll: '47.8084° N, 7.6310° E'
    country: 'DE'
    name: 'Müllheim (Baden)'
  'Essen':
    ll: '51.4594° N, 7.0161° E'
    country: 'DE'
    name: 'Essen'
  'Kerpen':
    ll: '50.8667° N, 6.6667° E'
    country: 'DE'
    name: 'Kerpen'
  'Hamburg':
    ll: '53.5686° N, 10.0386° E'
    country: 'DE'
    name: 'Hamburg'
  'Bremen':
    ll: '53.0769° N, 8.8089° E'
    country: 'DE'
    name: 'Bremen'
  'Düsseldorf':
    ll: '51.2256° N, 6.7828° E'
    country: 'DE'
    name: 'Düsseldorf'
  'Karlsruhe':
    ll: '49.0135° N, 8.4044° E'
    country: 'DE'
    name: 'Karlsruhe'
  'München':
    ll: '48.1333° N, 11.5667° E'
    country: 'DE'
    name: 'München'
  'Walldorf':
    ll: '49.3034° N, 8.6430° E'
    country: 'DE'
    name: 'Walldorf'
  'Nassau bei Koblenz':
    ll: '50.3381° N, 7.7106° E' # this is Bad Ems
    country: 'DE'
    name: 'Nassau bei Koblenz'
  'Bad Neuenahr':
    ll: '50.5500° N, 7.1000° E'
    country: 'DE'
    name: 'Bad Neuenahr'
  'Brüssel':
    ll: '50.8411° N, 4.3564° E'
    country: 'BE'
    name: 'Brüssel'
  'Mannheim':
    ll: '49.4890° N, 8.4691° E'
    country: 'DE'
    name: 'Mannheim'
  'Böblingen':
    ll: '48.6857° N, 9.0155° E'
    country: 'DE'
    name: 'Böblingen'
  'Köln':
    ll: '50.9424° N, 7.0292° E'
    country: 'DE'
    name: 'Köln'
  'Wolletz bei Angermünde':
    ll: '53.0333° N, 14.0000° E' # this is Angermünde
    country: 'DE'
    name: 'Wolletz bei Angermünde'
  'Rotterdam':
    ll: '51.9217° N, 4.4811° E'
    country: 'NL'
    name: 'Rotterdam'
  'Aachen':
    ll: '50.7667° N, 6.1000° E'
    country: 'DE'
    name: 'Aachen'
  'Saarbrücken':
    ll: '49.2500° N, 6.9667° E'
    country: 'DE'
    name: 'Saarbrücken'
  'Regensburg':
    ll: '49.0000° N, 12.0000° E'
    country: 'DE'
    name: 'Regensburg'
  'Basel':
    ll: '47.5660° N, 7.6000° E'
    country: 'CH'
    name: 'Basel'
  'Worms':
    ll: '49.6319° N, 8.3653° E'
    country: 'DE'
    name: 'Worms'
  'Mainz':
    ll: '49.9945° N, 8.2672° E'
    country: 'DE'
    name: 'Mainz'
  'Aschaffenburg':
    ll: '49.9667° N, 9.1500° E'
    country: 'DE'
    name: 'Aschaffenburg'
  'Dresden':
    ll: '51.0500° N, 13.7333° E'
    country: 'DE'
    name: 'Dresden'
  'Mallorca':
    ll: '39.6167° N, 2.9833° E'
    country: 'ES'
    name: 'Mallorca'
  'Donaueschingen':
    ll: '47.9520° N, 8.5022° E'
    country: 'DE'
    name: 'Donaueschingen'
  'Trier':
    ll: '49.7538° N, 6.6464° E'
    country: 'DE'
    name: 'Trier'
  'Los Angeles':
    ll: '34.0522° N, 118.2428° W'
    country: 'US'
    name: 'Los Angeles'
  'Augsburg':
    ll: '48.3647° N, 10.8953° E'
    country: 'DE'
    name: 'Augsburg'
  'Würzburg':
    ll: '49.7941° N, 9.9272° E'
    country: 'DE'
    name: 'Würzburg'
  'Westbury':
    ll: '40.7556° N, 73.5881° W'
    country: 'US'
    name: 'Westbury'
  'Tokio':
    ll: '35.6833° N, 139.7667° E'
    country: 'JP'
    name: 'Tokio'
  'Pittsburgh':
    ll: '40.4406° N, 79.9961° W'
    country: 'US'
    name: 'Pittsburgh'
  'Singapur':
    ll: '1.3667° N, 103.7500° E'
    country: 'MY' # well, acutally... ;-)
    name: 'Singapur'
  'Bangkok':
    ll: '13.7500° N, 100.4833° E'
    country: 'TH'
    name: 'Bangkok'
  'Hongkong':
    ll: '22.3000° N, 114.1667° E'
    country: 'CN'
    name: 'Hongkong'
  'Shanghai':
    ll: '31.2000° N, 121.5000° E'
    country: 'CN'
    name: 'Shanghai'
  'Heidelberg':
    ll: '49.4034° N, 8.6792° E'
    country: 'DE'
    name: 'Heidelberg'
  'Sao Paolo':
    ll: '23.5000° S, 46.6167° W'
    country: 'BR'
    name: 'Sao Paolo'
  'Saigon':
    ll: '10.7500° N, 106.6667° E'
    country: 'VN'
    name: 'Saigon'
  'Mumbai':
    ll: '18.9647° N, 72.8258° E'
    country: 'IN'
    name: 'Mumbai'
  'Delhi':
    ll: '29.0167° N, 77.3833° E'
    country: 'IN'
    name: 'Delhi'
  'Seoul':
    ll: '37.5833° N, 127.0000° E'
    country: 'KR'
    name: 'Seoul'
  'Tegernsee':
    ll: '47.7167° N, 11.7667° E'
    country: 'DE'
    name: 'Tegernsee'
  'Toronto':
    ll: '43.6481° N, 79.4042° W'
    country: 'CA'
    name: 'Toronto'
  'Baveno Lago Maggiore':
    ll: '45.9500° N, 8.6333° E' # this is the Lago Maggiore
    country: 'IT'
    name: 'Baveno Lago Maggiore'
  'Freiburg':
    ll: '47.9973° N, 7.8525° E'
    country: 'DE'
    name: 'Freiburg'
  'Wiesbaden':
    ll: '50.0856° N, 8.2387° E'
    country: 'DE'
    name: 'Wiesbaden'
  'Santiago de Chile':
    ll: '33.4500° S, 70.6667° W'
    country: 'CL'
    name: 'Santiago de Chile'
  'Rottach-Egern (Tegernsee)':
    ll: '47.7000° N, 11.7667° E'
    country: 'DE'
    name: 'Rottach-Egern (Tegernsee)'
  'Pittsburg':
    ll: '40.4406° N, 79.9961° W'
    country: 'US'
    name: 'Pittsburgh'
  'New York (Morristown)':
    ll: '44.5864° N, 75.6486° W'
    country: 'US'
    name: 'New York (Morristown)'
  'Peking':
    ll: '39.9100° N, 116.4000° E'
    country: 'CN'
    name: 'Peking'
  'Kuala Lumpur':
    ll: '3.1597° N, 101.7000° E'
    country: 'MY'
    name: 'Kuala Lumpur'
  'Athen':
    ll: '37.9778° N, 23.7278° E'
    country: 'GR'
    name: 'Athen'
  'Weimar':
    ll: '50.9833° N, 11.3167° E'
    country: 'DE'
    name: 'Weimar'
  'Genk':
    ll: '50.9667° N, 5.5000° E'
    country: 'BE'
    name: 'Genk'
  'Osaka':
    ll: '34.6603° N, 135.5232° E'
    country: 'JP'
    name: 'Osaka'
  'Sao Paulo':
    ll: '23.5000° S, 46.6167° W'
    country: 'BR'
    name: 'Sao Paulo'
  'Tarrytown/NYC':
    ll: '41.0761° N, 73.8592° W'
    country: 'US'
    name: 'Tarrytown/NYC'
  'Sauerland (Fröndenberg)':
    ll: '51.4719° N, 7.7658° E'
    country: 'DE'
    name: 'Sauerland (Fröndenberg)'
  'Stockholm':
    ll: '59.3300° N, 18.0700° E'
    country: 'SE'
    name: 'Stockholm'
  'Thessaloniki':
    ll: '40.6333° N, 22.9500° E'
    country: 'GR'
    name: 'Thessaloniki'
  'Istanbul':
    ll: '41.0128° N, 28.9744° E'
    country: 'TR'
    name: 'Istanbul'
  'Valetta':
    ll: '35.8997° N, 14.5147° E'
    country: 'IT'
    name: 'Valetta'
  'Genf':
    ll: '46.2000° N, 6.1500° E'
    country: 'CH'
    name: 'Genf'
