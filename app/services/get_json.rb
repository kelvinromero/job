class GetJson
  def initialize(url)
    @url = url
  end

  def get
    raise ArgumentError.new('Url is empty.') if @url.empty?

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