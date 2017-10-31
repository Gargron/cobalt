class ActivityPub::UndoSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Undo'
  end

  def target
    instance_options[:payload]
  end
end
