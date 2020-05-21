# frozen_string_literal: true

class Image < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  validate :image_url_valid?

  # Define method to check if the Image URL is valid
  def check_with_http(url)
    url = URI.parse(url)
    Net::HTTP.start(url.host, url.port) do |http|
      begin
        return http.head(url.request_uri)["Content-Type"].start_with? "image"
      rescue Exception => e
        nil
      end
    end
  end

  def check_with_https(url)
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")

    http.start do |http|
      begin
        return http.head(url.request_uri)["Content-Type"].start_with? "image"
      rescue Exception => e
        nil
      end
    end
  end

  def image_url_valid?
    url = self.url
    if url.blank?
      return false
    end
    if url =~ /^https/
      if !check_with_https(url)
        errors.add(:url, "Invalid URL")
      end
    else
      if !check_with_http(url)
        errors.add(:url, "Invalid URL")
      end
    end
  end
end
