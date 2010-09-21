require 'characterizable'

module BrighterPlanet
  module Computation
    module Characterization
      def self.included(base)
        base.characterize do
          has :compute_time
        end
      end
    end
  end
end
