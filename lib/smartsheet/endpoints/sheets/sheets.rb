require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'
require 'smartsheet/constants'
require 'smartsheet/error'

require 'smartsheet/endpoints/sheets/automation_rules'
require 'smartsheet/endpoints/sheets/cells'
require 'smartsheet/endpoints/sheets/columns'
require 'smartsheet/endpoints/sheets/comments'
require 'smartsheet/endpoints/sheets/cross_sheet_references'
require 'smartsheet/endpoints/sheets/discussions'
require 'smartsheet/endpoints/sheets/rows'
require 'smartsheet/endpoints/sheets/sheets_attachments'
require 'smartsheet/endpoints/sheets/sheets_summaries'
require 'smartsheet/endpoints/sheets/sheets_share'

module Smartsheet
  # Sheets Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#sheets API Sheets Docs
  #
  # @!attribute [r] attachments
  #   @return [SheetsAttachments]
  # @!attribute [r] automation_rules
  #   @return [AutomationRules]
  # @!attribute [r] cells
  #   @return [Cells]
  # @!attribute [r] columns
  #   @return [Columns]
  # @!attribute [r] comments
  #   @return [Comments]
  # @!attribute [r] cross_sheet_references
  #   @return [CrossSheetReferences]
  # @!attribute [r] discussions
  #   @return [Discussions]
  # @!attribute [r] summaries
  #   @return [Summaries]
  # @!attribute [r] rows
  #   @return [Rows]
  # @!attribute [r] share
  #   @return [SheetsShare]
  class Sheets
    include Smartsheet::Constants

    attr_reader :client, :attachments, :automation_rules, :cells, :columns, :comments,
        :cross_sheet_references, :discussions, :summaries, :rows, :share
    private :client

    def initialize(client)
      @client = client

      @attachments = SheetsAttachments.new(client)
      @automation_rules = AutomationRules.new(client)
      @cells = Cells.new(client)
      @columns = Columns.new(client)
      @comments = Comments.new(client)
      @cross_sheet_references = CrossSheetReferences.new(client)
      @discussions = Discussions.new(client)
      @summaries = SheetsSummaries.new(client)
      @rows = Rows.new(client)
      @share = SheetsShare.new(client)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_version(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'version'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_as_excel(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['sheets', :sheet_id],
          headers: {Accept: EXCEL_TYPE}
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_as_pdf(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['sheets', :sheet_id],
          headers: {Accept: PDF_TYPE}
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_as_csv(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['sheets', :sheet_id],
          headers: {Accept: CSV_TYPE}
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_folder(folder_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['folders', :folder_id, 'sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_workspace(workspace_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['workspaces', :workspace_id, 'sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_from_template(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_folder_from_template(folder_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['folders', :folder_id, 'sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_workspace_from_template(workspace_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['workspaces', :workspace_id, 'sheets'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file(file:, file_type:, file_length:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportObjectFileSpec.new(file, file_length, content_type)
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file_path(path:, file_type:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportPathFileSpec.new(path, content_type)
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file_into_folder(
        folder_id:,
        file:,
        file_type:,
        file_length:,
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['folders', :folder_id, 'sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportObjectFileSpec.new(file, file_length, content_type),
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file_path_into_folder(
        folder_id:,
        path:,
        file_type:,
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['folders', :folder_id, 'sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportPathFileSpec.new(path, content_type),
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file_into_workspace(
        workspace_id:,
        file:,
        file_type:,
        file_length:,
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['workspaces', :workspace_id, 'sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportObjectFileSpec.new(file, file_length, content_type),
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def import_from_file_path_into_workspace(
        workspace_id:,
        path:,
        file_type:,
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['workspaces', :workspace_id, 'sheets', 'import'],
          body_type: :file
      )
      content_type = file_type_to_content_type(file_type)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          file_spec: Smartsheet::API::ImportPathFileSpec.new(path, content_type),
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    ### These endpoints are not yet implemented; these endpoints can be re-included once they are
    ### active

    # def import_and_replace_sheet_from_file(
    #     sheet_id:,
    #     file:,
    #     file_type:,
    #     file_length:,
    #     params: {},
    #     header_overrides: {}
    # )
    #   endpoint_spec = Smartsheet::API::EndpointSpec.new(
    #       :post,
    #       ['sheets', :sheet_id, 'import'],
    #       body_type: :file
    #   )
    #   content_type = file_type_to_content_type(file_type)
    #   request_spec = Smartsheet::API::RequestSpec.new(
    #       params: params,
    #       header_overrides: header_overrides,
    #       file_spec: Smartsheet::API::ImportObjectFileSpec.new(file, file_length, content_type)
    #   )
    #   client.make_request(endpoint_spec, request_spec)
    # end

    # def import_and_replace_sheet_from_file_path(
    #     sheet_id:,
    #     path:,
    #     file_type:,
    #     params: {},
    #     header_overrides: {}
    # )
    #   endpoint_spec = Smartsheet::API::EndpointSpec.new(
    #       :post,
    #       ['sheets', :sheet_id, 'import'],
    #       body_type: :file
    #   )
    #   content_type = file_type_to_content_type(file_type)
    #   request_spec = Smartsheet::API::RequestSpec.new(
    #       params: params,
    #       header_overrides: header_overrides,
    #       file_spec: Smartsheet::API::ImportPathFileSpec.new(path, content_type)
    #   )
    #   client.make_request(endpoint_spec, request_spec)
    # end

    def copy(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'copy'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def move(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'move'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :put,
          ['sheets', :sheet_id],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :delete,
          ['sheets', :sheet_id]
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_for_org(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get,['users', 'sheets'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_publish_status(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get,['sheets', :sheet_id, 'publish'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def set_publish_status(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put,['sheets', :sheet_id, 'publish'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def send_via_email(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post,['sheets', :sheet_id, 'emails'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_image_urls(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post,['imageurls'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    private

    def file_type_to_content_type(file_type)
      mapping = {
        csv: Constants::CSV_TYPE,
        xlsx: Constants::OPENXML_SPREADSHEET_TYPE
      }

      mapping.fetch(file_type) do |_|
        available_types = mapping.keys.join(', ')

        raise Smartsheet::Error.new(
          "Unsupported file type: #{file_type}\nValid types: #{available_types}"
        )
      end
    end
  end
end
