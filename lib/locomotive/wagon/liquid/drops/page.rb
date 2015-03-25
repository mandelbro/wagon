module Locomotive
  module Wagon
    module Liquid
      module Drops
        class Page < Base

          delegate :fullpath, :parent, :depth, :seo_title, :redirect_url, :meta_description, :meta_keywords,
                   :templatized?, :published?, :redirect?, :listed?, :handle, to: :@_source

          def title
            title =  @_source.templatized? ? @context['entry'].try(:_label) : nil
            title || @_source.title
          end

          def slug
            slug = @_source.templatized? ? @context['entry'].try(:_slug).try(:singularize) : nil
            slug || @_source.slug
          end

          def is_layout?
            @_source.is_layout
          end

          def original_title
            @_source.title
          end

          def original_slug
            @_source.slug
          end

          def children
            _children = @_source.children || []
            _children = _children.sort { |a, b| a.position.to_i <=> b.position.to_i }
            @children ||= liquify(*_children)
          end

          def content_type
            ProxyCollection.new(@_source.content_type) if @_source.content_type
          end

          def editable_elements
            @editable_elements_hash ||= build_editable_elements_hash
          end

          def breadcrumbs
            # TODO
            ''
          end

          private

          def build_editable_elements_hash
            {}.tap do |hash|
              @_source.editable_elements.each do |el|
                safe_slug = el.slug.parameterize.underscore
                keys      = el.block.try(:split, '/').try(:compact) || []

                _hash = _build_editable_elements_hashes(hash, keys)

                _hash[safe_slug] = el.content
              end
            end
          end

          def _build_editable_elements_hashes(hash, keys)
            _hash = hash

            keys.each do |key|
              safe_key = key.parameterize.underscore

              _hash[safe_key] = {} if _hash[safe_key].nil?

              _hash = _hash[safe_key]
            end

            _hash
          end

        end
      end
    end
  end
end
