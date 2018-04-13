PuppetLint.new_check(:sre_roles_include_profiles) do
  def check
    class_indexes.select { |c| c[:name_token].value =~ /^role(::|$)/ }.each do |c|
      # As only `include profile` is allowed any resource is bad
      resource_indexes.select { |r| r[:start] >= c[:start] and r[:end] <= c[:end] }.each do |r|
        notify :warning, {
          :message => "Roles must only `include profiles`",
          :line => r[:type].line,
          :column => r[:type].column,
        }
      end
      # each include must be followed with a profile
      tokens[c[:start]..c[:end]].select { |t| t.value == 'include' }.each do |t|
        unless t.next_code_token.value =~ /^profile(::|$)/
          notify :warning, {
            :message => "Roles must only `include profiles`",
            :line => t.line,
            :column => t.column
          }
        end
      end
    end
  end    
end
