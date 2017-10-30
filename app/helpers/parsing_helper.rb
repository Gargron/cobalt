module ParsingHelper
  def equals_or_includes?(haystack, needle)
    haystack.is_a?(Array) ? haystack.include?(needle) : haystack == needle
  end

  def first_of_value(value)
    value.is_a?(Array) ? value.first : value
  end

  def as_array(value)
    value.is_a?(Array) ? value : [value]
  end

  def value_or_id(value)
    value.is_a?(String) || value.nil? ? value : value['id']
  end

  def supported_context?(json)
    !json.nil? && equals_or_includes?(json['@context'], TagManager::CONTEXT)
  end

  def canonicalize(json)
    graph = RDF::Graph.new << JSON::LD::API.toRdf(json)
    graph.dump(:normalize)
  end

  def merge_context(context, new_context)
    if context.is_a?(Array)
      context << new_context
    else
      [context, new_context]
    end
  end
end
