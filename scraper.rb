#!/bin/env ruby
# encoding: utf-8

require 'json'
require 'pry'
require 'rest-client'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'mediawiki_api'

def members
  morph_api_url = 'https://api.morph.io/andylolz/gibraltar-wikipedia/data.json'
  morph_api_key = ENV["MORPH_API_KEY"]
  result = RestClient.get morph_api_url, params: {
    key: morph_api_key,
    query: "select DISTINCT(wikipedia_name) from data"
  }
  JSON.parse(result, symbolize_names: true)
end

WikiData.ids_from_pages('en', members.map { |c| c[:wikipedia_name] }).each_with_index do |p, i|
  data = WikiData::Fetcher.new(id: p.last).data rescue nil
  unless data
    warn "No data for #{p}"
    next
  end
  ScraperWiki.save_sqlite([:id], data)
end

