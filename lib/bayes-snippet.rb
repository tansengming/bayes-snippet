require 'tactful_tokenizer'
require 'classifier'

class BayesSnippet
  attr_reader :classifier
  attr_accessor :str

  @@sentence_tokenizer = TactfulTokenizer::Model.new

  def classifier
    @classifier ||= Classifier::Bayes.new 'snippet', 'reject'
  end

  def train(string)
    classifier.train(:snippet, string)
  end

  def reject(string)
    classifier.train(:reject, string)
  end

  def extract(str)
    self.str = str
    sentences.select{|sentence| classifier.classify(sentence) == 'Snippet'}.last
  end  

  private
  def sentences
    @@sentence_tokenizer.tokenize_text(str).reject{|s| s == ".  ."}
  end  
end