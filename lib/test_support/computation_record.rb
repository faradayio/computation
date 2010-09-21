require 'active_record'
require 'computation'
require 'sniff'

class ComputationRecord < ActiveRecord::Base
  include Sniff::Emitter
  include BrighterPlanet::Computation
end
