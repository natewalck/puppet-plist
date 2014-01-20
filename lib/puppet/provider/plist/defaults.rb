require 'puppet'
Puppet::Type.type(:plist).provide(:defaults) do
  confine :osfamily => :Darwin
  defaultfor :osfamily => :Darwin

  commands :defaults => '/usr/bin/defaults'

  def exists?
    begin
      defaults('read', resource[:name], resource[:key])    
      true
    rescue
      false
    end
  end

  def create
    type = resource[:type]
    defaults('write', resource[:name], resource[:key], "-#{type}", resource[:value])
  end

  def destroy
    defaults('delete', resource[:name], resource[:key])
  end
end