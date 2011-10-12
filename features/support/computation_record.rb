require 'active_record'
require 'computation'
require 'sniff'

class ComputationRecord < ActiveRecord::Base
  include BrighterPlanet::Emitter
  include BrighterPlanet::Computation
end
