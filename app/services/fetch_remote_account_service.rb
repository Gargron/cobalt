class FetchRemoteAccountService
  include RequestHelper
  include ParsingHelper

  def call(uri, options = {})
    @json = fetch_resource(uri)

    return unless supported_context? && expected_type?

    @uri      = @json['id']
    @username = @json['preferredUsername']

    process_account!
    @account
  rescue Oj::ParseError
    nil
  end

  private

  def process_account!
    @account   = Account.find_by(uri: @uri)
    @account ||= Account.new(uri: @uri, username: @username, local: false)

    @account.display_name      = @json['name'] || ''
    @account.avatar_remote_url = image_url('icon')
    @account.header_remote_url = image_url('image')
    @account.key               = public_key
    @account.save!
  end

  def image_url(key)
    value = first_of_value(@json[key])

    return if value.nil?
    return value['url'] if value.is_a?(Hash)

    image = fetch_resource_without_id_validation(value)
    image['url'] if image
  end

  def public_key
    value = first_of_value(@json['publicKey'])

    return if value.nil?
    return value['publicKeyPem'] if value.is_a?(Hash)

    key = fetch_resource_without_id_validation(value)
    key['publicKeyPem'] if key
  end

  def supported_context?
    super(@json)
  end

  def expected_type?
    @json['type'] == 'Person'
  end
end
