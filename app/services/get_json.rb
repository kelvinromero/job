class GetJson
  def initialize(url)
    @url = url
  end

  def get
    begin
      res = Net::HTTP.get_response(URI(@url))
      JSON.parse(res.body)['data']
    rescue SocketError
      return false
    rescue JSON::ParserError
      return false
    end
  end
end