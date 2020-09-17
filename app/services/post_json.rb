class PostJson
  def initialize(url, json)
    @url = url
    @json = json
  end

  def post
    raise ArgumentError.new('Url is empty.') if @url.empty?
    raise ArgumentError.new('Json is empty') if @json.empty?

    begin
      res = Net::HTTP.post_form(URI(@url), @json)
      JSON.parse(res.body)
    rescue SocketError
      return false
    rescue JSON::ParserError
      return false
    end
  end
end