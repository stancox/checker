module Checker
  module Modules
    ## simple wrapper, to call every module
    class All
      def self.check
        checked = []
        constants = Checker::Modules.constants - [:All]
        constants.each do |const|
          klass = "Checker::Modules::#{const.to_s}".constantize
          checked << klass.check
        end
        checked.all_true?
      end
    end
  end
end
