module Locomotive
  module Wagon
    module Generators
      module Site

        class Foundation5 < Base

          may_use_haml

          def choose_haml_over_html
            if haml?
              remove_file File.join(self.destination, 'app/views/pages/index.liquid')
              remove_file File.join(self.destination, 'app/views/pages/404.liquid')
              remove_file File.join(self.destination, 'app/views/snippets/footer.liquid')
            else
              remove_file File.join(self.destination, 'app/views/pages/index.liquid.haml')
              remove_file File.join(self.destination, 'app/views/pages/404.liquid.haml')
              remove_file File.join(self.destination, 'app/views/snippets/footer.liquid.haml')
            end
          end

          def bundle_install
            super
          end

        end

        Locomotive::Wagon::Generators::Site.register(:foundation5, Foundation5, %{
          A site powered by Foundation (v5.1.1).
        })
      end
    end
  end
end