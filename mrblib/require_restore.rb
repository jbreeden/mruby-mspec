module Kernel
  alias require __require__ if Kernel.respond_to?(:__require__)
  alias require_relative __require_relative__ if Kernel.respond_to?(:__require_relative__)
  alias load __load__ if Kernel.respond_to?(:__load__)
end
