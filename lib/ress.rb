module Ress
  def Ress.compile &block
    styles = Ress::DSL.evaluate &block
    Ress::CSS::convert styles
  end
end

Dir[File.join(File.dirname(__FILE__), 'ress', '**/*.rb')].each do |f|
  require f
end
