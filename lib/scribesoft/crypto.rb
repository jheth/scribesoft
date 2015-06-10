require 'openssl'

module Scribesoft
  class Crypto

    KEY_SIZE = 256
    BLOCK_SIZE = 128
    ITERATIONS = 1000
    SALT = 'ac103458-fcb6-41d3-94r0-43d25b4f4ff4'

    def initialize(api_crypto_token)
      @api_crypto_token = api_crypto_token
      @derived_key = generate_derived_key(@api_crypto_token)
    end

    # :param org_key: The Scribe-provided org cryptography key
    # :return: A reusable derived key
    def generate_derived_key(org_key)
      salted_password = OpenSSL::PKCS5.pbkdf2_hmac_sha1(org_key, SALT, ITERATIONS, 32)
      return Base64.strict_encode64(salted_password)
    end

    # :param plain_text_message: The string message that needs encrypting
    # :param derived_key: the pre-generated derived key
    # :return: A base64 string which includes a random initial vector and the encrypted message
    def encrypt(plain_text_message)
      derived_key = Base64.decode64(@derived_key)

      #cipher = AES.new(derived_key, AES.MODE_CBC, iv)
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.encrypt
      cipher.key = derived_key
      iv = cipher.random_iv

      if plain_text_message.nil? || plain_text_message.empty?
        encrypted = cipher.final
      else
        encrypted = cipher.update(plain_text_message) + cipher.final
      end

      # pad with pkcs7 encoder, this ensures we round up to a block of 16
      # encrypt the padded message with AES
      # base64 encode the encrypted message for transport
      # base64 encode the initial vector and prepend it to the message. Scribe will peel this off and use it to decrypt
      encrypted_message = Base64.strict_encode64(iv) + Base64.strict_encode64(encrypted)

      return encrypted_message
    end

    # :param encrypted_message: The base64 encoded message. First 24 characters of which are the IV.
    # :param derived_key: The Scribe-provided org cryptography derived_key
    # :return: The plain-text decrypted message
    def decrypt(encrypted_message)

      derived_key = Base64.decode64(@derived_key)
      iv = Base64.decode64(encrypted_message[0..24])

      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.decrypt
      cipher.key = derived_key
      cipher.iv = iv

      # Peel the message off of the passed-in encrypted string. Its everything past the iv (24 base64 bits)
      # Decode it from base64
      # decrypt the message
      # Unpad the decrypted message with pkcs7
      decrypted_message = cipher.update(Base64.decode64(encrypted_message[24..-1])) + cipher.final

      return decrypted_message
    end

    def run
      message = 'this is a message'

      encrypted = encrypt(message)
      decrypted = decrypt(encrypted)

      puts message.inspect
      puts encrypted.inspect
      puts decrypted.inspect
    end
  end
end