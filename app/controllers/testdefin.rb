  def defin
    word = params[:plvr].gsub('à', 'a').gsub('á', 'a').gsub('ã', 'a').gsub('â', 'a').gsub('é', 'e').gsub('ê', 'e').gsub('í', 'i').gsub('ó', 'o').gsub('ô', 'o').gsub('õ', 'o').gsub('ú', 'u').gsub('ç', 'c')
    url = "https://www.dicio.com.br/#{word}"
    html_doc = Nokogiri::HTML(open(url))
    inicio = html_doc.xpath("//*[contains(@class, 'sinonimo')]").text
    inicio = inicio.gsub('.', ' ').gsub(',', ' ').tr('0-9', '').split(' ')
    @defin = inicio.uniq.reject { |x| x.length >= 15 }
    @last_defin = @defin.pop
    @first_defin = @defin.shift
  end

  https://www.dicio.com.br/falar
