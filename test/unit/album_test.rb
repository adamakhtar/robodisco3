require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  subject { Factory(:album) }

  should have_and_belong_to_many(:users)
  should have_and_belong_to_many(:tracks)

  should validate_presence_of(:title)
  should validate_presence_of(:artist)
  should validate_presence_of(:mb_id)
  should validate_uniqueness_of(:mb_id)

  context "albums_favourited_by_everybody_but" do
    setup do
      @user = Factory(:user)
      @album = @user.albums.create(Factory.attributes_for(:album))

      @other_user = Factory(:user)
      @other_album = @other_user.albums.create(Factory.attributes_for(:album))
    end
    should "not return albums favourited by given user" do
      assert !Album.find_all_favourited_by_everybody_but(@user).include?(@album)
    end

    should "return other users favourited albums" do
      assert Album.find_all_favourited_by_everybody_but(@user).include?(@other_album)
    end
  end
end
