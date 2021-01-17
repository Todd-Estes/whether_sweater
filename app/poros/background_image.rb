class BackgroundImage
  attr_reader :id, :image

  def initialize(data, location)
    @id = nil
    @image = {
      location: location,
      image_url: data[:contentUrl],
      credit: {
        source: data[:hostPageUrl],
        author: data[:hostPageDomainFriendlyName],
        logo: data[:hostPageFavIconUrl]
        }
      }
    end
  end
