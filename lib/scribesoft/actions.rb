module Scribesoft
  module Actions

    attr_reader :organization_id, :hostname, :encoded_credentials

    def initialize(organization_id, email: nil, password: nil, encoded_credentials: nil, hostname: nil)
      @organization_id = organization_id
      if email && password
        @encoded_credentials = Base64.strict_encode64("#{email}:#{password}")
      else
        @encoded_credentials = encoded_credentials
      end
      raise "Email/Password or Encoded Credentials must be provided" if email.nil? && password.nil? && encoded_credentials.nil?

      @hostname = hostname || "endpoint.scribesoft.com"
      @hostname << "/v1/orgs"
    end

    def options
      {
        headers: {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{encoded_credentials}"
        },
        debug_output: STDOUT
      }
    end

    def get_all(path, data={})
      HTTParty.get(build_url('', path: path), options.merge(data))
    end

    def get(id='', data={})
      HTTParty.get(build_url(id), options.merge(data))
    end

    def get_action(id, action, data={})
      url = "#{build_url(id)}/#{action}"
      HTTParty.get(url, options.merge(data))
    end

    def post(data={})
      HTTParty.post(build_url,
        options.merge(
          body: data.to_json
        )
      )
    end

    def post_action(action, data={})
      url = "#{build_url}/#{action}"
      HTTParty.post(url,
        options.merge(
          body: data.to_json
        )
      )
    end

    def put(id, data={})
      HTTParty.put(build_url(id),
        options.merge(
          body: data.to_json
        )
      )
    end

    def delete(id)
      HTTParty.delete(build_url(id), options)
    end

    def delete_action(id, action, data={})
      url = "#{build_url(id)}/#{action}"
      HTTParty.delete(url, options.merge(data))
    end

    def build_url(id='', path: nil)
      base_url = "https://#{hostname}/#{organization_id}"
      if path.present?
        base_url += "/#{path}"
      elsif type != ""
        base_url += "/#{type}"
      end

      if id.to_s != ""
        base_url += "/#{id}"
      end
      base_url
    end

    def type
      raise NotImplementedError.new("Type method must be implemented.")
    end

  end
end
