PuppetLint.new_check(:roles_class_params) do
  def check
    class_indexes.select {|c| c[:name_token].value.start_with?('role')}.each do |klass|
      unless klass[:param_tokens].nil?
        klass[:param_tokens].select {|t|t.type == :VARIABLE }.each do |token|
          notify :warning, {
            :message => 'expected no class parameters',
            :line    => token.line,
            :column  => token.column,
          }
        end
      end
    end
  end
end

PuppetLint.new_check(:roles_resource_declaration) do
  def check
    class_indexes.select {|c| c[:name_token].value.start_with?('role')}.each do |klass|
      resource_indexes.select { |r| r[:type].type != :CLASS and r[:start] > klass[:start] and r[:end] < klass[:end] }.each do |resource|
        notify :warning, {
          :message => 'expected no resource declaration',
          :line    => resource[:type].line,
          :column  => resource[:type].column,
        }
      end
    end
  end
end
