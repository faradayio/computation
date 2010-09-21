module BrighterPlanet
  module Computation
    module Summarization
      def self.included(base)
        base.summarize do |has|
          has.identity 'computation'
        end
      end
    end
  end
end
