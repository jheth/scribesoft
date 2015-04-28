module Scribesoft
  class Connectors
    include Scribesoft::Actions

    def delete(id)
      self.delete_action(id, 'delete')
    end

    def install(connector_id)
      self.post_action(connector_id, "install")
    end

    def type
      'connectors'
    end

  end
end
