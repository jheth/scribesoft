module Scribesoft
  class OrganizationRequest

    def initialize(name, parent_id, website)
      @model = {
        Name: name,
        ParentId: parent_id,
        Website: website,
        SecurityRules: [{
          Name: "Full Access",
          ApiAccessEnabled: true,
          EventSolutionAccessEnabled: true,
          AllowedIpRangeStartAddress: "0.0.0.0",
          AllowedIpRangeEndAddress: "255.255.255.255"
        }]
      }
    end

    def to_hash
      @model
    end

  end
end