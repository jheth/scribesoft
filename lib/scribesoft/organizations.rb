module Scribesoft
  class Organizations
    include Scribesoft::Actions

    def create_child_org(org_request)
      # No id, no extra path
      self.post_action(id='', path='', org_request.to_hash)
    end

    def type
      # /orgs is part of the base url
      ''
    end

    def organization_id
      ''
    end
  end
end
