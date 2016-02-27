#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'andylolz/gibraltar-wikipedia', column: 'wikipedia_name')
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names }, output: false)
