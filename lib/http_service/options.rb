# frozen_string_literal: true

module HTTPService
  module Options
    CLIENT_OPTIONS = {
      request: {
        timeout:       Integer(ENV.fetch('HTTP_TIMEOUT', 10)),
        open_timeout:  Integer(ENV.fetch('HTTP_OPEN_TIMEOUT', 5)),
        read_timeout:  Integer(ENV.fetch('HTTP_READ_TIMEOUT', 5)),
        write_timeout: Integer(ENV.fetch('HTTP_WRITE_TIMEOUT', 5))
      }
    }.freeze
    public_constant :CLIENT_OPTIONS

    LOGGER_OPTIONS = {
      headers:   {
        response: true,
        request:  false
      },
      bodies:    {
        response: true,
        request:  true
      },
      errors:    true,
      log_level: :debug
    }.freeze
    public_constant :LOGGER_OPTIONS

    PERSISTENT_OPTIONS = {
      pool_size:    Integer(ENV.fetch('HTTP_POOL_SIZE', '5')),
      idle_timeout: Integer(ENV.fetch('HTTP_IDLE_TIMEOUT', '20'))
    }.freeze
    public_constant :PERSISTENT_OPTIONS
  end
end
