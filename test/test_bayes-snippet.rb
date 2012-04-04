require 'helper'

describe BayesSnippet do
  let(:model) { BayesSnippet.new }
  subject { model.extract(str) }

  context 'when str is given' do
    let(:str) { 'This is a sentence.' }
    should 'not be empty' do
      subject.wont_be_empty
    end
  end

  context 'when called multiple times' do
    should 'not return same results' do
      model.extract('First run.').must_equal 'First run.'
      model.extract('Second run.').must_equal 'Second run.'
    end
  end

  context 'after training classfier' do
    let(:str) { 'This is a sentence. This is another one that talks about classifiers.' }
    before do
      model.train('Must say classifier.')
      model.train('classifiers are great.')
      model.reject('Ignore me this is a whole lot of nothing.')      
      model.reject('This is a sentence.')      
    end

    should 'pick the correct sentence' do
      subject.must_equal 'This is another one that talks about classifiers.'
    end
  end
end