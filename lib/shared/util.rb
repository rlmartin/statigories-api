module Util
  ACCESS_KEY_PARAM = 'access_key'
  DATE_PARAM = 'date'
  SIGNATURE_PARAM = 'signature'
  RESERVED_PARAMS = [ACCESS_KEY_PARAM, DATE_PARAM, SIGNATURE_PARAM]
  API_TIME_LIMIT = 600 # In seconds.

  def Util.build_signature_string(asset, method, date, private_key, params)
    result = "#{method.upcase}\n#{asset}\n#{date.to_i}\n#{private_key}"
    canonicalize_params(params).each do |key, value|
      result += "\n#{key}=#{value}" unless RESERVED_PARAMS.include?(key)
    end
    result
  end


  def Util.canonicalize_params(params)
    param_list = {}
    params.each do |key,value|
      key = key.to_s.downcase.strip
      if param_list[key].nil?
        param_list[key] = value
      else
        param_list[key] = "#{param_list[key.to_s.downcase].strip},#{value.strip}"
      end
    end
    param_list.sort_by{ |key, value| key }
  end

  def Util.generate_random_string(num_chars = 20, possible_chars = "0123456789abcedfghijklmnopqrstuvwxyz".split(''))
    (0...num_chars).map{ possible_chars[rand(possible_chars.length)]}.join
  end

  def Util.generate_signature(asset, method, date, private_key, params)
    sha1(build_signature_string(asset, method, date, private_key, params))
  end

  def Util.md5(str)
    Digest::MD5.hexdigest(str)
  end

  def Util.sha1(str)
    Digest::SHA1.hexdigest(str)
  end

  def Util.t(name)
    I18n.t(name)
  end

  class AuthResult
    attr_accessor :api_key, :date, :partner, :request_signature, :signature, :signature_string

    def authenticate!(request, params)
      self.request_signature = params[SIGNATURE_PARAM]
      self.date = params[DATE_PARAM].to_i
      public_key = params[ACCESS_KEY_PARAM]
      self.api_key = ApiKey.find_by_public(public_key)
      unless self.api_key.nil?
        self.partner = api_key.partner
        self.signature_string = Util.build_signature_string(request.api_asset, request.method, self.date, self.api_key.private, request.non_path_parameters)
      end
      self.valid?
    end

    def AuthResult.create(request, params)
      Util.check_signature(request, params)
    end

    def error
      if self.request_signature.to_s == ''
        Util.t('errors.auth.not_attempted')
      elsif self.api_key.nil?
        Util.t('errors.auth.access_key_not_found')
      elsif self.signature != self.request_signature
        Util.t('errors.auth.invalid_signature')
      elsif (Time.now.to_i - date).abs > API_TIME_LIMIT
        Util.t('errors.auth.invalid_date')
      end
    end

    def signature
      Util.sha1(self.signature_string)
    end

    def to_s
      "Signature verified: #{self.valid?}\nError: #{self.error}\nGenerated signature: #{self.signature}\n#{self.signature_string.gsub(self.api_key.private, Util.t('msg.private_key_removed')) unless self.api_key.nil?}"
    end

    def valid?
      self.error.nil?
    end
  end
end