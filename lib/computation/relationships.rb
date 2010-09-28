module BrighterPlanet
  module Computation
    module Relationships
      def self.included(base)
        base.send :belongs_to, :zip_code, :foreign_key => 'zip_code_name'
      end
    end
  end
end
