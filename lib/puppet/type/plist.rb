Puppet::Type.newtype(:plist) do
  desc "A puppet type for manipulating plist files using defaults"
  ensurable

  newparam(:name, :namevar => true) do
    desc "Namevar for the type"
  end

  newparam(:domain) do
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
  end
end 