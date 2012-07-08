module Checker
  module Modules
    class All < Base
      include ::Checker::Utils
      def check
        checked = []
        constants = available_modules - ["all"]
        constants.each do |const|
          klass = "Checker::Modules::#{const.capitalize}".constantize
          checked << klass.new.check
        end
        checked.all_true?
      end
    end
  end
end
