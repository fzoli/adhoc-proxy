local max_idle_seconds = {{IDLE_TIMEOUT_SECONDS}}
local server_start_time = ngx.now()

local function get_last_request_time()
	local last_line = io.popen("tail -n 1 /var/log/nginx/access-json.log"):read("*line")
	if last_line == nil then
	  return server_start_time
	end
	local timestamp = string.match(last_line, '"timestamp":"([^"]+)"')
	local year, month, day, hour, min, sec, offset = string.match(timestamp, "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)(%S+)")
	local last_request_time = os.time({year=year, month=month, day=day, hour=hour, min=min, sec=sec})
	return last_request_time
	end

local function stop_nginx_if_idle(premature)
	if premature then
		return
	end
	local last_request_time_seconds = get_last_request_time()
	local now = ngx.now()
	if now - last_request_time_seconds >= max_idle_seconds then
		io.popen("/shutdown.sh")
	end
end

local polling_seconds = 5
local ok, err = ngx.timer.every(polling_seconds, stop_nginx_if_idle)
if not ok then
	ngx.log(ngx.ERR, "Failed to initiate scheduled job: ", err)
	return
end
