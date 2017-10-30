class FetchRemoteKeyService
  include RequestHelper
  include ParsingHelper

  def call(uri, options = {})
    @json = fetch_resource(uri)

    return unless supported_context?(@json) && expected_type?
    return find_account(@json['id']) if person?

    @owner = fetch_resource(owner_uri, true)

    return unless supported_context?(@owner) && confirmed_owner?

    find_account(owner_uri)
  end

  private

  def find_account(uri)
    account   = TagManager.uri_to_resource(uri, Account)
    account ||= FetchRemoteAccountService.new.call(uri)
    account
  end

  def expected_type?
    person? || public_key?
  end

  def person?
    @json['type'] == 'Person'
  end

  def public_key?
    @json['publicKeyPem'].present? && @json['owner'].present?
  end

  def owner_uri
    @owner_uri ||= value_or_id(@json['owner'])
  end

  def confirmed_owner?
    @owner['type'] == 'Person' && value_or_id(@owner['publicKey']) == @json['id']
  end
end
