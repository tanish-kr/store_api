# encoding : utf-8
module StoreApi

  module Request

    TIME_OUT = 20
    @@redirect_count = 0

    ##
    # http get
    # @params [String] host
    # @params [String] path
    # @params [Hash] proxy [:host=>'host',:port=>port]
    # @params [Hash] params
    # @return [String] response.body
    def get(host,path,https=false,proxy=nil,option=nil,params=nil)
      request(host,path,'get',https,proxy,option,params).body
    end

    ##
    # http request
    # @params [String] host
    # @params [String] path
    # @params [Hash] proxy [:host=>'host',:port=>port]
    # @params [String] method get/post
    # @params [Hash] params
    # @return [Object] response
    def request(host,path,method='get',https=false,proxy=nil,option=nil,params=nil)
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
      if !option.nil? && !option.empty?
        if method == 'get'
          if !query_escaped.nil?
            path = path + '?' + query_escaped
          end
          response = http.get(path,option)
          #TODO post/put
        end
      else
        if method == 'get'
          if !query_escaped.nil?
            path = path + '?' + query_escaped
          end
          response = http.get(path)
          #TODO post/put
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
        response = request(redirect_url.host,redirect_url.path,method,https,proxy,option,params)
      else
        @redirect_count = 0
        response
      end
    end
  end
end
