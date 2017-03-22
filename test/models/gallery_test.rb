require 'test_helper'

class GalleryTest < ActiveSupport::TestCase

  def setup
    @gallery = Bootsy::ImageGallery.new(bootsy_resource_type: "Post")
  end

  test "should be valid" do
    assert @gallery.valid?
  end
end