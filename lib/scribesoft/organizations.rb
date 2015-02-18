module Scribesoft
  class Organizations
    include Scribesoft::Actions

    def create_child_org(org_request)
      puts org_request.to_hash
      self.post(org_request.to_hash)
    end

    def type
      # /orgs is part of the base url
      ''
    end

    def org_id
      nil
    end

  end
end
