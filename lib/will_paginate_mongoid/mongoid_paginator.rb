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
