# Copyright © 2010 Brighter Planet.
# See LICENSE for details.
# Contact Brighter Planet for dual-license arrangements.

require 'earth/computation/computation_carrier'
require 'earth/computation/computation_carrier_instance_class'
require 'earth/locality/egrid_subregion'

## Computation carbon model
# This model is used by [Brighter Planet](http://brighterplanet.com)'s carbon emission [web service](http://carbon.brighterplanet.com) to estimate the **greenhouse gas emissions of server use**.
#
##### Timeframe and activity period
# The model estimates the emissions that occur during a particular `timeframe`. To do this it needs to know the `date` on which the computations occurred. For example, if the `timeframe` is January 2010, a computation that occurred on January 5, 2010 will have emissions but a computation that occurred on February 1, 2010 will not.
#
##### Calculations
# The final estimate is the result of the **calculations** detailed below. These calculations are performed in reverse order, starting with the last calculation listed and finishing with the `emission` calculation. Each calculation is named according to the value it returns.
#
##### Methods
# To accomodate varying client input, each calculation may have one or more **methods**. These are listed under each calculation in order from most to least preferred. Each method is named according to the values it requires. If any of these values is not available the method will be ignored. If all the methods for a calculation are ignored, the calculation will not return a value. "Default" methods do not require any values, and so a calculation with a default method will always return a value.
#
##### Collaboration
# Contributions to this carbon model are actively encouraged and warmly welcomed. This library includes a comprehensive test suite to ensure that your changes do not cause regressions. All changes should include test coverage for new functionality. Please see [sniff](https://github.com/brighterplanet/sniff#readme), our emitter testing framework, for more information.
module BrighterPlanet
  module Computation
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          ### Emission calculation
          # Returns the `emission` (*kg CO<sub>2</sub>e*).
          committee :carbon do
            #### Emission from CO<sub>2</sub> emission, CH<sub>4</sub> emission, and N<sub>2</sub>O emission
            quorum 'from co2 emission, ch4 emission, and n2o emission', :needs => [:co2_emission, :ch4_emission, :n2o_emission] do |characteristics|
              # Adds `co2 emission` (*kg*), `ch4 emission` (*kg CO<sub>2</sub>e*), and `n2o emission` (*kg CO<sub>2</sub>e*) to give (*kg CO<sub>2</sub>e*).
              characteristics[:co2_emission] + characteristics[:ch4_emission] + characteristics[:n2o_emission]
            end
          end
          
          ### CO<sub>2</sub> emission calculation
          # Returns the `co2 emission` (*kg*).
          committee :co2_emission do
            #### CO<sub>2</sub> emission from electricity use, CO<sub>2</sub> emission factor, date, and timeframe
            quorum 'from electricity use, co2 emission factor, date, and timeframe', :needs => [:electricity_use, :co2_emission_factor, :date] do |characteristics, timeframe|
              # Checks whether the computation `date` falls within the `timeframe`.
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                # Multiplies `electricity use` (*kWh*) by `co2 emission factor` (*kg / kWh*) to give *kg*.
                characteristics[:electricity_use] * characteristics[:co2_emission_factor]
              else
                # If the `date` does not fall within the `timeframe`, `co2 emission` is zero.
                0
              end
            end
          end
          
          ### CO<sub>2</sub> biogenic emission calculation
          # Returns the `co2 biogenic emission` (*kg*).
          committee :co2_biogenic_emission do
            #### CO<sub>2</sub> biogenic emission from electricity use, CO<sub>2</sub> biogenic emission factor, date, and timeframe
            quorum 'from electricity use, co2 biogenic emission factor, date, and timeframe', :needs => [:electricity_use, :co2_biogenic_emission_factor, :date] do |characteristics, timeframe|
              # Checks whether the computation `date` falls within the `timeframe`.
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                # Multiplies `electricity use` (*kWh*) by `co2 biogenic emission factor` (*kg / kWh*) to give *kg*.
                characteristics[:electricity_use] * characteristics[:co2_biogenic_emission_factor]
              else
                # If the `date` does not fall within the `timeframe`, `co2 biogenic emission` is zero.
                0
              end
            end
          end
          
          ### CH<sub>4</sub> emission calculation
          # Returns the `ch4 emission` (*kg CO<sub>2</sub>e*).
          committee :ch4_emission do
            #### CH<sub>4</sub> emission from electricity use, CH<sub>4</sub> emission factor, date, and timeframe
            quorum 'from electricity use, ch4 emission factor, date, and timeframe', :needs => [:electricity_use, :ch4_emission_factor, :date] do |characteristics, timeframe|
              # Checks whether the computation `date` falls within the `timeframe`.
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                # Multiplies `electricity use` (*kWh*) by `ch4 emission factor` (*kg CO<sub>2</sub>e / kWh*) to give *kg CO<sub>2</sub>e*.
                characteristics[:electricity_use] * characteristics[:ch4_emission_factor]
              else
                # If the `date` does not fall within the `timeframe`, `ch4 emission` is zero.
                0
              end
            end
          end
          
          ### N<sub>2</sub>O emission calculation
          # Returns the `n2o emission` (*kg CO<sub>2</sub>e*).
          committee :n2o_emission do
            #### N<sub>2</sub>O emission from electricity use, N<sub>2</sub>O emission factor, date, and timeframe
            quorum 'from electricity use, n2o emission factor, date, and timeframe', :needs => [:electricity_use, :n2o_emission_factor, :date] do |characteristics, timeframe|
              # Checks whether the computation `date` falls within the `timeframe`.
              if timeframe.include? Date.parse(characteristics[:date].to_s)
                # Multiplies `electricity use` (*kWh*) by `n2o emission factor` (*kg CO<sub>2</sub>e / kWh*) to give *kg CO<sub>2</sub>e*.
                characteristics[:electricity_use] * characteristics[:n2o_emission_factor]
              else
                # If the `date` does not fall within the `timeframe`, `n2o emission` is zero.
                0
              end
            end
          end
          
          ### CO<sub>2</sub> emission factor calculation
          # Returns the `co2 emission factor` (*kg / kWh*).
          committee :co2_emission_factor do
            #### CO<sub>2</sub> emission factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) `co2 emission factor` (*kg / kWh*).
              characteristics[:egrid_subregion].co2_emission_factor
            end
          end
          
          ### CO<sub>2</sub> biogenic emission factor calculation
          # Returns the `co2 biogenic emission factor` (*kg / kWh*).
          committee :co2_biogenic_emission_factor do
            #### CO<sub>2</sub> biogenic emission factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) `co2 biogenic emission factor` (*kg / kWh*).
              characteristics[:egrid_subregion].co2_biogenic_emission_factor
            end
          end
          
          ### CH<sub>4</sub> emission factor calculation
          # Returns the `ch4 emission factor` (*kg CO<sub>2</sub>e / kWh*).
          committee :ch4_emission_factor do
            #### CH<sub>4</sub> emission factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) `ch4 emission factor` (*kg CO<sub>2</sub>e / kWh*).
              characteristics[:egrid_subregion].ch4_emission_factor
            end
          end
          
          ### N<sub>2</sub>O emission factor calculation
          # Returns the `n2o emission factor` (*kg CO<sub>2</sub>e / kWh*).
          committee :n2o_emission_factor do
            #### N<sub>2</sub>O emission factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) `n2o emission factor` (*kg CO<sub>2</sub>e / kWh*).
              characteristics[:egrid_subregion].n2o_emission_factor
            end
          end
          
          ### Electricity use calculation
          # Returns `electricity use` (*kWh*) including distribution losses.
          committee :electricity_use do
            #### Electricity use from duration, electricity intensity, PUE, and electricity loss factor
            quorum 'from duration, electricity intensity, PUE, and electricity loss factor', :needs => [:duration, :electricity_intensity, :power_usage_effectiveness, :electricity_loss_factor] do |characteristics|
              # Divides `duration` (*seconds*) by 3,600 *seconds / hour*, multiplies by `electricity intensity` (*kW*) and `PUE`, and divides by (1 - `electricity loss factor`) to give *kWh*.
              (characteristics[:duration] / 3600.0 * characteristics[:electricity_intensity] * characteristics[:power_usage_effectiveness]) / (1 - characteristics[:electricity_loss_factor])
            end
          end
          
          ### Electricity loss factor calculation
          # Returns the `electricity loss factor`. This is the percentage of electricity lost during transmission and distribution.
          committee :electricity_loss_factor do
            #### Electricity loss factor from eGRID region
            quorum 'from eGRID region', :needs => :egrid_region do |characteristics|
              # Looks up the [eGRID region](http://data.brighterplanet.com/egrid_regions) `electricity loss factor`.
              characteristics[:egrid_region].loss_factor
            end
          end
          
          ### eGRID region calculation
          # Returns the `eGRID region` where the data center is located.
          committee :egrid_region do
            #### eGRID region from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) `eGRID region`.
              characteristics[:egrid_subregion].egrid_region
            end
          end
          
          ### eGRID subregion calculation
          # Returns the `eGRID subregion` where the data center is located.
          committee :egrid_subregion do
            #### eGRID subregion from zip code
            quorum 'from zip code', :needs => :zip_code do |characteristics|
              # Looks up the [zip code](http://data.brighterplanet.com/zip_codes) `eGRID subregion`.
              characteristics[:zip_code].egrid_subregion
            end
            
            #### eGRID subregion from carrier region
            quorum 'from carrier region', :needs => :carrier_region do |characteristics|
              # Looks up the [carrier region](http://data.brighterplanet.com/computation_carrier_regions) `eGRID subregion`.
              characteristics[:carrier_region].egrid_subregion
            end
            
            #### Default eGRID subregion
            quorum 'default' do
              # Uses the fallback [eGRID subregion](http://data.brighterplanet.com/egrid_subregions), representing the U.S. average.
              EgridSubregion.fallback
            end
          end
          
          ### Zip code calculation
          # Returns the client-input `zip code` of the data center.
          
          ### Carrier region calculation
          # Returns the client-input [carrier region](http://data.brighterplanet.com/computation_carrier_regions) of the data center.
          
          ### Power usage effectiveness calculation
          # Returns the `power usage effectiveness` (PUE). This is the ratio of total data center power to IT infrastructure power.
          committee :power_usage_effectiveness do
            #### Power usage effectivenss from client input
            # Uses the client-input `power usage effectiveness`.
            
            #### Power usage effectiveness from carrier
            quorum 'from carrier', :needs => :carrier do |characteristics|
              # Looks up the [carrier](http://data.brighterplanet.com/computation_carriers) `power usage effectiveness`.
              characteristics[:carrier].power_usage_effectiveness
            end
          end
          
          ### Electricity intensity calculation
          # Returns the `electricity intensity` (*kW*). This is the average load of the data center IT infrastructure.
          committee :electricity_intensity do
            #### Electricity intensity from client input
            # Uses the client-input `electricity intensity` (*kW*).
            
            #### Electricity intensity from carrier instance class
            quorum 'from carrier instance class', :needs => :carrier_instance_class do |characteristics|
              # Looks up the [carrier instance class](http://data.brighterplanet.com/computation_carrier_instance_classes) `electricity intensity` (*kW*).
              characteristics[:carrier_instance_class].electricity_intensity
            end
          end
          
          ### Carrier instance class calculation
          # Returns the computation `carrier instance class`. This is the type of virtual instance.
          committee :carrier_instance_class do
            #### Carrier instance class from client input
            # Uses the client-input [carrier instance class](http://data.brighterplanet.com/computation_carrier_instance_classes).
            
            #### Default carrier instance class
            quorum 'default' do
              # Assumes [Amazon m1.small](http://data.brighterplanet.com/computation_carrier_instance_classes).
              ComputationCarrierInstanceClass.fallback
            end
          end
          
          ### Carrier calculation
          # Returns the computation `carrier`. This is the company that runs the data center.
          committee :carrier do
            #### Carrier from client input
            # Uses the client-input [carrier](http://data.brighterplanet.com/computation_carriers).
            
            #### Default carrier
            quorum 'default' do
              # Assumes [Amazon](http://data.brighterplanet.com/computation_carriers).
              ComputationCarrier.fallback
            end
          end
          
          ### Duration calculation
          # Returns the computation's `duration` (*seconds*).
          committee :duration do
            #### Duration from client input
            # Uses the client-input `duration`.
            
            #### Default duration
            quorum 'default' do
              # Assumes 3,600 *seconds*.
              base.fallback.duration
            end
          end
          
          ### Date calculation
          # Returns the `date` on which the computation occurred.
          committee :date do
            #### Date from client input
            # Uses the client-input `date`.
            
            #### Date from timeframe
            quorum 'from timeframe' do |characteristics, timeframe|
              # Assumes the first day of the `timeframe`.
              timeframe.from
            end
          end
          
          ### Timeframe calculation
          # Returns the `timeframe`.
          # This is the period during which to calculate emissions.
            
            #### Timeframe from client input
            # **Complies:** All
            #
            # Uses the client-input `timeframe`.
            
            #### Default timeframe
            # **Complies:** All
            #
            # Uses the current calendar year.
        end
      end
    end
  end
end
