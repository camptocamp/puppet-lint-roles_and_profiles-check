PuppetLint.new_check(:node_definition) do

  def node_indexes
    @node_indexes ||= PuppetLint::Data.definition_indexes(:NODE)
  end

  def check
    node_indexes.each do |node|
      role_already_declared = false
      resource_indexes.select { |r| r[:start] > node[:start] and r[:end] < node[:end] }.each do |resource|
        if resource[:type].type != :CLASS or !resource[:type].next_code_token.next_code_token.value.start_with?('roles') or role_already_declared == true
          notify :warning, {
            :message => 'expected only one role declaration',
            :line    => resource[:type].line,
            :column  => resource[:type].column,
            :token   => resource,
          }
        end
        role_already_declared = true if resource[:type].type == :CLASS
      end
    end
  end
end

PuppetLint.new_check(:roles_class_params) do
  def check
    class_indexes.select {|c| c[:name_token].value.start_with?('roles')}.each do |klass|
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
      resource_indexes.select { |r| r[:start] > klass[:start] and r[:end] < klass[:end] }.each do |resource|
        if  resource[:type].type != :CLASS or !resource[:type].next_code_token.next_code_token.value.start_with?('profiles')
          notify :warning, {
            :message => 'expected no resource declaration',
            :line    => resource[:type].line,
            :column  => resource[:type].column,
          }
        end
      end
      tokens[klass[:start]..klass[:end]].select { |t| t.value == 'include' }.each do |token|
        if !token.next_code_token.value.start_with?('profiles')
          notify :warning, {
            :message => 'expected no resource declaration',
            :line    => token.line,
            :column  => token.column,
          }
        end
      end
    end
  end
end
