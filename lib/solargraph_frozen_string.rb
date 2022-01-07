# frozen_string_literal: true

require_relative "solargraph_frozen_string/version"
requre "solargraph"

# Extends Solargraph with a diagnostics reporter that checks for the presence of a frozen_string_literal
# comment at the top of a Ruby script
class FrozenStringReporter < Solargraph::Diagnostics::Base
  def diagnose(source, _api_map)
    return [] if source.code.empty? || source.code.start_with?("# frozen_string_literal:")

    [
      {
        range: Solargraph::Range.from_to(0, 0, 0, source.code.lines[0].length),
        severity: Diagnostics::Severities::WARNING,
        source: "FrozenString",
        message: "File does not start with frozen_string_literal."
      }
    ]
  end
end

Solargraph::Diagnostics.register "frozen-string", FrozenStringReporteri
