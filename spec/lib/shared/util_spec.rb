require 'spec_helper'

describe 'Util' do
  describe 'generate_signature' do
    it 'should produce the same string if the params are not in the same order' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      params2 = { :param3 => '3', :param1 => '1', :param2 => '2' }
      params1.keys.should_not == params2.keys
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should == Util.generate_signature('user', 'post', date, 'private_key', params2)
    end

    it 'should not produce the same string if the param values are different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      params2 = { :param1 => '4', :param2 => '2', :param3 => '3' }
      params1.should_not == params2
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('user', 'post', date, 'private_key', params2)
    end

    it 'should not produce the same string if the params are different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      params2 = { :param4 => '1', :param2 => '2', :param3 => '3' }
      params1.should_not == params2
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('user', 'post', date, 'private_key', params2)
    end

    it 'should produce the same string by filtering out reserved params' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3', Util::SIGNATURE_PARAM => 'signature' }
      params2 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      params1.should_not == params2
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should == Util.generate_signature('user', 'post', date, 'private_key', params2)
    end

    it 'should produce the same string if the method capitalization is different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should == Util.generate_signature('user', 'POST', date, 'private_key', params1)
    end

    it 'should not produce the same string if the methods are different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('user', 'get', date, 'private_key', params1)
    end

    it 'should not produce the same string if the asset capitalization is different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('USER', 'post', date, 'private_key', params1)
    end

    it 'should produce the same string if the assets are different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('users', 'post', date, 'private_key', params1)
    end

    it 'should not produce the same string if the private keys are different' do
      params1 = { :param1 => '1', :param2 => '2', :param3 => '3' }
      date = Time.now
      Util.generate_signature('user', 'post', date, 'private_key', params1).should_not == Util.generate_signature('user', 'post', date, 'Private_key', params1)
    end

  end
end