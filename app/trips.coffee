@Trips =
  asSeries: (world) ->
    for action in @parseInput(world)
      do (action) ->
        [fn, args] = action

        # build this kind of function for use with async.series
        (cb) ->
          args.push(-> cb())    # provided callback becomes last arg
          fn.apply(world, args) # call fn in scope of world

  parseInput: (world) ->
    actions = []
    seenRoundtrips = {}
    worldZoom = false

    for l in @input
      do (l) =>
        [year, cw, _, rawCities, roundtrip] = l.split("\t")

        if year == '2004' && !worldZoom
          actions.push [world.focusWorld, []]
          worldZoom = true
        actions.push [world.updateTime, [year, cw]]

        airport = @airport(year)
        cities = rawCities.split(/,\s*/)
        if cities[0]
          actions.push [world.drawTrip, [airport, @city(cities[0]), false]]
        if cities.length > 1
          for city, i in cities
            do (city, i) =>
              if cities[i + 1]
                actions.push [world.drawTrip, [@city(cities[i]), @city(cities[i+1]), true]]
              else
                actions.push [world.drawTrip, [@city(cities[i]), airport, true]]

        ###
        if roundtrip && roundtrip != './.'
          if seenRoundtrips[roundtrip]
            actions.push [world.repeatRoundTrip, @roundtripToArgs(roundtrip)]
          else
            actions.push [world.drawRoundTrip, @roundtripToArgs(roundtrip)]
            seenRoundtrips[roundtrip] = true
        ###

    actions

  city: (name) ->
    obj = Cities[name]
    if obj? then obj else throw("Undefined city '#{name}'")

  airport: (year) ->
    year = parseInt(year, 10)
    if year < 2000
      @city('BER')
    else if year < 2004
      @city('FMO')
    else
      @city('CGN')

  roundtripToArgs: (roundtrip) ->
    [from, to, _] = roundtrip.split(/\s*-\s*/)
    [@city(from), @city(to)]

  input: [
    # pasted from Excel:
    # year cw country/countries city/cities roundtrip
    '1993	26			',
    '1993	27			',
    '1993	28			',
    '1993	29	Polen	Warschau, Krakau, Poznan	',
    '1993	30			',
    '1993	31			',
    '1993	32	Polen	Szczecin, Poznan	',
    '1993	33	Tschechien	Prag	',
    '1993	34	Österreich	Salzburg	',
    '1993	35	Polen	Poznan	',
    '1993	36	Schweiz	Zürich	',
    '1993	37			',
    '1993	38	Frankreich	Paris	',
    '1993	39	Polen	Poznan	',
    '1993	40	Benelux	Amsterdam, Antwerpen	',
    '1993	41	Ungarn	Budapest	',
    '1993	42			',
    '1993	43	Polen	Poznan	',
    '1993	44			',
    '1993	45			',
    '1993	46			',
    '1993	47	Polen	Poznan	',
    '1993	48	Benelux	Amsterdam, Antwerpen	',
    '1993	49			',
    '1993	50	Polen	Poznan	',
    '1993	51			',
    '1993	52			',
    '1994	1			',
    '1994	2			',
    '1994	3	Polen	Poznan	',
    '1994	4	Österreich	Salzburg	',
    '1994	5	Ungarn	Budapest	',
    '1994	6			',
    '1994	7	Polen	Poznan	',
    '1994	8	Benelux	Amsterdam, Antwerpen	',
    '1994	9	Polen	Poznan	',
    '1994	10			',
    '1994	11	Schweiz	Zürich	',
    '1994	12	Polen	Poznan	',
    '1994	13			',
    '1994	14			',
    '1994	15	Polen	Poznan	',
    '1994	16	Rumänien	Tirgu Mures, Budapest	',
    '1994	17			',
    '1994	18	Tschechien	Prag	',
    '1994	19	Polen	Warschau	',
    '1994	20			',
    '1994	21	Benelux	Amsterdam, Antwerpen	',
    '1994	22			',
    '1994	23	Polen	Poznan	',
    '1994	24			',
    '1994	25			',
    '1994	26			',
    '1994	27	Polen	Poznan	',
    '1994	28			',
    '1994	29			',
    '1994	30	Frankreich	Paris	',
    '1994	31	Polen	Poznan	',
    '1994	32			',
    '1994	33	Schweiz	Zürich	',
    '1994	34	Ungarn	Budapest	',
    '1994	35	Polen	Poznan	',
    '1994	36	Benelux	Amsterdam, Antwerpen	',
    '1994	37			',
    '1994	38			',
    '1994	39	Spanien	Barcelona	',
    '1994	40			',
    '1994	41	Polen	Poznan	',
    '1994	42			',
    '1994	43			',
    '1994	44	Österreich	Salzburg	',
    '1994	45	Polen	Poznan	',
    '1994	46			',
    '1994	47			',
    '1994	48			',
    '1994	49	Finland	Hämmenlinna	',
    '1994	50	Polen	Poznan	',
    '1994	51			',
    '1994	52			',
    '1995	1			',
    '1995	2	Benelux	Amsterdam, Antwerpen	',
    '1995	3	Rußland	Nijni Novgorod	',
    '1995	4	Finland	Hämmenlinna	',
    '1995	5			',
    '1995	6	Polen	Poznan	',
    '1995	7	Österreich	Salzburg	',
    '1995	8			',
    '1995	9	Ungarn	Budapest	',
    '1995	10	Finland	Hämmenlinna	',
    '1995	11	Schweiz	Zürich	',
    '1995	12			',
    '1995	13	Finland	Hämmenlinna	',
    '1995	14	Tschechien	Prag	',
    '1995	15			',
    '1995	16	Polen	Poznan	',
    '1995	17	Rumänien	Tirgu Mures, Budapest	',
    '1995	18	Finland	Hämmenlinna	',
    '1995	19			',
    '1995	20	Frankreich	Rouen	',
    '1995	21	Rußland	Moskau	',
    '1995	22	Spanien	Barcelona	',
    '1995	23			',
    '1995	24	Österreich	Wien	',
    '1995	25	Finland	Hämmenlinna	',
    '1995	26			',
    '1995	27	Frankreich	Rouen	',
    '1995	28	Ungarn	Budapest	',
    '1995	29	Polen	Poznan	',
    '1995	30			',
    '1995	31	Österreich	Wien	',
    '1995	32			',
    '1995	33	Finland	Hämmenlinna	',
    '1995	34			',
    '1995	35			',
    '1995	36			',
    '1995	37			',
    '1995	38			',
    '1995	39			',
    '1995	40	Polen	Poznan	',
    '1995	41			',
    '1995	42	Frankreich	Rouen	',
    '1995	43			',
    '1995	44	Benelux	Amsterdam, Antwerpen	',
    '1995	45	Tschechien	Prag	',
    '1995	46			',
    '1995	47	Schweiz	Zürich	',
    '1995	48	Polen	Poznan	',
    '1995	49			',
    '1995	50			',
    '1995	51			',
    '1995	52			',
    '1996	1			',
    '1996	2			',
    '1996	3			',
    '1996	4	Finland	Hämmenlinna	',
    '1996	5			',
    '1996	6	Frankreich	Rouen	',
    '1996	7	England	Milton Keynes	',
    '1996	8	Finland	Hämmenlinna	',
    '1996	9	Frankreich	Rouen	',
    '1996	10	Österreich	Salzburg	',
    '1996	11	Polen	Poznan	',
    '1996	12	Frankreich	Rouen	',
    '1996	13			',
    '1996	14	Frankreich	Rouen	',
    '1996	15			',
    '1996	16	Finland	Hämmenlinna	',
    '1996	17			',
    '1996	18			',
    '1996	19	Frankreich	Rouen	',
    '1996	20			',
    '1996	21			',
    '1996	22	Frankreich	Rouen	',
    '1996	23			',
    '1996	24	Frankreich	Rouen	',
    '1996	25			',
    '1996	26	Finland	Hämmenlinna	',
    '1996	27			',
    '1996	28	Frankreich	Rouen	',
    '1996	29	Ungarn	Budapest	',
    '1996	30			',
    '1996	31			',
    '1996	32			',
    '1996	33			',
    '1996	34	Benelux	Amsterdam, Antwerpen	',
    '1996	35			',
    '1996	36	Frankreich	Rouen	',
    '1996	37			',
    '1996	38			',
    '1996	39	Frankreich	Rouen	',
    '1996	40			',
    '1996	41			',
    '1996	42	Frankreich	Rouen	',
    '1996	43			',
    '1996	44			',
    '1996	45	Frankreich	Rouen	',
    '1996	46	Finland	Hämmenlinna	',
    '1996	47			',
    '1996	48			',
    '1996	49	Frankreich	Rouen	',
    '1996	50			',
    '1996	51			',
    '1996	52			',
    '1997	1			',
    '1997	2			',
    '1997	3			',
    '1997	4	Frankreich	Rouen	',
    '1997	5			',
    '1997	6			',
    '1997	7			',
    '1997	8			',
    '1997	9			',
    '1997	10			',
    '1997	11			',
    '1997	12			',
    '1997	13			',
    '1997	14			',
    '1997	15			',
    '1997	16			',
    '1997	17			',
    '1997	18			',
    '1997	19			',
    '1997	20			',
    '1997	21			',
    '1997	22			',
    '1997	23			',
    '1997	24			',
    '1997	25			',
    '1997	26			',
    '1997	27			',
    '1997	28			',
    '1997	29			',
    '1997	30			',
    '1997	31			',
    '1997	32			',
    '1997	33			',
    '1997	34			',
    '1997	35			',
    '1997	36			',
    '1997	37			',
    '1997	38			',
    '1997	39			',
    '1997	40			',
    '1997	41			',
    '1997	42			',
    '1997	43			',
    '1997	44			',
    '1997	45			',
    '1997	46			',
    '1997	47			',
    '1997	48			',
    '1997	49			',
    '1997	50			',
    '1997	51			',
    '1997	52			',
    '1998	1			',
    '1998	2			',
    '1998	3			',
    '1998	4			',
    '1998	5			',
    '1998	6			',
    '1998	7			',
    '1998	8			',
    '1998	9			',
    '1998	10			',
    '1998	11			',
    '1998	12			',
    '1998	13			',
    '1998	14			',
    '1998	15			',
    '1998	16			',
    '1998	17			',
    '1998	18			',
    '1998	19			',
    '1998	20			',
    '1998	21			',
    '1998	22			',
    '1998	23			',
    '1998	24			',
    '1998	25			',
    '1998	26			',
    '1998	27			',
    '1998	28			',
    '1998	29			',
    '1998	30			',
    '1998	31			',
    '1998	32			',
    '1998	33			',
    '1998	34			',
    '1998	35			',
    '1998	36			',
    '1998	37			',
    '1998	38			',
    '1998	39			',
    '1998	40			',
    '1998	41			',
    '1998	42			',
    '1998	43			',
    '1998	44			',
    '1998	45			',
    '1998	46			',
    '1998	47			',
    '1998	48			',
    '1998	49			',
    '1998	50			',
    '1998	51			',
    '1998	52			',
    '1999	1			',
    '1999	2			',
    '1999	3			',
    '1999	4			',
    '1999	5			',
    '1999	6			',
    '1999	7			',
    '1999	8			',
    '1999	9			',
    '1999	10			',
    '1999	11			',
    '1999	12			',
    '1999	13			',
    '1999	14			',
    '1999	15			',
    '1999	16			',
    '1999	17	Spanien	Sevilla	',
    '1999	18			',
    '1999	19			',
    '1999	20			',
    '1999	21			',
    '1999	22			',
    '1999	23			',
    '1999	24			',
    '1999	25			',
    '1999	26			',
    '1999	27			',
    '1999	28			',
    '1999	29			',
    '1999	30			',
    '1999	31			',
    '1999	32			',
    '1999	33			',
    '1999	34			',
    '1999	35			',
    '1999	36	USA	San Francisco, Denver, Cleveland	',
    '1999	37			',
    '1999	38			',
    '1999	39			',
    '1999	40			',
    '1999	41			',
    '1999	42			',
    '1999	43			',
    '1999	44			',
    '1999	45			',
    '1999	46			',
    '1999	47			',
    '1999	48			',
    '1999	49			',
    '1999	50			',
    '1999	51			',
    '1999	52			',
    '2000	1			',
    '2000	2			',
    '2000	3			',
    '2000	4			',
    '2000	5			',
    '2000	6			',
    '2000	7			',
    '2000	8			',
    '2000	9			',
    '2000	10			',
    '2000	11			',
    '2000	12			',
    '2000	13			',
    '2000	14			',
    '2000	15			',
    '2000	16			',
    '2000	17			',
    '2000	18			',
    '2000	19			',
    '2000	20			',
    '2000	21			',
    '2000	22			',
    '2000	23			',
    '2000	24			',
    '2000	25			',
    '2000	26			',
    '2000	27		Erfurt	THF - FMO - THF',
    '2000	28	Italien	Wuppertal, Lugano, Mailand	THF - FMO - THF',
    '2000	29		Dortmund, Frankfurt	THF - FMO - THF',
    '2000	30		Wermelskirchen, Müllheim (Baden), Frankfurt	THF - FMO - THF',
    '2000	31		Essen	THF - FMO - THF',
    '2000	32			THF - FMO - THF',
    '2000	33		Kerpen	THF - FMO - THF',
    '2000	34		Hamburg, Kerpen, Bremen	THF - FMO - THF',
    '2000	35	Holland	Amsterdam, Düsseldorf, Frankfurt	THF - FMO - THF',
    '2000	36			THF - FMO - THF',
    '2000	37		Karlsruhe	THF - FMO - THF',
    '2000	38		München, Walldorf	THF - FMO - THF',
    '2000	39			./.',
    '2000	40			./.',
    '2000	41			THF - FMO - THF',
    '2000	42		Nassau bei Koblenz	THF - FMO - THF',
    '2000	43			THF - FMO - THF',
    '2000	44		Frankfurt	THF - FMO - THF',
    '2000	45		Bad Neuenahr, Wermelskirchen	THF - FMO - THF',
    '2000	46		Hamburg	THF - FMO - THF',
    '2000	47	Belgien	Brüssel, Mannheim, Böblingen	THF - FMO - THF',
    '2000	48		Frankfurt	THF - FMO - THF',
    '2000	49			THF - FMO - THF',
    '2000	50	Holland	Amsterdam	THF - FMO - THF',
    '2000	51			./.',
    '2000	52			./.',
    '2001	1			./.',
    '2001	2		Dortmund	THF - FMO - THF',
    '2001	3			THF - FMO - THF',
    '2001	4		Frankfurt	THF - FMO - THF',
    '2001	5		Köln	THF - FMO - THF',
    '2001	6			THF - FMO - THF',
    '2001	7			THF - FMO - THF',
    '2001	8	Belgien	Antwerpen	THF - FMO - THF',
    '2001	9		Wolletz bei Angermünde, Köln	THF - FMO - THF',
    '2001	10	Belgien	Hamburg, Antwerpen	THF - FMO - THF',
    '2001	11	Holland	Rotterdam	THF - FMO - THF',
    '2001	12	Holland	Amsterdam	THF - FMO - THF',
    '2001	13		Frankfurt	THF - FMO - THF',
    '2001	14		Düsseldorf	THF - FMO - THF',
    '2001	15			THF - FMO - THF',
    '2001	16			./.',
    '2001	17			./.',
    '2001	18			./.',
    '2001	19	Frankreich	Paris	THF - FMO - THF',
    '2001	20			THF - FMO - THF',
    '2001	21	Holland	Amsterdam	THF - FMO - THF',
    '2001	22	Holland	Hamburg, Amsterdam	THF - FMO - THF',
    '2001	23	Belgien	Antwerpen	THF - FMO - THF',
    '2001	24	Holland	Amsterdam	THF - FMO - THF',
    '2001	25			THF - FMO - THF',
    '2001	26	Belgien	Antwerpen	THF - FMO - THF',
    '2001	27	Belgien	Antwerpen	THF - FMO - THF',
    '2001	28		Wermelskirchen	THF - FMO - THF',
    '2001	29	Belgien	Antwerpen, Hamburg	THF - FMO - THF',
    '2001	30	Belgien	Antwerpen	THF - FMO - THF',
    '2001	31	Belgien	Antwerpen	THF - FMO - THF',
    '2001	32	Frankreich	Paris	THF - FMO - THF',
    '2001	33	Belgien	Antwerpen, Amsterdam, Frankfurt	THF - FMO - THF',
    '2001	34	Belgien	Antwerpen	THF - FMO - THF',
    '2001	35	Belgien	Antwerpen	THF - FMO - THF',
    '2001	36			THF - FMO - THF',
    '2001	37	Belgien	Antwerpen	THF - FMO - THF',
    '2001	38	Belgien	Antwerpen	THF - FMO - THF',
    '2001	39	Belgien	Antwerpen	THF - FMO - THF',
    '2001	40		München	THF - FMO - THF',
    '2001	41	Belgien	Antwerpen	THF - FMO - THF',
    '2001	42			THF - FMO - THF',
    '2001	43	Belgien	Antwerpen	THF - FMO - THF',
    '2001	44			./.',
    '2001	45			./.',
    '2001	46	Belgien	Antwerpen	THF - FMO - THF',
    '2001	47	Belgien	Antwerpen	THF - FMO - THF',
    '2001	48		Frankfurt	THF - FMO - THF',
    '2001	49			THF - FMO - THF',
    '2001	50		Aachen	THF - FMO - THF',
    '2001	51		Frankfurt	THF - FMO - THF',
    '2001	52			./.',
    '2002	1			./.',
    '2002	2			THF - FMO - THF',
    '2002	3			THF - FMO - THF',
    '2002	4			THF - FMO - THF',
    '2002	5			THF - FMO - THF',
    '2002	6	Polen	Warschau	THF - FMO - THF',
    '2002	7			THF - FMO - THF',
    '2002	8		Saarbrücken	THF - FMO - THF',
    '2002	9		Regensburg	THF - FMO - THF',
    '2002	10		Basel	THF - FMO - THF',
    '2002	11			THF - FMO - THF',
    '2002	12		Worms, Mainz	THF - FMO - THF',
    '2002	13			./.',
    '2002	14			./.',
    '2002	15		Aschaffenburg	THF - FMO - THF',
    '2002	16		Düsseldorf, Frankfurt	THF - FMO - THF',
    '2002	17		Hamburg	THF - FMO - THF',
    '2002	18			THF - FMO - THF',
    '2002	19			THF - FMO - THF',
    '2002	20		Worms	THF - FMO - THF',
    '2002	21	Spanien	Dresden, Mallorca	THF - FMO - THF',
    '2002	22	Italien	Mailand	THF - FMO - THF',
    '2002	23		Walldorf, Donaueschingen	THF - FMO - THF',
    '2002	24		Dortmund	THF - FMO - THF',
    '2002	25	Italien	Mailand	THF - FMO - THF',
    '2002	26		Köln	THF - FMO - THF',
    '2002	27	Belgien	Antwerpen	THF - FMO - THF',
    '2002	28			THF - FMO - THF',
    '2002	29		Aschaffenburg	THF - FMO - THF',
    '2002	30	Italien	Mailand	THF - FMO - THF',
    '2002	31			THF - FMO - THF',
    '2002	32			THF - FMO - THF',
    '2002	33			./.',
    '2002	34			./.',
    '2002	35			./.',
    '2002	36	Italien	Rom	THF - FMO - THF',
    '2002	37	Italien	Rom	THF - FMO - THF',
    '2002	38			THF - FMO - THF',
    '2002	39			THF - FMO - THF',
    '2002	40			THF - FMO - THF',
    '2002	41	Polen	Warschau	THF - FMO - THF',
    '2002	42			THF - FMO - THF',
    '2002	43	Schweiz	Zürich	THF - FMO - THF',
    '2002	44			THF - FMO - THF',
    '2002	45		Düsseldorf, Trier	THF - FMO - THF',
    '2002	46			THF - FMO - THF',
    '2002	47		Worms	THF - FMO - THF',
    '2002	48			THF - FMO - THF',
    '2002	49	Italien	Rom	THF - FMO - THF',
    '2002	50	USA	Los Angeles	THF - FMO - THF',
    '2002	51		Augsburg	THF - FMO - THF',
    '2002	52			./.',
    '2003	1			./.',
    '2003	2			THF - FMO - THF',
    '2003	3		Paris, Amsterdam	THF - FMO - THF',
    '2003	4		Dortmund	THF - FMO - THF',
    '2003	5		Düsseldorf	THF - FMO - THF',
    '2003	6	Italien	Rom	THF - FMO - THF',
    '2003	7	Italien	Rom	THF - FMO - THF',
    '2003	8			THF - FMO - THF',
    '2003	9			THF - FMO - THF',
    '2003	10		Basel, Erfurt	THF - FMO - THF',
    '2003	11		Erfurt	THF - FMO - THF',
    '2003	12		Erfurt, Erfurt, Erfurt	THF - FMO - THF',
    '2003	13		Erfurt, Erfurt, Erfurt	THF - FMO - THF',
    '2003	14			THF - FMO - THF',
    '2003	15		Basel, Düsseldorf	THF - FMO - THF',
    '2003	16			THF - FMO - THF',
    '2003	17			./.',
    '2003	18			./.',
    '2003	19			THF - FMO - THF',
    '2003	20			THF - FMO - THF',
    '2003	21			THF - FMO - THF',
    '2003	22		München	THF - FMO - THF',
    '2003	23			THF - FMO - THF',
    '2003	24			THF - FMO - THF',
    '2003	25		Frankfurt	THF - FMO - THF',
    '2003	26			THF - FMO - THF',
    '2003	27		Dortmund, Würzburg	THF - FMO - THF',
    '2003	28		Walldorf	THF - FMO - THF',
    '2003	29	England	Westbury	THF - FMO - THF',
    '2003	30			THF - FMO - THF',
    '2003	31			./.',
    '2003	32			./.',
    '2003	33			THF - FMO - THF',
    '2003	34			THF - FMO - THF',
    '2003	35	Schweiz	Lugano	THF - FMO - THF',
    '2003	36			THF - FMO - THF',
    '2003	37			THF - FMO - THF',
    '2003	38	Belgien	Antwerpen	THF - FMO - THF',
    '2003	39			THF - FMO - THF',
    '2003	40		Düsseldorf	THF - FMO - THF',
    '2003	41			THF - FMO - THF',
    '2003	42			THF - FMO - THF',
    '2003	43			THF - FMO - THF',
    '2003	44		München	THF - FMO - THF',
    '2003	45			THF - FMO - THF',
    '2003	46			./.',
    '2003	47			./.',
    '2003	48			./.',
    '2003	49			./.',
    '2003	50			./.',
    '2003	51			./.',
    '2003	52			./.',
    '2004	1			TXL - CGN - TXL',
    '2004	2			TXL - CGN - TXL',
    '2004	3			TXL - CGN - TXL',
    '2004	4			TXL - CGN - TXL',
    '2004	5			TXL - CGN - TXL',
    '2004	6			TXL - CGN - TXL',
    '2004	7			TXL - CGN - TXL',
    '2004	8	UK	Westbury	TXL - CGN - TXL',
    '2004	9			TXL - CGN - TXL',
    '2004	10			TXL - CGN - TXL',
    '2004	11	Italien	Mailand	TXL - CGN - TXL',
    '2004	12	Japan	Tokio	TXL - CGN - TXL',
    '2004	13			TXL - CGN - TXL',
    '2004	14			TXL - CGN - TXL',
    '2004	15			TXL - CGN - TXL',
    '2004	16			TXL - CGN - TXL',
    '2004	17			TXL - CGN - TXL',
    '2004	18		Frankfurt	TXL - CGN - TXL',
    '2004	19	Frankreich	Paris, Brüssel	TXL - CGN - TXL',
    '2004	20	USA	Pittsburgh	TXL - CGN - TXL',
    '2004	21			TXL - CGN - TXL',
    '2004	22			TXL - CGN - TXL',
    '2004	23			TXL - CGN - TXL',
    '2004	24	Asien	Singapur	TXL - CGN - TXL',
    '2004	25	Asien	Bangkok, Hongkong, Shanghai	./.',
    '2004	26			TXL - CGN - TXL',
    '2004	27	Spanien	Barcelona	TXL - CGN - TXL',
    '2004	28	Polen	Warschau	TXL - CGN - TXL',
    '2004	29			./.',
    '2004	30			./.',
    '2004	31			TXL - CGN - TXL',
    '2004	32			TXL - CGN - TXL',
    '2004	33			TXL - CGN - TXL',
    '2004	34			TXL - CGN - TXL',
    '2004	35			TXL - CGN - TXL',
    '2004	36		Heidelberg	TXL - CGN - TXL',
    '2004	37			TXL - CGN - TXL',
    '2004	38	Amerika	Sao Paolo, Pittsburgh	TXL - CGN - TXL',
    '2004	39	Vietnam	Saigon	TXL - CGN - TXL',
    '2004	40			TXL - CGN - TXL',
    '2004	41			./.',
    '2004	42			./.',
    '2004	43			TXL - CGN - TXL',
    '2004	44			TXL - CGN - TXL',
    '2004	45	Indien	Mumbai, Delhi	TXL - CGN - TXL',
    '2004	46			TXL - CGN - TXL',
    '2004	47			TXL - CGN - TXL',
    '2004	48			TXL - CGN - TXL',
    '2004	49			TXL - CGN - TXL',
    '2004	50		Frankfurt, München	TXL - CGN - TXL',
    '2004	51			TXL - CGN - TXL',
    '2004	52			TXL - CGN - TXL',
    '2005	1			TXL - CGN - TXL',
    '2005	2			TXL - CGN - TXL',
    '2005	3			TXL - CGN - TXL',
    '2005	4			./.',
    '2005	5			TXL - CGN - TXL',
    '2005	6			TXL - CGN - TXL',
    '2005	7		Hamburg	TXL - CGN - TXL',
    '2005	8			TXL - CGN - TXL',
    '2005	9			TXL - CGN - TXL',
    '2005	10			TXL - CGN - TXL',
    '2005	11			TXL - CGN - TXL',
    '2005	12			./.',
    '2005	13			TXL - CGN - TXL',
    '2005	14		Singapur	TXL - CGN - TXL',
    '2005	15	Korea	Seoul	TXL - CGN - TXL',
    '2005	16			TXL - CGN - TXL',
    '2005	17		Frankfurt	TXL - CGN - TXL',
    '2005	18			TXL - CGN - TXL',
    '2005	19	Schweiz	Zürich	TXL - CGN - TXL',
    '2005	20			TXL - CGN - TXL',
    '2005	21			TXL - CGN - TXL',
    '2005	22		Tegernsee	TXL - CGN - TXL',
    '2005	23		Frankfurt	TXL - CGN - TXL',
    '2005	24			TXL - CGN - TXL',
    '2005	25			TXL - CGN - TXL',
    '2005	26	Polen	Warschau	TXL - CGN - TXL',
    '2005	27			./.',
    '2005	28			./.',
    '2005	29	Spanien	Barcelona	./.',
    '2005	30	Canada	Toronto	TXL - CGN - TXL',
    '2005	31			TXL - CGN - TXL',
    '2005	32			TXL - CGN - TXL',
    '2005	33			TXL - CGN - TXL',
    '2005	34			TXL - CGN - TXL',
    '2005	35			TXL - CGN - TXL',
    '2005	36			TXL - CGN - TXL',
    '2005	37			TXL - CGN - TXL',
    '2005	38			TXL - CGN - TXL',
    '2005	39	Italy	Baveno Lago Maggiore	./.',
    '2005	40			./.',
    '2005	41			./.',
    '2005	42			TXL - CGN - TXL',
    '2005	43			TXL - CGN - TXL',
    '2005	44		München	TXL - CGN - TXL',
    '2005	45			TXL - CGN - TXL',
    '2005	46		München	TXL - CGN - TXL',
    '2005	47	China	Hongkong	TXL - CGN - TXL',
    '2005	48	Belgien	Brüssel	TXL - CGN - TXL',
    '2005	49			TXL - CGN - TXL',
    '2005	50			TXL - CGN - TXL',
    '2005	51			TXL - CGN - TXL',
    '2005	52			./.',
    '2006	1		Frankfurt, Hamburg	TXL - CGN - TXL',
    '2006	2		Freiburg, Frankfurt	TXL - CGN - TXL',
    '2006	3		Frankfurt	TXL - CGN - TXL',
    '2006	4			TXL - CGN - TXL',
    '2006	5			TXL - CGN - TXL',
    '2006	6			TXL - CGN - TXL',
    '2006	7			TXL - CGN - TXL',
    '2006	8			TXL - CGN - TXL',
    '2006	9		Wiesbaden	TXL - CGN - TXL',
    '2006	10	Chile	Santiago de Chile	TXL - CGN - TXL',
    '2006	11			TXL - CGN - TXL',
    '2006	12			TXL - CGN - TXL',
    '2006	13			TXL - CGN - TXL',
    '2006	14	Thailand	Bangkok	TXL - CGN - TXL',
    '2006	15			./.',
    '2006	16			./.',
    '2006	17		Heidelberg	TXL - CGN - TXL',
    '2006	18			TXL - CGN - TXL',
    '2006	19			TXL - CGN - TXL',
    '2006	20		Rottach-Egern (Tegernsee)	TXL - CGN - TXL',
    '2006	21			TXL - CGN - TXL',
    '2006	22			TXL - CGN - TXL',
    '2006	23			TXL - CGN - TXL',
    '2006	24			TXL - CGN - TXL',
    '2006	25			TXL - CGN - TXL',
    '2006	26			TXL - CGN - TXL',
    '2006	27	Spanien	Barcelona	TXL - CGN - TXL',
    '2006	28	USA, Kanada	Pittsburg, Toronto, New York (Morristown)	',
    '2006	29			TXL - CGN - TXL',
    '2006	30			./.',
    '2006	31			./.',
    '2006	32			TXL - CGN - TXL',
    '2006	33			TXL - CGN - TXL',
    '2006	34			TXL - CGN - TXL',
    '2006	35			TXL - CGN - TXL',
    '2006	36		Mainz	TXL - CGN - TXL',
    '2006	37		Zürich	TXL - CGN - TXL',
    '2006	38	Spanien	Barcelona	TXL - CGN - TXL',
    '2006	39	Holland	Amsterdam	TXL - CGN - TXL',
    '2006	40	Italien	Rom, München	TXL - CGN - TXL',
    '2006	41		Frankfurt	TXL - CGN - TXL',
    '2006	42	Brasilien	Rio de Janeiro	./.',
    '2006	43			TXL - CGN - TXL',
    '2006	44			TXL - CGN - TXL',
    '2006	45			TXL - CGN - TXL',
    '2006	46	China	Peking	./.',
    '2006	47		München	TXL - CGN - TXL',
    '2006	48	Belgien	Brüssel, München	TXL - CGN - TXL',
    '2006	49			TXL - CGN - TXL',
    '2006	50			./.',
    '2006	51		Hamburg	TXL - CGN - TXL',
    '2006	52			./.',
    '2007	1			TXL - CGN - TXL',
    '2007	2		München	TXL - CGN - TXL',
    '2007	3		München, Frankfurt	TXL - CGN - TXL',
    '2007	4			TXL - CGN - TXL',
    '2007	5			TXL - CGN - TXL',
    '2007	6			TXL - CGN - TXL',
    '2007	7		Mainz, Hamburg	./.',
    '2007	8		Brüssel	./.',
    '2007	9			TXL - CGN - TXL',
    '2007	10		München	TXL - CGN - TXL',
    '2007	11	USA	Pittsburgh	TXL - CGN - TXL',
    '2007	12	Belgien	Brüssel	TXL - CGN - TXL',
    '2007	13			TXL - CGN - TXL',
    '2007	14			./.',
    '2007	15			./.',
    '2007	16	Malaysia	Kuala Lumpur	TXL - CGN - TXL',
    '2007	17		Hamburg, Heidelberg	TXL - CGN - TXL',
    '2007	18			TXL - CGN - TXL',
    '2007	19			TXL - CGN - TXL',
    '2007	20			TXL - CGN - TXL',
    '2007	21			TXL - CGN - TXL',
    '2007	22			TXL - CGN - TXL',
    '2007	23			TXL - CGN - TXL',
    '2007	24	Griechenland	Athen	TXL - CGN - TXL',
    '2007	25		Weimar	TXL - CGN - TXL',
    '2007	26	Belgien	Genk	TXL - CGN - TXL',
    '2007	27			TXL - CGN - TXL',
    '2007	28		Frankfurt	TXL - CGN - TXL',
    '2007	29			TXL - CGN - TXL',
    '2007	30			TXL - CGN - TXL',
    '2007	31			./.',
    '2007	32			./.',
    '2007	33			TXL - CGN - TXL',
    '2007	34			TXL - CGN - TXL',
    '2007	35			TXL - CGN - TXL',
    '2007	36		Frankfurt	TXL - CGN - TXL',
    '2007	37	USA	Denver	TXL - CGN - TXL',
    '2007	38	Schweiz	Zürich	TXL - CGN - TXL',
    '2007	39		München	TXL - CGN - TXL',
    '2007	40	Spanien	Sevilla	TXL - CGN - TXL',
    '2007	41			TXL - CGN - TXL',
    '2007	42			./.',
    '2007	43			./.',
    '2007	44			TXL - CGN - TXL',
    '2007	45	Japan, thailand	Osaka, Bangkok	./.',
    '2007	46			TXL - CGN - TXL',
    '2007	47		Dresden	TXL - CGN - TXL',
    '2007	48		Frankfurt, München	TXL - CGN - TXL',
    '2007	49		Frankfurt	TXL - CGN - TXL',
    '2007	50			TXL - CGN - TXL',
    '2007	51			TXL - CGN - TXL',
    '2007	52			./.',
    '2008	1		München	./.',
    '2008	2		Hamburg	TXL - CGN - TXL',
    '2008	3		Frankfurt	TXL - CGN - TXL',
    '2008	4		Hamburg	TXL - CGN - TXL',
    '2008	5			TXL - CGN - TXL',
    '2008	6	Spanien	Barcelona	TXL - CGN - TXL',
    '2008	7			TXL - CGN - TXL',
    '2008	8			TXL - CGN - TXL',
    '2008	9		München	TXL - CGN - TXL',
    '2008	10			TXL - CGN - TXL',
    '2008	11	Frankreich	Paris	TXL - CGN - TXL',
    '2008	12			./.',
    '2008	13			./.',
    '2008	14	Brasilien, USA	Sao Paulo, Tarrytown/NYC	./.',
    '2008	15			TXL - CGN - TXL',
    '2008	16	Singapur	Singapur	TXL - CGN - TXL',
    '2008	17		Hamburg	TXL - CGN - TXL',
    '2008	18			TXL - CGN - TXL',
    '2008	19			TXL - CGN - TXL',
    '2008	20		Sauerland (Fröndenberg)	TXL - CGN - TXL',
    '2008	21			TXL - CGN - TXL',
    '2008	22			./.',
    '2008	23		München	TXL - CGN - TXL',
    '2008	24		Aachen	TXL - CGN - TXL',
    '2008	25		Hamburg	./.',
    '2008	26	Schweden	Stockholm	TXL - CGN - TXL',
    '2008	27			TXL - CGN - TXL',
    '2008	28			./.',
    '2008	29			./.',
    '2008	30			./.',
    '2008	31			./.',
    '2008	32		Frankfurt	TXL - CGN - TXL',
    '2008	33			TXL - CGN - TXL',
    '2008	34			TXL - CGN - TXL',
    '2008	35			TXL - CGN - TXL',
    '2008	36	Österreich	Salzburg	./.',
    '2008	37	Österreich	Wien, Frankfurt	TXL - CGN - TXL',
    '2008	38			TXL - CGN - TXL',
    '2008	39	Schweiz	Zürich	./.',
    '2008	40			./.',
    '2008	41	Griechenland	Thessaloniki	TXL - CGN - TXL',
    '2008	42			./.',
    '2008	43			./.',
    '2008	44			TXL - CGN - TXL',
    '2008	45	Indien	Mumbai	./.',
    '2008	46	USA, Türkei	Los Angeles, Istanbul	TXL - CGN - TXL',
    '2008	47	Belgien, Malta	Brüssel, Valetta	./.',
    '2008	48	Schweiz	Genf	TXL - CGN - TXL',
    '2008	49			TXL - CGN - TXL',
    '2008	50			TXL - CGN - TXL',
    '2008	51	Spanien	Barcelona	TXL - CGN - TXL',
    '2008	52			'
  ]
