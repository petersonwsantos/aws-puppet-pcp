#! /usr/bin/env ruby -S rspec
require 'spec_helper_acceptance'

describe 'concat function' do
  describe 'success' do
    it 'should concat one array to another' do
      pp = <<-EOS
      $output = concat(['1','2','3'],['4','5','6'])
      validate_array($output)
      if size($output) != 6 {
        fail("${output} should have 6 elements.")
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
    it 'should concat arrays and primitives to array' do
      pp = <<-EOS
      $output = concat(['1','2','3'],'4','5','6',['7','8','9'])
      validate_array($output)
      if size($output) != 9 {
        fail("${output} should have 9 elements.")
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
    it 'should concat multiple arrays to one' do
      pp = <<-EOS
      $output = concat(['1','2','3'],['4','5','6'],['7','8','9'])
      validate_array($output)
      if size($output) != 9 {
        fail("${output} should have 9 elements.")
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
    it 'should concat hash arguments' do
      pp = <<-EOS
      $output = concat([{"a" => "b"}], {"c" => "d", "e" => "f"})
      validate_array($output)
      if size($output) != 2 {
        fail("${output} should have 2 elements.")
      }
      if $output[1] != {"c" => "d", "e" => "f"} {
        fail("${output} does not have the expected hash for the second element.")
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
  end
end
