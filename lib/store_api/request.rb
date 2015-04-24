# encoding : utf-8
module StoreApi

  module Request

    TIME_OUT = 20
    @@redirect_count = 0

    ##
    # http get
    # @param [String] host
    # @param [String] path
    # @param [Hash] proxy [:host=>'host',:port=>port]
    # @param [Hash] header http header
    # @param [Hash] params
    # @return [String] response.body
    def get(host,path,params=nil,https=false,proxy=nil,header=nil)
      request(host,path,'get',params,https,proxy,header).body
    end

    ##
    # http post
    # @param [String] host
    # @param [String] path
    # @param [Hash] params
    # @param [Hash] proxy [:host=>'host',:port=>port]
    # @param [Hash] header http header
    # @return [String] response.body
    def post(host,path,params=nil,https=false,proxy=nil,header=nil)
      request(host,path,'post',params,https,proxy,header).body
    end

    ##
    # http request
    # @param [String] host
    # @param [String] path
    # @param [String] method get/post
    # @param [Boolean] https
    # @param [Hash] proxy [:host=>'host',:port=>port]
    # @param [Hash] header http header
    # @param [Hash] params
    # @return [Object] response
    def request(host,path,method='get',params=nil,https=false,proxy=nil,header=nil)
      if !params.nil?
        query = params.map{|k,v| "#{k}=#{v}"}.join('&')
        query_escaped = URI.escape(query)
      end
      if !proxy.nil? && !proxy.empty?
        if https
          http = Net::HTTP::Proxy(proxy[:host],proxy[:port]).new(host,443)
        else
          http = Net::HTTP::Proxy(proxy[:host],proxy[:port]).new(host)
        end
      else
        if https
          http = Net::HTTP.new(host,443)
          http.use_ssl = true
        else
          http = Net::HTTP.new(host)
        end
      end
      http.read_timeout = TIME_OUT
      if !header.nil? && !header.empty?
        if method == 'get'
          if !query_escaped.nil?
            path = path + '?' + query_escaped
          end
          response = http.get(path,header)
        elsif method == 'post'
          if !query_escaped.nil?
            response = http.post(path,query_escaped,header)
          else
            response = http.post(path,nil,header)
          end
        end
      else
        if method == 'get'
          if !query_escaped.nil?
            path = path + '?' + query_escaped
          end
          response = http.get(path)
        elsif method == 'post'
          if !query_escaped.nil?
            response = http.post(path,query_escaped)
          else
            response = http.post(path)
          end
        end
      end
      if response.code.to_i > 500
        @@redirect_count = 0
        raise "Server Error ! responce code = #{response.code} response = #{response.body}"
      elsif response.code.to_i >= 400 && response.code.to_i < 500
        @@redirect_count = 0
        raise "Not Found ! responce codee = #{response.code} response = #{response.body}"
      elsif response.code.to_i >= 300 && response.code.to_i < 400
        redirect_url = URI.parse(response.header['location'])
        if redirect_url.scheme == "https"
          https = true
        end
        @@redirect_count = @@redirect_count + 1
        if @@redirect_count > 5
          raise "Exception Redirect Loop"
        end
        response = request(redirect_url.host,redirect_url.path,method,params,https,proxy,header)
      else
        @redirect_count = 0
        response
      end
    end
  end
end
