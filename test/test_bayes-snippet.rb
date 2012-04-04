require 'helper'

describe BayesSnippet do
  let(:model) { BayesSnippet.new(str) }
  subject { model.extract }

  context 'when str is given' do
    let(:str) { 'This is a sentence.' }
    should 'not be empty' do
      subject.wont_be_empty
    end
  end

  context 'after training classfier' do
    let(:str) { 'This is a sentence. This is another one that talks about classifiers.' }

    should 'pick the correct sentence' do
      model.train('Must say classifier.')
      model.train('classifiers are great.')
      model.reject('Ignore me this is a whole lot of nothing.')

      subject.must_equal 'This is another one that talks about classifiers.'
    end
  end
end