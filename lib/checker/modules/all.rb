module Checker
  module Modules
    ## simple wrapper, to call every module
    class All
      def self.check
        checked = []
        constants = Utils.available_modules - ["all"]
        constants.each do |const|
          klass = "Checker::Modules::#{const.capitalize}".constantize
          checked << klass.check
        end
        checked.all_true?
      end
    end
  end
end
