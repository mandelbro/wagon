module Locomotive
  module Wagon
    module Liquid
      module Filters
        module Misc

          # was called modulo at first
          def str_modulo(word, index, modulo)
            (index.to_i + 1) % modulo == 0 ? word : ''
          end

          # Get the nth element of the passed in array
          def index(array, position)
            array.at(position) if array.respond_to?(:at)
          end

          def default(input, value)
            input.blank? ? value : input
          end

          def random(input)
            rand(input.to_i)
          end

          def darken_color(hex_color, amount=0.4)
            hex_color = hex_color.gsub('#','')
            rgb = hex_color.scan(/../).map {|color| color.hex}
            rgb[0] = (rgb[0].to_i * amount).round
            rgb[1] = (rgb[1].to_i * amount).round
            rgb[2] = (rgb[2].to_i * amount).round
            "#%02x%02x%02x" % rgb
          end

          # Amount should be a decimal between 0 and 1. Higher means lighter
          def lighten_color(hex_color, amount=0.6)
            hex_color = hex_color.gsub('#','')
            rgb = hex_color.scan(/../).map {|color| color.hex}
            rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
            rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
            rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
            "#%02x%02x%02x" % rgb
          end

          # map/collect on a given property (support to_f, to_i)
          def map(input, property)
            flatten_if_necessary(input).map do |e|
              e = e.call if e.is_a?(Proc)

              if property == "to_liquid"
                e
              elsif property == "to_f"
                e.to_f
              elsif property == "to_i"
                e.to_i
              elsif e.respond_to?(:[])
                e[property]
              end
            end
          end

        end

        ::Liquid::Template.register_filter(Misc)

      end
    end
  end
end
