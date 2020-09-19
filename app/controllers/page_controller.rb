require 'open-uri'
require 'nokogiri'

class PageController < ApplicationController
  def intext
  end

  def analysis
    @input = params[:txt]
    @paragraph = @input.split("\n").reject { |x| x.blank?}
    @charcount = @paragraph.join('').length
    @words = []
    @paragraph.each { |x| @words << x.split(' ') }
    @words = @words.flatten.map { |x| x.gsub(':', '').gsub('.','').tr('0-9', '').gsub('[', '').gsub(']', '').gsub('/','').gsub("\"","").gsub('(', '').gsub(')', '').gsub("!","").gsub("?","").gsub(";", "").gsub("“", "").gsub("”", "").gsub('…','') }
    @words = @words.map { |x| x.chars.reject { |char| [' ', ',', '.'].include? char }.join('') }
    @words = @words.reject { |x| x.empty? }
    @big_words = @words.select { |x| x.size > 7 }
    @big_words = @big_words.map { |x| x.downcase }
    @big_words = @big_words.uniq.sort_by { |x| x }
    @wcnt = {}
    trmwords = []
    trmwords = @words.map { |x| x }
    trmwords.each { |x| @wcnt[x] = x }
    @wcnt = @wcnt.each_pair { |k, v| @wcnt[k] = trmwords.count(v).to_i }
    @wcnt = @wcnt.sort_by { |k, v| -v }
    @fourup = @wcnt.select { |k, v| k.length > 3 }
    @oncemore = @fourup.select { |k, v| v > 1 }
    @last = @big_words.last
    @otbg_words = @big_words
    @otbg_words.pop
  end

  def sinon
    word = params[:sinon].gsub('à', 'a').gsub('á', 'a').gsub('ã', 'a').gsub('â', 'a').gsub('é', 'e').gsub('ê', 'e').gsub('í', 'i').gsub('ó', 'o').gsub('ô', 'o').gsub('õ', 'o').gsub('ú', 'u').gsub('ç', 'c')
    url = "https://www.sinonimos.com.br/#{word}"
    html_doc = Nokogiri::HTML(open(url))
    inicio = html_doc.xpath("//*[contains(@class, 'sinonimo')]").text
    inicio = inicio.gsub('.', ' ').gsub(',', ' ').tr('0-9', '').split(' ')
    inicio.shift
    @sinonimos = inicio.uniq.reject { |x| x.length >= 15 }
    @last_sinon = @sinonimos.pop
    @first_sinon = @sinonimos.shift
  end

  def dicio
    plvr = params[:plvr].gsub('à', 'a').gsub('á', 'a').gsub('ã', 'a').gsub('â', 'a').gsub('é', 'e').gsub('ê', 'e').gsub('í', 'i').gsub('ó', 'o').gsub('ô', 'o').gsub('õ', 'o').gsub('ú', 'u').gsub('ç', 'c')
    urld = "https://www.dicio.com.br/#{plvr}"
    html_txt = Nokogiri::HTML(open(urld))
    @defin = html_txt.xpath("//*[contains(@class, 'textonovo')]//span[not(@class)]")
  end
end
