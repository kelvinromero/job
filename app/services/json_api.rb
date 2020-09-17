class JsonApi
  def initialize(url, json=nil)
    @url = url
    @json = json
  end

  def get
    raise ArgumentError.new('Url is empty.') if @url.empty?

    begin
      res = Net::HTTP.get(URI(@url))
      JSON.parse(res)['data']
    rescue SocketError
      return false
    rescue JSON::ParserError
      return false
    end
  end

  def post
    raise ArgumentError.new('Url is empty.') if @url.empty?
    raise ArgumentError.new('Json is empty') if @json.empty?

    begin
      res = Net::HTTP.post(URI(@url), @json.to_json, "Content-Type" => "application/json")
      JSON.parse(res.body)
    rescue SocketError
      return false
    rescue JSON::ParserError
      return false
    end
  end
end