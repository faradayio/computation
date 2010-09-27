module BrighterPlanet
  module Computation
    module CarbonModel
      def self.included(base)
        base.decide :emission, :with => :characteristics do
          committee :emission do # returns kg CO2e
            quorum 'from electricity use and emission factor', :needs => [:electricity_use, :emission_factor] do |characteristics|
              characteristics[:electricity_use] * characteristics[:emission_factor]
            end
            
            quorum 'default' do
              raise "The emission committee's default quorum should never be called."
            end
          end
          
          committee :emission_factor do # returns kg co2e / kWh
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_emission_factor
            end
          end
          
          committee :electricity_use do # returns kWh including distribution losses
            quorum 'from compute units, time, electricity intensity, PUE, and eGRID region', :needs => [:compute_units, :compute_time, :compute_electricity_intensity, :power_usage_effectiveness, :egrid_region] do |characteristics|
              (characteristics[:compute_units] * characteristics[:compute_time] * characteristics[:compute_electricity_intensity] * characteristics[:power_usage_effectiveness]) / (1 - characteristics[:egrid_region].loss_factor)
            end
          end
          
          committee :power_usage_effectiveness do # returns data center total energy use / IT energy use
            quorum 'default' do
              base.fallback.power_usage_effectiveness
            end
          end
          
          committee :compute_electricity_intensity do # returns kW (average load of IT infrastructure)
            quorum 'default' do
              base.fallback.compute_electricity_intensity
            end
          end
          
          committee :egrid_region do # returns eGRID region
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].egrid_region
            end
          end
          
          committee :egrid_subregion do # returns eGRID subregion
            quorum 'from zip code', :needs => :zip_code do |characteristics|
              characteristics[:zip_code].egrid_subregion
            end
            
            quorum 'default' do
              EgridSubregion.find_by_abbreviation 'US'
            end
          end
          
          committee :compute_time do # returns hours
            quorum 'default' do
              base.fallback.compute_time
            end
          end
          
          committee :compute_units do # returns compute units (EC2 instances)
            quorum 'default' do
              base.fallback.compute_units
            end
          end
        end
      end
    end
  end
end
