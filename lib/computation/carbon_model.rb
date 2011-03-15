module BrighterPlanet
  module Computation
    module CarbonModel
      def self.included(base)
        base.decide :emission, :with => :characteristics do
          committee :emission do # returns kg co2e
            quorum 'from co2 emission, ch4 emission, and n2o emission', :needs => [:co2_emission, :ch4_emission, :n2o_emission] do |characteristics|
              characteristics[:co2_emission] + characteristics[:ch4_emission] + characteristics[:n2o_emission]
            end
          end
          
          committee :co2_emission do # returns kg
            quorum 'from electricity use, co2 emission factor, date, and timeframe', :needs => [:electricity_use, :co2_emission_factor, :date] do |characteristics, timeframe|
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                characteristics[:electricity_use] * characteristics[:co2_emission_factor]
              else
                0
              end
            end
          end
          
          committee :co2_biogenic_emission do # returns kg
            quorum 'from electricity use, co2 biogenic emission factor, date, and timeframe', :needs => [:electricity_use, :co2_biogenic_emission_factor, :date] do |characteristics, timeframe|
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                characteristics[:electricity_use] * characteristics[:co2_biogenic_emission_factor]
              else
                0
              end
            end
          end
          
          committee :ch4_emission do # returns kg co2e
            quorum 'from electricity use, ch4 emission factor, date, and timeframe', :needs => [:electricity_use, :ch4_emission_factor, :date] do |characteristics, timeframe|
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                characteristics[:electricity_use] * characteristics[:ch4_emission_factor]
              else
                0
              end
            end
          end
          
          committee :n2o_emission do # returns kg co2e
            quorum 'from electricity use, n2o emission factor, date, and timeframe', :needs => [:electricity_use, :n2o_emission_factor, :date] do |characteristics, timeframe|
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                characteristics[:electricity_use] * characteristics[:n2o_emission_factor]
              else
                0
              end
            end
          end
          
          committee :co2_emission_factor do # returns kg / kWh
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_co2_emission_factor
            end
          end
          
          committee :co2_biogenic_emission_factor do # returns kg / kWh
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_co2_biogenic_emission_factor
            end
          end
          
          committee :ch4_emission_factor do # returns kg co2e / kWh
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_ch4_emission_factor
            end
          end
          
          committee :n2o_emission_factor do # returns kg co2e / kWh
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_n2o_emission_factor
            end
          end
          
          committee :electricity_use do # returns kWh including distribution losses
            quorum 'from duration, electricity intensity, PUE, and electricity loss factor', :needs => [:duration, :electricity_intensity, :power_usage_effectiveness, :electricity_loss_factor] do |characteristics|
              (characteristics[:duration] / 3600.0 * characteristics[:electricity_intensity] * characteristics[:power_usage_effectiveness]) / (1 - characteristics[:electricity_loss_factor])
            end
          end
          
          committee :electricity_loss_factor do # returns electricity transmission and distribution loss factor
            quorum 'from eGRID region', :needs => :egrid_region do |characteristics|
              characteristics[:egrid_region].loss_factor
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
            
            quorum 'from carrier region', :needs => :carrier_region do |characteristics|
              characteristics[:carrier_region].egrid_subregion
            end
            
            quorum 'default' do
              EgridSubregion.fallback
            end
          end
          
          committee :power_usage_effectiveness do # returns data center total energy use / IT energy use
            quorum 'from carrier', :needs => :carrier do |characteristics|
              characteristics[:carrier].power_usage_effectiveness
            end
          end
          
          committee :electricity_intensity do # returns kW (average load of IT infrastructure)
            quorum 'from carrier instance class', :needs => :carrier_instance_class do |characteristics|
              characteristics[:carrier_instance_class].electricity_intensity
            end
          end
          
          committee :carrier_instance_class do # returns the instance class e.g. m1.small
            quorum 'default' do
              ComputationCarrierInstanceClass.fallback
            end
          end
          
          committee :carrier do # returns the carrier e.g. Amazon
            quorum 'default' do
              ComputationCarrier.fallback
            end
          end
          
          committee :duration do # returns seconds
            quorum 'default' do
              base.fallback.duration
            end
          end
        end
      end
    end
  end
end
