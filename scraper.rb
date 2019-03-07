#!/bin/env ruby
# encoding: utf-8

require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Gibraltar").lower_house.popolo.persons.map(&:wikidata).compact

query = 'SELECT DISTINCT ?item { ?item p:P39/ps:P39 [wdt:P279* wd:Q4175034 ; wdt:P1001 wd:Q1410] }'
ids = EveryPolitician::Wikidata.sparql(query)

names = EveryPolitician::Wikidata.morph_wikinames(source: 'andylolz/gibraltar-wikipedia', column: 'wikipedia_name')
EveryPolitician::Wikidata.scrape_wikidata(ids: ids | existing, names: { en: names })
