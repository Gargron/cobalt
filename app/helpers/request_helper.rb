module RequestHelper
  def fetch_resource(uri, id = false)
    unless id
      json = fetch_resource_without_id_validation(uri)
      return unless json
      uri = json['id']
    end

    json = fetch_resource_without_id_validation(uri)
    json.present? && json['id'] == uri ? json : nil
  end

  def fetch_resource_without_id_validation(uri)
    response = build_request(uri).perform
    return if response.code != 200
    body_to_json(response.to_s)
  end

  def body_to_json(body)
    body.is_a?(String) ? Oj.load(body, mode: :strict) : body
  rescue Oj::ParseError
    nil
  end

  private

  def build_request(uri)
    request = Request.new(:get, uri)
    request.add_headers('Accept' => 'application/activity+json, application/ld+json')
    request
  end
end
