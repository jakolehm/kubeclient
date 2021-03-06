require_relative 'test_helper'

# Unit tests for the common module
class CommonTest < MiniTest::Test
  class ClientStub
    include Kubeclient::ClientMixin
  end

  def client
    @client ||= ClientStub.new
  end

  def test_underscore_entity
    %w[
      Pod pod
      Service service
      ReplicationController replication_controller
      Node node
      Event event
      Endpoint endpoint
      Namespace namespace
      Secret secret
      ResourceQuota resource_quota
      LimitRange limit_range
      PersistentVolume persistent_volume
      PersistentVolumeClaim persistent_volume_claim
      ComponentStatus component_status
      ServiceAccount service_account
      Project project
      Route route
      ClusterRoleBinding cluster_role_binding
      Build build
      BuildConfig build_config
      Image image
      ImageStream image_stream
    ].each_slice(2) do |singular, plural|
      assert_equal(Kubeclient::ClientMixin.underscore_entity(singular), plural)
    end
  end

  def test_format_datetime_with_string
    value = '2018-04-27T18:30:17.480321984Z'
    formatted = client.send(:format_datetime, value)
    assert_equal(formatted, value)
  end

  def test_format_datetime_with_datetime
    value = DateTime.new(2018, 4, 30, 19, 20, 33)
    formatted = client.send(:format_datetime, value)
    assert_equal(formatted, '2018-04-30T19:20:33.000000000+00:00')
  end

  def test_format_datetime_with_time
    value = Time.new(2018, 4, 30, 19, 20, 33, 0)
    formatted = client.send(:format_datetime, value)
    assert_equal(formatted, '2018-04-30T19:20:33.000000000+00:00')
  end
end
