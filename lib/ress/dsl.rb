module Ress::DSL
  def self.evaluate &block
    Context.new &block
  end

  # Represents the context in which a selector block is executed
  class Context
    attr_accessor :selectors, :children, :parent, :add_on, :rules

    def initialize opts={}, &initializer
      # unpack opts into instance vars
      @selectors = opts[:selectors] || []
      @children = opts[:children] || []
      @parent = opts[:parent] || nil
      @add_on = false
      @rules = opts[:rules] || []
      @mixins = opts[:mixins] || {}

      # register self as a child of the parent
      if @parent
        @parent.children.push self
      end

      # run the initializer in the context of self
      self.instance_eval &initializer if initializer
    end

    # creates a new selector block nested inside this one
    def s *selectors, &block
      subctx = Context.new :parent => self, :selectors => selectors, &block
    end

    # defines a mixin
    def mixin name, &block
      @mixins[name] = block
    end

    # unary plus: makes this an add-on rather than a child block
    def +@
      @add_on = true
    end

    alias_method :method_missing_orig, :method_missing

    # missing methods are either CSS rules or mixin includes
    def method_missing method, *args, &block
      if mixin = resolve_mixin(method)
        self.instance_exec *args, &mixin
      else
        if args.length == 1
          @rules.push [method, args.first]
        else
          method_missing_orig method, *args, &block
        end
      end
    end

    protected

    # return a mixin Proc from this Context or any of its ancestors, or nil
    # if none exists
    def resolve_mixin name
      return @mixins[name]               if @mixins[name]
      return @parent.resolve_mixin(name) if @parent
      return nil
    end
  end
end