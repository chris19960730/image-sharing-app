# frozen_string_literal: true

class Image < ApplicationRecord
  acts_as_taggable_on :tags
  validates_presence_of :tag_list
  validates :name, presence: true
  validates :url, presence: true

  validate :image_url_valid?
  validate :tags_valid?

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
        errors.add(:url, "not image url")
      end
    else
      if !check_with_http(url)
        errors.add(:url, "not image url")
      end
    end
  end

  def validate_str(str)
    valid_chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["-"]
    str.chars.all? { |ch| valid_chars.include?(ch) }
  end

  def tags_valid?
    tags = self.tag_list
    puts "************************ *********************"
    puts tags
    if tags.blank?
      return false
    end

    tags.each do |tag|
      if !validate_str(tag)
        errors.add(:tag_list, "can only contain alphabet, number, and dash")
      end
    end
  end
end
