module Kernel
  alias __require__ require if Kernel.respond_to?(:require)
  alias __require_relative__ require_relative if Kernel.respond_to?(:require_relative)
  alias __load__ load if Kernel.respond_to?(:load)
  
  def require(*args)
    true
  end
  
  def require_relative(*args)
    true
  end
  
  def load(*args)
    true
  end
end
