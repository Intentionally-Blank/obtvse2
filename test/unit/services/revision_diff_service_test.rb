require "test_helper"

class RevisionDiffServiceTest < ActiveSupport::TestCase

  def test_shows_no_difference_if_current_revision
    subject = RevisionDiffService.new(revisions("co-v2"))
    assert_equal "This revision is equal to the live version", subject.output
  end

  def test_shows_difference_if_not_current
    subject = RevisionDiffService.new(revisions("amp-v2"))
    assert subject.output.match(/diff/)
  end
end
