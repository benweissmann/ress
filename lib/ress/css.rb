module Ress::CSS
  def self.convert ctx
    Converter.new(ctx).to_s
  end


  class Converter
    def initialize top_level_ctx
      @blocks = []

      top_level_ctx.children.each do |ctx|
        convert_recursive ctx
      end
    end

    def convert_recursive ctx, parent_selectors=['']
      # figure out the selectors for ctx, given that they're nested inside
      # the parent selectors
      selectors = parent_selectors.product ctx.selectors
      joiner = ctx.add_on ? '' : ' '
      selectors.map! {|pair| pair.join(joiner).strip}

      # create the SelectorBlock
      @blocks.push SelectorBlock.new(selectors, ctx.rules)

      ctx.children.each do |child|
        convert_recursive child, selectors
      end
    end

    def to_s
      @blocks.map(&:to_s).join("\n\n")
    end
  end


  class SelectorBlock
    attr_accessor :selectors
    attr_accessor :rules

    def initialize selectors = [], rules=[]
      @selectors = selectors
      @rules     = rules.map{ |pair| Rule.new(*pair) }
    end

    def to_s
      return selectors.join(', ') + " {\n" + rules.map(&:to_s).join("\n") + "\n}"
    end
  end


  class Rule
    def initialize property, value
      @property = property
      @value    = value
    end

    def property
      return @property.to_s.gsub '_', '-'
    end

    def to_s
      return "  #{property}: #{@value.to_s};"
    end
  end
end