#!/bin/env ruby
# encoding: utf-8

require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Gibraltar").lower_house.popolo.persons.map(&:wikidata).compact

names = EveryPolitician::Wikidata.morph_wikinames(source: 'andylolz/gibraltar-wikipedia', column: 'wikipedia_name')
EveryPolitician::Wikidata.scrape_wikidata(ids: existing, names: { en: names }, output: false)
