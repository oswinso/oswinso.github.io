require 'open3'

module Jekyll
  module ImageDimensions
    def publication_preview_width(input)
      dimensions = publication_preview_dimensions(input)
      dimensions && dimensions[:width]
    end

    def publication_preview_height(input)
      dimensions = publication_preview_dimensions(input)
      dimensions && dimensions[:height]
    end

    private

    def publication_preview_dimensions(input)
      return if input.nil?

      path = input.to_s
      return if path.empty? || path.include?('://')

      site = @context.registers[:site]
      cache = site.config['publication_preview_dimensions_cache'] ||= {}
      cache[path] ||= read_image_dimensions(site, path)
    end

    def read_image_dimensions(site, path)
      relative_path = path.start_with?('/') ? path.delete_prefix('/') : File.join('assets/img/publication_preview', path)
      absolute_path = File.expand_path(relative_path, site.source)
      return unless File.file?(absolute_path)

      output, error, status = Open3.capture3('identify', '-format', '%w %h', absolute_path)
      unless status.success?
        Jekyll.logger.warn 'ImageDimensions:', "identify failed for #{path}: #{error.strip}"
        return
      end

      width, height = output.split.map(&:to_i)
      return unless width.positive? && height.positive?

      { width: width, height: height }
    rescue StandardError => e
      Jekyll.logger.warn 'ImageDimensions:', "Could not read dimensions for #{path}: #{e.message}"
      nil
    end
  end
end

Liquid::Template.register_filter(Jekyll::ImageDimensions)
