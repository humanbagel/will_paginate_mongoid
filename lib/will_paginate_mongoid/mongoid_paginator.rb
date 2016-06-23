module WillPaginateMongoid
  DEFAULT_PER_PAGE = 10

  module MongoidPaginator
    extend ActiveSupport::Concern

    included do
      def self.paginate(options = {})
        options = base_options options

        self.skip(options[:offset]).limit(options[:per_page])
      end


      def self.page(page)
        paginate({page: page})
      end

      def total_pages
        leftover = self.size % self.options[:limit]
        page_size = (self.size / self.options[:limit]).floor
        page_size += 1 if leftover > 0
        page_size
      end

      def current_page
        (self.options[:skip] / self.options[:limit]) + 1
      end

      private

      def self.base_options(options)
        options[:page] ||= 1
        options[:per_page] ||= (WillPaginate.per_page || 10)
        options[:offset] = (options[:page].to_i - 1) * options[:per_page].to_i
        options
      end
    end
  end
end
