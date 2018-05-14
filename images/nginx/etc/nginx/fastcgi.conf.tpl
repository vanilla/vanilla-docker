fastcgi_param  QUERY_STRING       ${DOLLAR}query_string;
fastcgi_param  REQUEST_METHOD     ${DOLLAR}request_method;
fastcgi_param  CONTENT_TYPE       ${DOLLAR}content_type;
fastcgi_param  CONTENT_LENGTH     ${DOLLAR}content_length;

fastcgi_param  SCRIPT_NAME        ${DOLLAR}fastcgi_script_name;
fastcgi_param  REQUEST_URI        ${DOLLAR}request_uri;
fastcgi_param  DOCUMENT_URI       ${DOLLAR}fastcgi_path_info;
fastcgi_param  DOCUMENT_ROOT      ${DOLLAR}realpath_root;
fastcgi_param  SERVER_PROTOCOL    ${DOLLAR}server_protocol;
fastcgi_param  HTTPS              ${DOLLAR}https if_not_empty;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    nginx/${DOLLAR}nginx_version;

fastcgi_param  REMOTE_ADDR        ${DOLLAR}remote_addr;
fastcgi_param  REMOTE_PORT        ${DOLLAR}remote_port;
fastcgi_param  SERVER_ADDR        ${DOLLAR}server_addr;
fastcgi_param  SERVER_PORT        ${DOLLAR}server_port;
fastcgi_param  SERVER_NAME        ${DOLLAR}server_name;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param  REDIRECT_STATUS    200;

fastcgi_param  PATH_INFO          ${DOLLAR}fastcgi_path_info;
fastcgi_param  SCRIPT_FILENAME    ${DOLLAR}realpath_root${DOLLAR}fastcgi_script_name;

# http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_split_path_info
fastcgi_split_path_info ${FASTCGI_SPLIT_PATH_INFO};

fastcgi_intercept_errors ${FASTCGI_INTERCEPT_ERRORS};
fastcgi_ignore_client_abort ${FASTCGI_IGNORE_CLIENT_ABORT};
fastcgi_connect_timeout ${FASTCGI_CONNECT_TIMEOUT};
fastcgi_send_timeout ${FASTCGI_SEND_TIMEOUT};
fastcgi_read_timeout ${FASTCGI_READ_TIMEOUT};
fastcgi_buffer_size ${FASTCGI_BUFFER_SIZE};
fastcgi_buffers ${FASTCGI_BUFFERS};
fastcgi_busy_buffers_size ${FASTCGI_BUSY_BUFFERS_SIZE};
fastcgi_temp_file_write_size ${FASTCGI_TEMP_FILE_WRITE_SIZE};
