#! /usr/bin/env ruby
require 'gennaro'

describe Gennaro do
  it 'has built-in templates' do
    template_path = File.expand_path '../../templates', __FILE__
    Gennaro.get_templates(template_path).should_not be_empty
  end

  it 'recognizes built-in templates' do
    template_path = File.expand_path '../../templates', __FILE__

    Gennaro.template_exists?(template_path, 'authentication' ).should be_true
    Gennaro.template_exists?(template_path, 'sono ammeregano').should be_false
  end

  it 'generates templates correctly' do
    template_path = File.expand_path '../../templates/authentication', __FILE__
    gennaro = Gennaro.new template_path, 'Example', Dir.pwd, false
    gennaro.generate!
    gennaro.replace_tags!

    Dir.exists?(File.join(Dir.pwd, 'example')).should be_true
    File.exists?(File.join(Dir.pwd, 'example', 'example.rb')).should be_true

    gennaro.delete_dir File.join(Dir.pwd, 'example')
  end
end