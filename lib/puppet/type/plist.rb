Puppet::Type.newtype(:plist) do
  desc "A puppet type for manipulating plist files using defaults"
  ensurable

  newparam(:domain) do
    isnamevar
    # :namevar => true
    desc "The domain of the plist"
    validate do |value|
      fail("Domain must not end in .plist") if 
        value.end_with?('plist')
    end
  end

  newparam(:key) do
    desc "The name of the key to manage"
  end

  newparam(:type) do
    desc "The value type for the key being written"
    defaultto 'string'
    newvalues('string', 'data', 'int', 'float', 'bool', 'date', 'array', 'array-add', 'dict', 'dict-add')
  end

  newproperty(:value, :array_matching => :all) do
    desc "The value of the key being written"
    munge do |value|
      case value
      when 'true', 'True', 'TRUE'
        'TRUE' 
      when 'false', 'False', 'FALSE'
        'FALSE'
      else
        value
      end
    end
  end
end 