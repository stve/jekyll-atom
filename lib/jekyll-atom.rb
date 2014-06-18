require 'fileutils'
require File.expand_path('static_file', File.dirname(__FILE__))

module Jekyll
  class JekyllAtom < Jekyll::Generator
    safe true

    # Main plugin action, called by Jekyll-core
    def generate(site)
      @site = site
      @site.config["time"]         = Time.new
      unless feed_exists?
        write
        @site.keep_files ||= []
        @site.keep_files << "feed.atom"
      end
    end

    # Path to feed.atom template file
    def source_path
      File.expand_path "feed.atom", File.dirname(__FILE__)
    end

    # Destination for feed.atom file within the site source directory
    def destination_path
      File.expand_path "feed.atom", @site.dest
    end

    # copy feed template from source to destination
    def write
      FileUtils.mkdir_p File.dirname(destination_path)
      File.open(destination_path, 'w') { |f| f.write(feed_content) }
    end

    def feed_content
      site_map = Page.new(@site, File.dirname(__FILE__), "", "feed.atom")
      site_map.content = File.read(source_path)
      site_map.render(@site.layouts, @site.site_payload)
      site_map.output
    end

    # Checks if an atom feed already exists in the site source
    def feed_exists?
      File.exists? File.expand_path "feed.atom", @site.source
    end
  end
end
