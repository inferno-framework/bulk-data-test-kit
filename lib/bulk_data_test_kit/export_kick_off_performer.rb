# frozen_string_literal: true

module BulkDataTestKit
  module ExportKickOffPerformer
    def perform_export_kick_off_request(use_token: true, params: {}, url: '')
      skip_if use_token && smart_auth_info.access_token.blank?, 'Could not verify this functionality when bearer token is not set'

      headers = { accept: 'application/fhir+json', prefer: 'respond-async' }
      headers.merge!({ authorization: "Bearer #{smart_auth_info.access_token}" }) if use_token

      param_str = params.map { |k, v| URI.encode_www_form(k => v) }.join('&')
      url.concat("?#{param_str}") unless param_str.empty?
      get(url, client: :bulk_server, name: :export, headers:)
    end

    def delete_export_kick_off_request
      polling_url = request&.response_header('content-location')&.value
      assert polling_url.present?, 'Export response header did not include "Content-Location"'

      headers = { accept: 'application/json', authorization: "Bearer #{smart_auth_info.access_token}" }

      delete(polling_url, headers:)
      assert_response_status(202)
    end
  end
end
